import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../tables/cars_table.dart';

part 'cars_dao.g.dart';

@DriftAccessor(tables: [Cars])
class CarsDao extends DatabaseAccessor<AppDatabase> with _$CarsDaoMixin {
  CarsDao(super.attachedDatabase);

  Stream<List<CarRecord>> watchAll() {
    return (select(cars)..orderBy([(c) => OrderingTerm.asc(c.id)])).watch();
  }

  Future<CarRecord?> getById(int id) {
    return (select(cars)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertCar(CarsCompanion car) => into(cars).insert(car);

  Future<void> updateCar(int id, CarsCompanion car) {
    return (update(cars)..where((c) => c.id.equals(id))).write(car);
  }

  Future<void> deleteCar(int id) {
    return (delete(cars)..where((c) => c.id.equals(id))).go();
  }
}
