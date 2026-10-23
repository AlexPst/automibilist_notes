import 'package:drift/drift.dart';

import '../daos/reminders_dao.dart';
import '../database/app_database.dart';
import '../models/reminder.dart';
import '../models/reminder_draft.dart';

class RemindersRepository {
  RemindersRepository(this._dao);

  final RemindersDao _dao;

  Stream<List<Reminder>> watchForCar(int carId) =>
      _dao.watchForCar(carId).map((rows) => rows.map(_toReminder).toList());

  Stream<List<Reminder>> watchAll() =>
      _dao.watchAll().map((rows) => rows.map(_toReminder).toList());

  Future<Reminder?> getById(int id) async {
    final row = await _dao.getById(id);
    return row == null ? null : _toReminder(row);
  }

  Future<int> add(ReminderDraft draft) =>
      _dao.insertReminder(_toCompanion(draft));

  /// Изменение сбрасывает отметку об уведомлении по пробегу:
  /// срок мог сдвинуться.
  Future<void> update(int id, ReminderDraft draft) =>
      _dao.updateReminder(id, _toCompanion(draft));

  Future<void> delete(int id) => _dao.deleteReminder(id);

  /// Запоминает, что об этом сроке по пробегу уже сообщили.
  Future<void> markMileageNotified(int id, int dueMileage) {
    return _dao.updateReminder(
      id,
      RemindersCompanion(notifiedDueMileage: Value(dueMileage)),
    );
  }

  Reminder _toReminder(ReminderRecord row) {
    return Reminder(
      id: row.id,
      carId: row.carId,
      title: row.title,
      intervalKm: row.intervalKm,
      intervalMonths: row.intervalMonths,
      lastDoneDate: row.lastDoneDate,
      lastDoneMileage: row.lastDoneMileage,
      advanceDays: row.advanceDays,
      advanceKm: row.advanceKm,
      notifiedDueMileage: row.notifiedDueMileage,
    );
  }

  RemindersCompanion _toCompanion(ReminderDraft draft) {
    final date = draft.lastDoneDate;
    return RemindersCompanion(
      carId: Value(draft.carId),
      title: Value(draft.title),
      intervalKm: Value(draft.intervalKm),
      intervalMonths: Value(draft.intervalMonths),
      lastDoneDate: Value(DateTime(date.year, date.month, date.day)),
      lastDoneMileage: Value(draft.lastDoneMileage),
      advanceDays: Value(draft.advanceDays),
      advanceKm: Value(draft.advanceKm),
      notifiedDueMileage: const Value(null),
    );
  }
}
