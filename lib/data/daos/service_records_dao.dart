import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../tables/service_records_table.dart';

part 'service_records_dao.g.dart';

@DriftAccessor(tables: [ServiceRecords])
class ServiceRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$ServiceRecordsDaoMixin {
  ServiceRecordsDao(super.attachedDatabase);

  /// Записи ТО автомобиля, новые сверху.
  Stream<List<ServiceRecordRow>> watchForCar(int carId) {
    return (select(serviceRecords)
          ..where((s) => s.carId.equals(carId))
          ..orderBy([
            (s) => OrderingTerm.desc(s.date),
            (s) => OrderingTerm.desc(s.mileage),
            (s) => OrderingTerm.desc(s.id),
          ]))
        .watch();
  }

  Future<ServiceRecordRow?> getById(int id) {
    return (select(
      serviceRecords,
    )..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertRecord(ServiceRecordsCompanion record) =>
      into(serviceRecords).insert(record);

  Future<void> updateRecord(int id, ServiceRecordsCompanion record) {
    return (update(
      serviceRecords,
    )..where((s) => s.id.equals(id))).write(record);
  }

  Future<void> deleteRecord(int id) {
    return (delete(serviceRecords)..where((s) => s.id.equals(id))).go();
  }
}
