import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../daos/cars_dao.dart';
import '../daos/expenses_dao.dart';
import '../daos/fuel_dao.dart';
import '../daos/reminders_dao.dart';
import '../daos/service_records_dao.dart';
import '../daos/settings_dao.dart';
import '../models/expense_category.dart';
import '../models/fuel_type.dart';
import '../tables/cars_table.dart';
import '../tables/expenses_table.dart';
import '../tables/fuel_entries_table.dart';
import '../tables/reminders_table.dart';
import '../tables/service_records_table.dart';
import '../tables/settings_table.dart';
import 'app_database.steps.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Cars, FuelEntries, Expenses, Reminders, ServiceRecords, Settings],
  daos: [
    CarsDao,
    FuelDao,
    ExpensesDao,
    RemindersDao,
    ServiceRecordsDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'cardiary'));

  /// При изменении схемы: увеличить версию, выполнить
  /// `dart run drift_dev make-migrations` и описать шаг в [migration].
  ///
  /// История версий:
  /// 1 — автомобили и настройки;
  /// 2 — заправки (fuel_entries);
  /// 3 — прочие расходы (expenses);
  /// 4 — напоминания и записи ТО (reminders, service_records).
  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.fuelEntries);
      },
      from2To3: (m, schema) async {
        await m.createTable(schema.expenses);
      },
      from3To4: (m, schema) async {
        await m.createTable(schema.reminders);
        await m.createTable(schema.serviceRecords);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
