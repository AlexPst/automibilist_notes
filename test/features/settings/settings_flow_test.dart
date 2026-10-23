import 'dart:convert';

import 'package:cardiary/core/utils/formatters.dart';
import 'package:cardiary/data/backup/backup_service.dart';
import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_file_transfer.dart';
import '../../helpers/test_app.dart';
import '../../helpers/test_database.dart';

void main() {
  tearDown(() => displayFormat = const DisplayFormat());

  final today = DateTime.now();

  Future<void> openSettings(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Настройки'));
    await tester.pumpAndSettle();
  }

  Future<void> back(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Назад'));
    await tester.pumpAndSettle();
  }

  Future<void> tapKey(WidgetTester tester, String key) async {
    final finder = find.byKey(Key(key));
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('тема переключается', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openSettings(tester);

    await tester.tap(find.text('Тёмная'));
    await tester.pumpAndSettle();

    final context = tester.element(find.text('Настройки').first);
    expect(Theme.of(context).brightness, Brightness.dark);
  });

  testWidgets('валюта и единицы расхода меняются везде', (tester) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      fuel: [
        testFuelDraft(
          date: today.subtract(const Duration(days: 2)),
          mileage: 12500,
        ),
        testFuelDraft(date: today, mileage: 13000, liters: 40),
      ],
    );
    expect(find.text('8,0 л/100 км'), findsOneWidget);

    await openSettings(tester);
    await tapKey(tester, 'settings_currency');
    await tester.tap(find.text(r'Доллар США ($)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('км/л'));
    await tester.pumpAndSettle();
    await back(tester);

    // 8 л/100 км = 12,5 км/л; суммы — с новым знаком.
    expect(find.text('12,5 км/л'), findsOneWidget);
    expect(find.textContaining(r'$'), findsWidgets);
    expect(find.textContaining('₽'), findsNothing);
  });

  testWidgets('восстановление: сводка, подтверждение, данные вернулись', (
    tester,
  ) async {
    final files = FakeFileTransfer();
    final db = await pumpTestApp(
      tester,
      cars: [testCarDraft(brand: 'Lada', model: 'Vesta')],
      fuel: [testFuelDraft(date: today, mileage: 13000)],
      files: files,
    );
    await openSettings(tester);
    await tapKey(tester, 'settings_backup');
    await tester.tap(find.text('Сохранить в файл'));
    await tester.pumpAndSettle();

    // Добавили лишний автомобиль после копии.
    await db.carsDao.insertCar(
      CarsCompanion.insert(
        brand: 'Kia',
        model: 'Rio',
        fuelType: FuelType.ai92,
        initialMileage: 0,
      ),
    );
    await tester.pumpAndSettle();

    files.fileToPick = files.saved.values.single;
    await tapKey(tester, 'settings_restore');
    expect(find.text('Восстановить данные?'), findsOneWidget);
    expect(find.textContaining('автомобилей — 1'), findsOneWidget);
    expect(find.textContaining('заправок — 1'), findsOneWidget);
    // Восстановление пишет фото на диск — настоящий ввод-вывод
    // в тестах виджетов выполняется только внутри runAsync.
    await tester.tap(find.widgetWithText(FilledButton, 'Восстановить'));
    for (var i = 0; i < 10; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();

    expect(find.text('Данные восстановлены'), findsOneWidget);
    final cars = await db.select(db.cars).get();
    expect(cars.map((c) => c.brand), ['Lada']);
  });

  testWidgets('не тот файл — понятная ошибка, данные целы', (tester) async {
    final files = FakeFileTransfer()..fileToPick = utf8.encode('привет');
    final db = await pumpTestApp(tester, cars: [testCarDraft()], files: files);
    await openSettings(tester);

    await tapKey(tester, 'settings_restore');

    expect(
      find.text(
        'Это не резервная копия «Дневника автомобилиста» или файл повреждён',
      ),
      findsOneWidget,
    );
    expect(await db.select(db.cars).get(), hasLength(1));
  });

  testWidgets('отчёт CSV по активному автомобилю', (tester) async {
    final files = FakeFileTransfer();
    await pumpTestApp(
      tester,
      cars: [testCarDraft(brand: 'Lada', model: 'Vesta')],
      fuel: [testFuelDraft(date: today, mileage: 13000)],
      files: files,
    );
    await openSettings(tester);

    await tapKey(tester, 'settings_csv');
    await tester.tap(find.text('Отправить'));
    await tester.pumpAndSettle();

    final name = files.shared.keys.single;
    expect(name, startsWith('cardiary-lada-vesta-'));
    expect(name, endsWith('.csv'));
  });

  testWidgets('после переустановки: восстановление прямо с онбординга', (
    tester,
  ) async {
    // Копия со «старого» телефона.
    final oldDb = createTestDatabase();
    await CarsRepository(
      oldDb.carsDao,
      createTestPhotoStorage(),
    ).add(testCarDraft(brand: 'Lada', model: 'Vesta'));
    final backup = await BackupService(
      oldDb,
      createTestPhotoStorage(),
    ).export(DateTime(2026, 10, 23));

    // Чистая установка.
    final files = FakeFileTransfer()..fileToPick = backup;
    await pumpTestApp(tester, files: files);
    expect(find.text('Добавьте первый автомобиль'), findsOneWidget);

    await tester.tap(find.text('Восстановить из резервной копии'));
    await tester.pumpAndSettle();
    expect(find.textContaining('автомобилей — 1'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Восстановить'));
    for (var i = 0; i < 10; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();

    // Онбординг сменился Главной с восстановленным автомобилем.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Lada Vesta'), findsOneWidget);
  });
}
