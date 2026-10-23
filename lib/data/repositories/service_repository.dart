import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../models/service_record.dart';
import '../models/service_record_draft.dart';

class ServiceRepository {
  ServiceRepository(this._db);

  final AppDatabase _db;

  Stream<List<ServiceRecord>> watchForCar(int carId) => _db.serviceRecordsDao
      .watchForCar(carId)
      .map((rows) => rows.map(_toRecord).toList());

  Future<ServiceRecord?> getById(int id) async {
    final row = await _db.serviceRecordsDao.getById(id);
    return row == null ? null : _toRecord(row);
  }

  /// Добавляет запись; если выбрано напоминание — продлевает его.
  Future<int> add(ServiceRecordDraft draft) {
    return _db.transaction(() async {
      final id = await _db.serviceRecordsDao.insertRecord(_toCompanion(draft));
      await _extendReminder(draft);
      return id;
    });
  }

  Future<void> update(int id, ServiceRecordDraft draft) {
    return _db.transaction(() async {
      await _db.serviceRecordsDao.updateRecord(id, _toCompanion(draft));
      await _extendReminder(draft);
    });
  }

  Future<void> delete(int id) => _db.serviceRecordsDao.deleteRecord(id);

  /// Следующий срок напоминания считается от этой записи, если она
  /// не старше уже известного выполнения.
  Future<void> _extendReminder(ServiceRecordDraft draft) async {
    final reminderId = draft.reminderId;
    if (reminderId == null) return;
    final reminder = await _db.remindersDao.getById(reminderId);
    if (reminder == null) return;

    final date = _dayOf(draft.date);
    if (date.isBefore(reminder.lastDoneDate)) return;

    await _db.remindersDao.updateReminder(
      reminderId,
      RemindersCompanion(
        lastDoneDate: Value(date),
        lastDoneMileage: Value(draft.mileage),
        notifiedDueMileage: const Value(null),
      ),
    );
  }

  ServiceRecord _toRecord(ServiceRecordRow row) {
    return ServiceRecord(
      id: row.id,
      carId: row.carId,
      reminderId: row.reminderId,
      title: row.title,
      date: row.date,
      mileage: row.mileage,
      cost: row.cost,
      station: row.station,
      comment: row.comment,
    );
  }

  ServiceRecordsCompanion _toCompanion(ServiceRecordDraft draft) {
    return ServiceRecordsCompanion(
      carId: Value(draft.carId),
      reminderId: Value(draft.reminderId),
      title: Value(draft.title),
      date: Value(_dayOf(draft.date)),
      mileage: Value(draft.mileage),
      cost: Value(draft.cost),
      station: Value(draft.station),
      comment: Value(draft.comment),
    );
  }

  static DateTime _dayOf(DateTime d) => DateTime(d.year, d.month, d.day);
}
