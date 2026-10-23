import 'package:cardiary/data/models/reminder.dart';
import 'package:cardiary/features/service/domain/mileage_alerts.dart';
import 'package:cardiary/features/service/domain/notification_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Reminder reminder({
    int id = 1,
    int? intervalKm,
    int? intervalMonths,
    DateTime? lastDate,
    int? lastMileage,
    int advanceDays = 7,
    int advanceKm = 500,
    int? notified,
  }) => Reminder(
    id: id,
    carId: 1,
    title: 'Напоминание $id',
    intervalKm: intervalKm,
    intervalMonths: intervalMonths,
    lastDoneDate: lastDate ?? DateTime(2026, 3, 15),
    lastDoneMileage: lastMileage,
    advanceDays: advanceDays,
    advanceKm: advanceKm,
    notifiedDueMileage: notified,
  );

  group('уведомления по дате', () {
    final osago = reminder(id: 4, intervalMonths: 12, advanceDays: 14);

    test('заранее и в день срока, в 10:00', () {
      final plan = planDateNotifications([osago], DateTime(2026, 10, 23));

      expect(plan, hasLength(2));
      expect(plan[0].id, advanceNotificationId(4));
      expect(plan[0].kind, DateNotificationKind.advance);
      expect(plan[0].time, DateTime(2027, 3, 1, 10));
      expect(plan[1].id, dueDayNotificationId(4));
      expect(plan[1].kind, DateNotificationKind.dueDay);
      expect(plan[1].time, DateTime(2027, 3, 15, 10));
    });

    test('прошедшее время не планируется', () {
      // Предупреждение уже было, сам срок впереди.
      final plan = planDateNotifications([osago], DateTime(2027, 3, 5));
      expect(plan.map((p) => p.kind), [DateNotificationKind.dueDay]);

      // В день срока после 10:00 — ничего.
      expect(
        planDateNotifications([osago], DateTime(2027, 3, 15, 11)),
        isEmpty,
      );
    });

    test('«за 0 дней» — только в день срока', () {
      final r = reminder(intervalMonths: 6, advanceDays: 0);
      final plan = planDateNotifications([r], DateTime(2026, 4, 1));
      expect(plan.map((p) => p.kind), [DateNotificationKind.dueDay]);
    });

    test('напоминания только по пробегу не планируются', () {
      final r = reminder(intervalKm: 10000, lastMileage: 16000);
      expect(planDateNotifications([r], DateTime(2026, 4, 1)), isEmpty);
    });

    test('у каждого напоминания свои идентификаторы', () {
      final ids = {
        for (final id in [1, 2, 3]) ...[
          advanceNotificationId(id),
          dueDayNotificationId(id),
          mileageNotificationId(id),
        ],
      };
      expect(ids, hasLength(9));
    });
  });

  group('оповещения по пробегу', () {
    final oil = reminder(id: 1, intervalKm: 10000, lastMileage: 16000);

    test('далеко до срока — тихо', () {
      expect(mileageAlerts([oil], 25499), isEmpty);
    });

    test('осталось 500 км — сообщаем', () {
      final alerts = mileageAlerts([oil], 25500);
      expect(alerts, hasLength(1));
      expect(alerts.single.dueMileage, 26000);
      expect(alerts.single.kmLeft, 500);
    });

    test('срок пройден — тоже сообщаем', () {
      expect(mileageAlerts([oil], 27000).single.kmLeft, -1000);
    });

    test('о том же сроке второй раз не сообщаем', () {
      final notified = reminder(
        id: 1,
        intervalKm: 10000,
        lastMileage: 16000,
        notified: 26000,
      );
      expect(mileageAlerts([notified], 26500), isEmpty);
    });

    test('после продления — новый срок, новое оповещение', () {
      final extended = reminder(
        id: 1,
        intervalKm: 10000,
        lastMileage: 26000,
        notified: 26000,
      );
      expect(mileageAlerts([extended], 35600).single.dueMileage, 36000);
    });

    test('напоминания только по дате не участвуют', () {
      expect(mileageAlerts([reminder(intervalMonths: 12)], 99999), isEmpty);
    });
  });

  test('текущий пробег — наибольший из всех', () {
    expect(currentMileageOf(15000, []), 15000);
    expect(currentMileageOf(15000, [16000, 16600, 16300]), 16600);
    expect(currentMileageOf(15000, [100]), 15000);
  });
}
