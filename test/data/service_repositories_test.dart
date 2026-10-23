import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/models/reminder_draft.dart';
import 'package:cardiary/data/models/service_record_draft.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/repositories/reminders_repository.dart';
import 'package:cardiary/data/repositories/service_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late RemindersRepository reminders;
  late ServiceRepository service;
  late CarsRepository cars;
  late int carId;

  setUp(() async {
    db = createTestDatabase();
    reminders = RemindersRepository(db.remindersDao);
    service = ServiceRepository(db);
    cars = CarsRepository(db.carsDao, createTestPhotoStorage());
    carId = await cars.add(testCarDraft());
  });

  ReminderDraft oil() => ReminderDraft(
    carId: carId,
    title: 'Замена масла',
    intervalKm: 10000,
    intervalMonths: 12,
    lastDoneDate: DateTime(2026, 3, 15, 12),
    lastDoneMileage: 16000,
  );

  ServiceRecordDraft record({
    int? reminderId,
    required DateTime date,
    int mileage = 26000,
  }) => ServiceRecordDraft(
    carId: carId,
    reminderId: reminderId,
    title: 'Замена масла',
    date: date,
    mileage: mileage,
    cost: 4500,
    station: 'СТО на Ленина',
  );

  test('напоминание сохраняется со всеми полями', () async {
    final id = await reminders.add(oil());
    final r = (await reminders.getById(id))!;
    expect(r.title, 'Замена масла');
    expect(r.intervalKm, 10000);
    expect(r.intervalMonths, 12);
    expect(r.lastDoneDate, DateTime(2026, 3, 15));
    expect(r.lastDoneMileage, 16000);
    expect(r.advanceDays, 7);
    expect(r.advanceKm, 500);
    expect(r.notifiedDueMileage, isNull);
  });

  test('отметка об оповещении сбрасывается при изменении', () async {
    final id = await reminders.add(oil());
    await reminders.markMileageNotified(id, 26000);
    expect((await reminders.getById(id))!.notifiedDueMileage, 26000);

    await reminders.update(id, oil());
    expect((await reminders.getById(id))!.notifiedDueMileage, isNull);
  });

  test('запись ТО продлевает напоминание', () async {
    final id = await reminders.add(oil());
    await reminders.markMileageNotified(id, 26000);

    await service.add(record(reminderId: id, date: DateTime(2026, 10, 20)));

    final r = (await reminders.getById(id))!;
    expect(r.lastDoneDate, DateTime(2026, 10, 20));
    expect(r.lastDoneMileage, 26000);
    expect(r.notifiedDueMileage, isNull);
  });

  test('запись старше последнего выполнения не сдвигает срок назад', () async {
    final id = await reminders.add(oil());

    await service.add(
      record(reminderId: id, date: DateTime(2025, 12, 1), mileage: 9000),
    );

    final r = (await reminders.getById(id))!;
    expect(r.lastDoneDate, DateTime(2026, 3, 15));
    expect(r.lastDoneMileage, 16000);
  });

  test('запись без напоминания ничего не продлевает', () async {
    final id = await reminders.add(oil());
    await service.add(record(date: DateTime(2026, 10, 20)));
    expect((await reminders.getById(id))!.lastDoneMileage, 16000);
  });

  test('история: новые сверху, все поля', () async {
    await service.add(record(date: DateTime(2026, 5, 1), mileage: 20000));
    await service.add(record(date: DateTime(2026, 10, 1), mileage: 25000));

    final list = await service.watchForCar(carId).first;
    expect(list.map((r) => r.mileage), [25000, 20000]);
    expect(list.first.cost, 4500);
    expect(list.first.station, 'СТО на Ленина');
  });

  test('при удалении напоминания запись ТО остаётся', () async {
    final reminderId = await reminders.add(oil());
    final recordId = await service.add(
      record(reminderId: reminderId, date: DateTime(2026, 10, 20)),
    );

    await reminders.delete(reminderId);

    final r = (await service.getById(recordId))!;
    expect(r.reminderId, isNull);
  });

  test('при удалении авто удаляются напоминания и записи', () async {
    final reminderId = await reminders.add(oil());
    final recordId = await service.add(record(date: DateTime(2026, 10, 20)));

    await cars.delete(carId);

    expect(await reminders.getById(reminderId), isNull);
    expect(await service.getById(recordId), isNull);
  });
}
