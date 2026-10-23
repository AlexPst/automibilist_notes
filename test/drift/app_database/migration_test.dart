// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:cardiary/data/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('миграция v1 → v2 сохраняет автомобили и настройки', () async {
    const oldCars = [
      v1.CarsData(
        id: 1,
        brand: 'Lada',
        model: 'Vesta',
        year: 2019,
        plateNumber: 'А 123 ВС 77',
        fuelType: 'ai95',
        tankVolume: 55,
        initialMileage: 15000,
        photoFileName: 'car_1.jpg',
        createdAt: 1760000000,
      ),
      v1.CarsData(
        id: 2,
        brand: 'Kia',
        model: 'Rio',
        fuelType: 'ai92',
        initialMileage: 0,
        createdAt: 1760000100,
      ),
    ];
    const expectedCars = [
      v2.CarsData(
        id: 1,
        brand: 'Lada',
        model: 'Vesta',
        year: 2019,
        plateNumber: 'А 123 ВС 77',
        fuelType: 'ai95',
        tankVolume: 55,
        initialMileage: 15000,
        photoFileName: 'car_1.jpg',
        createdAt: 1760000000,
      ),
      v2.CarsData(
        id: 2,
        brand: 'Kia',
        model: 'Rio',
        fuelType: 'ai92',
        initialMileage: 0,
        createdAt: 1760000100,
      ),
    ];
    const oldSettings = [v1.SettingsData(key: 'active_car_id', value: '2')];
    const expectedSettings = [
      v2.SettingsData(key: 'active_car_id', value: '2'),
    ];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.cars, oldCars);
        batch.insertAll(oldDb.settings, oldSettings);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.cars).get(), expectedCars);
        expect(await newDb.select(newDb.settings).get(), expectedSettings);
        expect(await newDb.select(newDb.fuelEntries).get(), isEmpty);
      },
    );
  });

  test('миграция v2 → v3 сохраняет автомобили, заправки и настройки', () async {
    const oldCars = [
      v2.CarsData(
        id: 1,
        brand: 'Lada',
        model: 'Vesta',
        fuelType: 'ai95',
        initialMileage: 15000,
        createdAt: 1760000000,
      ),
    ];
    const oldFuel = [
      v2.FuelEntriesData(
        id: 1,
        carId: 1,
        date: 1761080000,
        mileage: 16000,
        liters: 40,
        pricePerLiter: 50,
        totalCost: 2000,
        isFullTank: 1,
        station: 'Лукойл',
      ),
      v2.FuelEntriesData(
        id: 2,
        carId: 1,
        date: 1761090000,
        mileage: 16300,
        liters: 15,
        pricePerLiter: 50,
        totalCost: 750,
        isFullTank: 0,
        comment: 'неполный',
      ),
    ];
    const oldSettings = [v2.SettingsData(key: 'active_car_id', value: '1')];

    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.cars, oldCars);
        batch.insertAll(oldDb.fuelEntries, oldFuel);
        batch.insertAll(oldDb.settings, oldSettings);
      },
      validateItems: (newDb) async {
        expect(
          (await newDb.select(newDb.cars).get()).map((c) => c.toJson()),
          oldCars.map((c) => c.toJson()),
        );
        expect(
          (await newDb.select(newDb.fuelEntries).get()).map((f) => f.toJson()),
          oldFuel.map((f) => f.toJson()),
        );
        expect(
          (await newDb.select(newDb.settings).get()).map((s) => s.toJson()),
          oldSettings.map((s) => s.toJson()),
        );
        expect(await newDb.select(newDb.expenses).get(), isEmpty);
      },
    );
  });

  test('миграция v3 → v4 сохраняет все данные', () async {
    const oldCars = [
      v3.CarsData(
        id: 1,
        brand: 'Lada',
        model: 'Vesta',
        fuelType: 'ai95',
        initialMileage: 15000,
        createdAt: 1760000000,
      ),
    ];
    const oldFuel = [
      v3.FuelEntriesData(
        id: 1,
        carId: 1,
        date: 1761080000,
        mileage: 16000,
        liters: 40,
        pricePerLiter: 50,
        totalCost: 2000,
        isFullTank: 1,
      ),
    ];
    const oldExpenses = [
      v3.ExpensesData(
        id: 1,
        carId: 1,
        date: 1761080000,
        category: 'wash',
        amount: 650,
        mileage: 16600,
        comment: 'Керхер',
      ),
    ];
    const oldSettings = [v3.SettingsData(key: 'active_car_id', value: '1')];

    await verifier.testWithDataIntegrity(
      oldVersion: 3,
      newVersion: 4,
      createOld: v3.DatabaseAtV3.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.cars, oldCars);
        batch.insertAll(oldDb.fuelEntries, oldFuel);
        batch.insertAll(oldDb.expenses, oldExpenses);
        batch.insertAll(oldDb.settings, oldSettings);
      },
      validateItems: (newDb) async {
        Future<List<Map<String, dynamic>>> json<T extends Table, R>(
          TableInfo<T, R> table,
        ) async {
          final rows = await newDb.select(table).get();
          return rows
              .map((r) => (r as dynamic).toJson())
              .cast<Map<String, dynamic>>()
              .toList();
        }

        expect(await json(newDb.cars), oldCars.map((r) => r.toJson()));
        expect(await json(newDb.fuelEntries), oldFuel.map((r) => r.toJson()));
        expect(await json(newDb.expenses), oldExpenses.map((r) => r.toJson()));
        expect(await json(newDb.settings), oldSettings.map((r) => r.toJson()));
        expect(await newDb.select(newDb.reminders).get(), isEmpty);
        expect(await newDb.select(newDb.serviceRecords).get(), isEmpty);
      },
    );
  });
}
