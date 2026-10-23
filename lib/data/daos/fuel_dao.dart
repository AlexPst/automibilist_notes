import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../tables/fuel_entries_table.dart';

part 'fuel_dao.g.dart';

@DriftAccessor(tables: [FuelEntries])
class FuelDao extends DatabaseAccessor<AppDatabase> with _$FuelDaoMixin {
  FuelDao(super.attachedDatabase);

  /// Заправки автомобиля, новые сверху.
  Stream<List<FuelEntryRecord>> watchForCar(int carId) {
    return (select(fuelEntries)
          ..where((f) => f.carId.equals(carId))
          ..orderBy([
            (f) => OrderingTerm.desc(f.date),
            (f) => OrderingTerm.desc(f.mileage),
            (f) => OrderingTerm.desc(f.id),
          ]))
        .watch();
  }

  Future<FuelEntryRecord?> getById(int id) {
    return (select(
      fuelEntries,
    )..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertEntry(FuelEntriesCompanion entry) =>
      into(fuelEntries).insert(entry);

  Future<void> updateEntry(int id, FuelEntriesCompanion entry) {
    return (update(fuelEntries)..where((f) => f.id.equals(id))).write(entry);
  }

  Future<void> deleteEntry(int id) {
    return (delete(fuelEntries)..where((f) => f.id.equals(id))).go();
  }
}
