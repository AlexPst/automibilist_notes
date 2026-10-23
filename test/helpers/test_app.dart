import 'package:cardiary/app.dart';
import 'package:cardiary/core/analytics/analytics_providers.dart';
import 'package:cardiary/core/files/file_providers.dart';
import 'package:cardiary/core/notifications/notification_providers.dart';
import 'package:cardiary/core/startup/first_launch.dart';
import 'package:flutter/widgets.dart';
import 'package:cardiary/data/data_providers.dart';
import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/models/car_draft.dart';
import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/data/models/expense_draft.dart';
import 'package:cardiary/data/models/fuel_entry_draft.dart';
import 'package:cardiary/data/models/reminder_draft.dart';
import 'package:cardiary/data/models/service_record_draft.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'fake_analytics.dart';
import 'fake_file_transfer.dart';
import 'fake_notification_service.dart';
import 'test_database.dart';

CarDraft testCarDraft({String brand = 'Lada', String model = 'Vesta'}) {
  return CarDraft(
    brand: brand,
    model: model,
    fuelType: FuelType.ai95,
    initialMileage: 12000,
  );
}

FuelEntryDraft testFuelDraft({
  int carId = 1,
  required DateTime date,
  required int mileage,
  double liters = 40,
  double price = 50,
  bool isFullTank = true,
}) {
  return FuelEntryDraft(
    carId: carId,
    date: date,
    mileage: mileage,
    liters: liters,
    pricePerLiter: price,
    totalCost: liters * price,
    isFullTank: isFullTank,
  );
}

ExpenseDraft testExpenseDraft({
  int carId = 1,
  required DateTime date,
  required ExpenseCategory category,
  required double amount,
  int? mileage,
  String? comment,
}) {
  return ExpenseDraft(
    carId: carId,
    date: date,
    category: category,
    amount: amount,
    mileage: mileage,
    comment: comment,
  );
}

/// Запускает приложение на базе в памяти; возвращает базу для подготовки
/// данных и проверок.
Future<AppDatabase> pumpTestApp(
  WidgetTester tester, {
  List<CarDraft> cars = const [],
  List<FuelEntryDraft> fuel = const [],
  List<ExpenseDraft> expenses = const [],
  List<ReminderDraft> reminders = const [],
  List<ServiceRecordDraft> serviceRecords = const [],
  FakeNotificationService? notifications,
  FakeFileTransfer? files,
  FakeAnalytics? analytics,
  bool firstLaunch = false,
}) async {
  await initializeDateFormatting('ru');

  // Экран как у Pixel 8.
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2.625;
  addTearDown(tester.view.reset);

  final db = createTestDatabase();
  final photos = createTestPhotoStorage();
  final container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      carPhotoStorageProvider.overrideWithValue(photos),
      notificationServiceProvider.overrideWithValue(
        notifications ?? FakeNotificationService(),
      ),
      fileTransferProvider.overrideWithValue(files ?? FakeFileTransfer()),
    ],
  );
  addTearDown(container.dispose);

  if (analytics != null) {
    container.read(analyticsHolderProvider.notifier).use(analytics);
  }

  // Экран первого запуска нужен только в тестах про него.
  if (!firstLaunch) {
    await container.read(settingsRepositoryProvider).markFirstLaunchDone();
  }
  await container.read(isFirstLaunchProvider.future);

  final repository = container.read(carsRepositoryProvider);
  for (final car in cars) {
    await repository.add(car);
  }
  for (final entry in fuel) {
    await container.read(fuelRepositoryProvider).add(entry);
  }
  for (final expense in expenses) {
    await container.read(expensesRepositoryProvider).add(expense);
  }
  for (final reminder in reminders) {
    await container.read(remindersRepositoryProvider).add(reminder);
  }
  for (final record in serviceRecords) {
    await container.read(serviceRepositoryProvider).add(record);
  }

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CarDiaryApp()),
  );
  // Анимация загрузки бесконечная — pumpAndSettle не дождётся конца.
  if (firstLaunch) {
    await tester.pump();
  } else {
    await tester.pumpAndSettle();
  }
  return db;
}
