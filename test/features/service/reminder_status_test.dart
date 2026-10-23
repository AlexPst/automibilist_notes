import 'package:cardiary/data/models/reminder.dart';
import 'package:cardiary/features/service/domain/reminder_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Reminder reminder({
    int? intervalKm,
    int? intervalMonths,
    DateTime? lastDate,
    int? lastMileage,
    int advanceDays = 7,
    int advanceKm = 500,
  }) => Reminder(
    id: 1,
    carId: 1,
    title: 'Масло',
    intervalKm: intervalKm,
    intervalMonths: intervalMonths,
    lastDoneDate: lastDate ?? DateTime(2026, 1, 15),
    lastDoneMileage: lastMileage,
    advanceDays: advanceDays,
    advanceKm: advanceKm,
  );

  group('addMonths', () {
    test('обычный случай', () {
      expect(addMonths(DateTime(2026, 3, 15), 12), DateTime(2027, 3, 15));
      expect(addMonths(DateTime(2026, 11, 10), 3), DateTime(2027, 2, 10));
    });

    test('31 января + 1 месяц = последний день февраля', () {
      expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
      expect(addMonths(DateTime(2028, 1, 31), 1), DateTime(2028, 2, 29));
    });

    test('29 февраля + 12 месяцев = 28 февраля', () {
      expect(addMonths(DateTime(2028, 2, 29), 12), DateTime(2029, 2, 28));
    });
  });

  test('дни считаются по календарю, без учёта времени', () {
    expect(daysBetween(DateTime(2026, 3, 28, 23), DateTime(2026, 3, 30)), 2);
    expect(daysBetween(DateTime(2026, 3, 30), DateTime(2026, 3, 28)), -2);
  });

  group('срок по дате', () {
    final r = reminder(intervalMonths: 12, lastDate: DateTime(2026, 3, 15));

    test('далеко — в порядке', () {
      final s = reminderStatus(
        r,
        today: DateTime(2026, 10, 1),
        currentMileage: null,
      );
      expect(s.dueDate, DateTime(2027, 3, 15));
      expect(s.dueMileage, isNull);
      expect(s.urgency, ReminderUrgency.ok);
    });

    test('за 7 дней — скоро', () {
      final s = reminderStatus(
        r,
        today: DateTime(2027, 3, 8),
        currentMileage: null,
      );
      expect(s.daysLeft, 7);
      expect(s.urgency, ReminderUrgency.soon);
    });

    test('в день срока — ещё не просрочено', () {
      final s = reminderStatus(
        r,
        today: DateTime(2027, 3, 15, 18),
        currentMileage: null,
      );
      expect(s.daysLeft, 0);
      expect(s.urgency, ReminderUrgency.soon);
    });

    test('на следующий день — просрочено', () {
      final s = reminderStatus(
        r,
        today: DateTime(2027, 3, 16),
        currentMileage: null,
      );
      expect(s.daysLeft, -1);
      expect(s.urgency, ReminderUrgency.overdue);
    });
  });

  group('срок по пробегу', () {
    final r = reminder(intervalKm: 10000, lastMileage: 16000);

    test('срок = последний пробег + интервал', () {
      final s = reminderStatus(
        r,
        today: DateTime(2026, 10, 1),
        currentMileage: 20000,
      );
      expect(s.dueMileage, 26000);
      expect(s.kmLeft, 6000);
      expect(s.urgency, ReminderUrgency.ok);
    });

    test('осталось 500 км — скоро', () {
      final s = reminderStatus(
        r,
        today: DateTime(2026, 10, 1),
        currentMileage: 25500,
      );
      expect(s.urgency, ReminderUrgency.soon);
    });

    test('достигли срока — просрочено', () {
      final s = reminderStatus(
        r,
        today: DateTime(2026, 10, 1),
        currentMileage: 26000,
      );
      expect(s.kmLeft, 0);
      expect(s.urgency, ReminderUrgency.overdue);
    });

    test('пробег неизвестен — остатка нет', () {
      final s = reminderStatus(
        r,
        today: DateTime(2026, 10, 1),
        currentMileage: null,
      );
      expect(s.kmLeft, isNull);
      expect(s.urgency, ReminderUrgency.ok);
    });
  });

  test('пробег и дата: срабатывает то, что раньше', () {
    final r = reminder(
      intervalKm: 10000,
      intervalMonths: 12,
      lastDate: DateTime(2026, 3, 15),
      lastMileage: 16000,
    );
    // По дате далеко, по пробегу уже пора.
    final s = reminderStatus(
      r,
      today: DateTime(2026, 6, 1),
      currentMileage: 26100,
    );
    expect(s.urgency, ReminderUrgency.overdue);
  });

  test('сортировка: просроченные, скоро, в порядке; внутри — ближайшие', () {
    const overdue = ReminderStatus(
      urgency: ReminderUrgency.overdue,
      daysLeft: -3,
    );
    const soonFar = ReminderStatus(urgency: ReminderUrgency.soon, daysLeft: 6);
    const soonNear = ReminderStatus(urgency: ReminderUrgency.soon, daysLeft: 1);
    const ok = ReminderStatus(urgency: ReminderUrgency.ok, kmLeft: 5000);

    final sorted = [ok, soonFar, overdue, soonNear]
      ..sort(compareReminderStatus);
    expect(sorted, [overdue, soonNear, soonFar, ok]);
  });
}
