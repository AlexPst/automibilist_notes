import 'package:drift/drift.dart';

import '../daos/fuel_dao.dart';
import '../database/app_database.dart';
import '../models/fuel_entry.dart';
import '../models/fuel_entry_draft.dart';

class FuelRepository {
  FuelRepository(this._dao);

  final FuelDao _dao;

  /// Заправки автомобиля, новые сверху.
  Stream<List<FuelEntry>> watchForCar(int carId) {
    return _dao.watchForCar(carId).map((rows) => rows.map(_toEntry).toList());
  }

  Future<FuelEntry?> getById(int id) async {
    final row = await _dao.getById(id);
    return row == null ? null : _toEntry(row);
  }

  Future<int> add(FuelEntryDraft draft) =>
      _dao.insertEntry(_toCompanion(draft));

  Future<void> update(int id, FuelEntryDraft draft) =>
      _dao.updateEntry(id, _toCompanion(draft));

  Future<void> delete(int id) => _dao.deleteEntry(id);

  FuelEntry _toEntry(FuelEntryRecord row) {
    return FuelEntry(
      id: row.id,
      carId: row.carId,
      date: row.date,
      mileage: row.mileage,
      liters: row.liters,
      pricePerLiter: row.pricePerLiter,
      totalCost: row.totalCost,
      isFullTank: row.isFullTank,
      station: row.station,
      comment: row.comment,
    );
  }

  FuelEntriesCompanion _toCompanion(FuelEntryDraft draft) {
    return FuelEntriesCompanion(
      carId: Value(draft.carId),
      // Храним только день: время заправки не важно.
      date: Value(DateTime(draft.date.year, draft.date.month, draft.date.day)),
      mileage: Value(draft.mileage),
      liters: Value(draft.liters),
      pricePerLiter: Value(draft.pricePerLiter),
      totalCost: Value(draft.totalCost),
      isFullTank: Value(draft.isFullTank),
      station: Value(draft.station),
      comment: Value(draft.comment),
    );
  }
}
