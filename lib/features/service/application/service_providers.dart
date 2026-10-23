import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/notifications/notification_providers.dart';
import '../../../data/data_providers.dart';
import '../../../data/models/car.dart';
import '../../../data/models/reminder.dart';
import '../../../data/models/service_record.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../expenses/application/expenses_providers.dart';
import '../../fuel/application/fuel_providers.dart';
import '../domain/mileage_alerts.dart';
import '../domain/reminder_status.dart';
import 'reminder_notifications.dart';

part 'service_providers.g.dart';

@riverpod
Stream<List<Reminder>> reminders(Ref ref, int carId) {
  return ref.watch(remindersRepositoryProvider).watchForCar(carId);
}

@Riverpod(keepAlive: true)
Stream<List<Reminder>> allReminders(Ref ref) {
  return ref.watch(remindersRepositoryProvider).watchAll();
}

@riverpod
Future<Reminder?> reminder(Ref ref, int id) {
  return ref.watch(remindersRepositoryProvider).getById(id);
}

/// Записи ТО автомобиля, новые сверху.
@riverpod
Stream<List<ServiceRecord>> serviceRecords(Ref ref, int carId) {
  return ref.watch(serviceRepositoryProvider).watchForCar(carId);
}

@riverpod
Future<ServiceRecord?> serviceRecord(Ref ref, int id) {
  return ref.watch(serviceRepositoryProvider).getById(id);
}

/// Текущий пробег автомобиля по всем записям; `null`, пока грузится.
@riverpod
int? currentMileage(Ref ref, int carId) {
  final car = ref.watch(carByIdProvider(carId));
  final fuel = ref.watch(fuelEntriesProvider(carId)).value;
  final expenses = ref.watch(expensesProvider(carId)).value;
  final service = ref.watch(serviceRecordsProvider(carId)).value;
  if (car == null || fuel == null || expenses == null || service == null) {
    return null;
  }
  return currentMileageOf(car.initialMileage, [
    ...fuel.map((e) => e.mileage),
    ...expenses.map((e) => e.mileage).nonNulls,
    ...service.map((e) => e.mileage),
  ]);
}

/// Напоминание вместе с его текущим состоянием.
class ReminderWithStatus {
  const ReminderWithStatus(this.reminder, this.status);

  final Reminder reminder;
  final ReminderStatus status;
}

/// Напоминания автомобиля: сначала просроченные, затем ближайшие.
@riverpod
List<ReminderWithStatus>? reminderStatuses(Ref ref, int carId) {
  final reminders = ref.watch(remindersProvider(carId)).value;
  if (reminders == null) return null;
  final mileage = ref.watch(currentMileageProvider(carId));
  final today = DateTime.now();
  return [
    for (final r in reminders)
      ReminderWithStatus(
        r,
        reminderStatus(r, today: today, currentMileage: mileage),
      ),
  ]..sort((a, b) => compareReminderStatus(a.status, b.status));
}

@Riverpod(keepAlive: true)
ReminderNotifications reminderNotifications(Ref ref) {
  return ReminderNotifications(
    ref.watch(notificationServiceProvider),
    ref.watch(remindersRepositoryProvider),
    lookupAppLocalizations(const Locale('ru')),
  );
}

/// Данные для расписания уведомлений по дате.
class NotificationScheduleInput {
  const NotificationScheduleInput(this.reminders, this.cars);

  final List<Reminder> reminders;
  final Map<int, Car> cars;
}

@riverpod
NotificationScheduleInput? notificationScheduleInput(Ref ref) {
  final reminders = ref.watch(allRemindersProvider).value;
  final cars = ref.watch(carsListProvider).value;
  if (reminders == null || cars == null) return null;
  return NotificationScheduleInput(reminders, {for (final c in cars) c.id: c});
}

/// Данные для проверки сроков по пробегу у активного автомобиля.
class MileageCheckInput {
  const MileageCheckInput(this.car, this.reminders, this.mileage);

  final Car car;
  final List<Reminder> reminders;
  final int mileage;
}

@riverpod
MileageCheckInput? mileageCheckInput(Ref ref) {
  final car = ref.watch(activeCarProvider);
  if (car == null) return null;
  final reminders = ref.watch(remindersProvider(car.id)).value;
  final mileage = ref.watch(currentMileageProvider(car.id));
  if (reminders == null || mileage == null) return null;
  return MileageCheckInput(car, reminders, mileage);
}
