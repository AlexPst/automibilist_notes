import 'dart:convert';
import 'dart:io';

import 'package:cardiary/core/settings/app_settings.dart';
import 'package:cardiary/data/backup/backup_service.dart';
import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/models/car_draft.dart';
import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:cardiary/data/models/reminder_draft.dart';
import 'package:cardiary/data/models/service_record_draft.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/repositories/expenses_repository.dart';
import 'package:cardiary/data/repositories/fuel_repository.dart';
import 'package:cardiary/data/repositories/reminders_repository.dart';
import 'package:cardiary/data/repositories/service_repository.dart';
import 'package:cardiary/data/repositories/settings_repository.dart';
import 'package:cardiary/data/storage/car_photo_storage.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_database.dart';

void main() {
  final now = DateTime(2026, 10, 23, 12);

  /// Все строки всех таблиц — для сравнения баз.
  Future<Map<String, List<Map<String, dynamic>>>> dump(AppDatabase db) async {
    Future<List<Map<String, dynamic>>> rows<T extends Table, R>(
      TableInfo<T, R> t,
    ) async => [
      for (final r in await db.select(t).get()) (r as dynamic).toJson(),
    ];
    return {
      'cars': await rows(db.cars),
      'fuel': await rows(db.fuelEntries),
      'expenses': await rows(db.expenses),
      'reminders': await rows(db.reminders),
      'service': await rows(db.serviceRecords),
      'settings': [
        for (final r in await rows(db.settings))
          if (r['key'] != 'first_launch_done') r,
      ],
    };
  }

  String fakePhoto(List<int> bytes) {
    final dir = Directory.systemTemp.createTempSync('picked_');
    addTearDown(() => dir.deleteSync(recursive: true));
    return (File('${dir.path}/p.jpg')..writeAsBytesSync(bytes)).path;
  }

  /// База со всеми видами данных.
  Future<(AppDatabase, CarPhotoStorage)> filledDatabase() async {
    final db = createTestDatabase();
    final photos = createTestPhotoStorage();
    final cars = CarsRepository(db.carsDao, photos);
    final carId = await cars.add(
      CarDraft(
        brand: 'Lada',
        model: 'Vesta',
        fuelType: FuelType.ai95,
        initialMileage: 15000,
        year: 2019,
        photoPath: fakePhoto([1, 2, 3, 4]),
      ),
    );
    await cars.add(testCarDraft(brand: 'Kia', model: 'Rio'));
    await FuelRepository(db.fuelDao).add(
      testFuelDraft(carId: carId, date: DateTime(2026, 10, 1), mileage: 16000),
    );
    await ExpensesRepository(db.expensesDao).add(
      testExpenseDraft(
        carId: carId,
        date: DateTime(2026, 10, 2),
        category: ExpenseCategory.wash,
        amount: 650.5,
        comment: 'с «кавычками»; и точкой с запятой',
      ),
    );
    final reminders = RemindersRepository(db.remindersDao);
    final reminderId = await reminders.add(
      ReminderDraft(
        carId: carId,
        title: 'Масло',
        intervalKm: 10000,
        lastDoneDate: DateTime(2026, 3, 1),
        lastDoneMileage: 15000,
      ),
    );
    await reminders.markMileageNotified(reminderId, 25000);
    await ServiceRepository(db).add(
      ServiceRecordDraft(
        carId: carId,
        reminderId: reminderId,
        title: 'Масло',
        date: DateTime(2025, 1, 1),
        mileage: 9000,
        cost: 4500,
      ),
    );
    final settings = SettingsRepository(db.settingsDao);
    await settings.setActiveCarId(carId);
    await settings.setCurrency(Currency.usd);
    await settings.markFirstLaunchDone();
    return (db, photos);
  }

  test('копия → восстановление в другой базе даёт те же данные', () async {
    final (source, sourcePhotos) = await filledDatabase();
    final bytes = await BackupService(source, sourcePhotos).export(now);

    // Вторая база — как после переустановки, но с чужими данными и фото.
    final target = createTestDatabase();
    final targetPhotos = createTestPhotoStorage();
    await CarsRepository(
      target.carsDao,
      targetPhotos,
    ).add(testCarDraft(brand: 'Чужая'));
    final strayPhoto = targetPhotos.resolve('car_stray.jpg');
    await targetPhotos.directory.create(recursive: true);
    await strayPhoto.writeAsBytes([9]);

    final service = BackupService(target, targetPhotos);
    final backup = service.read(bytes);
    expect(backup.createdAt, now);
    expect((backup.cars, backup.fuelEntries, backup.expenses), (2, 1, 1));
    expect((backup.reminders, backup.serviceRecords), (1, 1));

    await service.restore(backup);

    expect(await dump(target), await dump(source));
    // Фото на месте и с тем же содержимым, чужое — удалено.
    final car = (await target.select(target.cars).get()).first;
    expect(await targetPhotos.resolve(car.photoFileName!).readAsBytes(), [
      1,
      2,
      3,
      4,
    ]);
    expect(await strayPhoto.exists(), isFalse);
  });

  test('отметка первого запуска не переносится и не стирается', () async {
    final (source, photos) = await filledDatabase();
    final bytes = await BackupService(source, photos).export(now);
    expect(utf8.decode(bytes), isNot(contains('first_launch_done')));

    final target = createTestDatabase();
    final settings = SettingsRepository(target.settingsDao);
    await settings.markFirstLaunchDone();
    final service = BackupService(target, createTestPhotoStorage());
    await service.restore(service.read(bytes));

    expect(await settings.isFirstLaunchDone(), isTrue);
  });

  group('проверка файла', () {
    late BackupService service;
    late Uint8List valid;

    setUp(() async {
      final (db, photos) = await filledDatabase();
      service = BackupService(db, photos);
      valid = await service.export(now);
    });

    Uint8List edit(void Function(Map<String, dynamic>) change) {
      final json = jsonDecode(utf8.decode(valid)) as Map<String, dynamic>;
      change(json);
      return utf8.encode(jsonEncode(json));
    }

    Matcher problem(BackupProblem p) =>
        isA<BackupException>().having((e) => e.problem, 'problem', p);

    test('не JSON', () {
      expect(
        () => service.read(Uint8List.fromList([0xff, 0x00, 0x12])),
        throwsA(problem(BackupProblem.invalidFile)),
      );
      expect(
        () => service.read(utf8.encode('просто текст')),
        throwsA(problem(BackupProblem.invalidFile)),
      );
    });

    test('чужой JSON', () {
      expect(
        () => service.read(edit((j) => j['format'] = 'other-app')),
        throwsA(problem(BackupProblem.invalidFile)),
      );
      expect(
        () => service.read(edit((j) => j.remove('expenses'))),
        throwsA(problem(BackupProblem.invalidFile)),
      );
    });

    test('копия от более новой версии', () {
      expect(
        () => service.read(edit((j) => j['schemaVersion'] = 999)),
        throwsA(problem(BackupProblem.newerVersion)),
      );
    });

    test('битая строка: ошибка, текущие данные целы', () async {
      final target = createTestDatabase();
      await CarsRepository(
        target.carsDao,
        createTestPhotoStorage(),
      ).add(testCarDraft(brand: 'Моя'));
      final targetService = BackupService(target, createTestPhotoStorage());

      final broken = targetService.read(
        edit((j) => (j['fuelEntries'] as List).first['liters'] = 'много'),
      );

      await expectLater(
        targetService.restore(broken),
        throwsA(problem(BackupProblem.invalidFile)),
      );
      final cars = await target.select(target.cars).get();
      expect(cars.map((c) => c.brand), ['Моя']);
    });
  });

  test('имя файла копии', () {
    expect(BackupService.fileName(now), 'cardiary-2026-10-23.json');
  });
}
