import 'package:cardiary/data/models/car.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:cardiary/data/models/reminder_draft.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/repositories/reminders_repository.dart';
import 'package:cardiary/features/service/application/reminder_notifications.dart';
import 'package:cardiary/features/service/domain/notification_plan.dart';
import 'package:cardiary/l10n/app_localizations_ru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fake_notification_service.dart';
import '../../helpers/test_app.dart';
import '../../helpers/test_database.dart';

void main() {
  late FakeNotificationService fake;
  late RemindersRepository reminders;
  late ReminderNotifications service;
  late Car car;

  setUpAll(() => initializeDateFormatting('ru'));

  setUp(() async {
    final db = createTestDatabase();
    final carId = await CarsRepository(
      db.carsDao,
      createTestPhotoStorage(),
    ).add(testCarDraft());
    car = Car(
      id: carId,
      brand: 'Lada',
      model: 'Vesta',
      fuelType: FuelType.ai95,
      initialMileage: 15000,
    );
    fake = FakeNotificationService();
    reminders = RemindersRepository(db.remindersDao);
    service = ReminderNotifications(fake, reminders, AppLocalizationsRu());
  });

  test('расписание: уведомления с понятным текстом', () async {
    final id = await reminders.add(
      ReminderDraft(
        carId: car.id,
        title: 'ОСАГО',
        intervalMonths: 12,
        lastDoneDate: DateTime(2026, 3, 15),
        advanceDays: 14,
      ),
    );

    await service.reschedule(await reminders.watchAll().first, {
      car.id: car,
    }, DateTime(2026, 10, 23));

    expect(fake.scheduled.keys, [
      advanceNotificationId(id),
      dueDayNotificationId(id),
    ]);
    final advance = fake.scheduled[advanceNotificationId(id)]!;
    expect(advance.time, DateTime(2027, 3, 1, 10));
    expect(advance.title, 'Скоро: ОСАГО');
    expect(
      advance.body.replaceAll(RegExp('[\u00A0\u202F]'), ' '),
      'Lada Vesta · срок 15 мар. 2027 г.',
    );
    expect(
      fake.scheduled[dueDayNotificationId(id)]!.title,
      'Сегодня срок: ОСАГО',
    );
  });

  test('расписание пересобирается целиком', () async {
    fake.scheduled[999] = (time: DateTime(2030), title: 'старое', body: '');
    await service.reschedule(const [], {car.id: car}, DateTime(2026, 10, 23));
    expect(fake.scheduled, isEmpty);
  });

  test('пробег: сообщаем один раз за срок', () async {
    final id = await reminders.add(
      ReminderDraft(
        carId: car.id,
        title: 'Замена масла',
        intervalKm: 10000,
        lastDoneDate: DateTime(2026, 3, 15),
        lastDoneMileage: 16000,
      ),
    );

    var alerts = await service.checkMileage(
      car,
      await reminders.watchForCar(car.id).first,
      26100,
    );
    expect(alerts, hasLength(1));
    expect(fake.shown.single.id, mileageNotificationId(id));
    expect(fake.shown.single.title, 'Пора: Замена масла');
    expect(
      fake.shown.single.body.replaceAll(' ', ' '),
      'Lada Vesta · срок 26 000 км, сейчас 26 100 км',
    );

    // Следующая заправка — повторного оповещения нет.
    alerts = await service.checkMileage(
      car,
      await reminders.watchForCar(car.id).first,
      26400,
    );
    expect(alerts, isEmpty);
    expect(fake.shown, hasLength(1));
  });
}
