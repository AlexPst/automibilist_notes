import '../../../data/models/reminder.dart';
import 'reminder_status.dart';

/// Час, в который приходят уведомления по дате.
const reminderNotificationHour = 10;

enum DateNotificationKind {
  /// За [Reminder.advanceDays] дней до срока.
  advance,

  /// В день срока.
  dueDay,
}

/// Уведомление по дате, которое нужно поставить в расписание.
class PlannedNotification {
  const PlannedNotification({
    required this.id,
    required this.time,
    required this.reminder,
    required this.kind,
    required this.dueDate,
  });

  final int id;
  final DateTime time;
  final Reminder reminder;
  final DateNotificationKind kind;
  final DateTime dueDate;
}

/// Идентификаторы уведомлений: у каждого напоминания свои три.
int advanceNotificationId(int reminderId) => reminderId * 10 + 1;
int dueDayNotificationId(int reminderId) => reminderId * 10 + 2;
int mileageNotificationId(int reminderId) => reminderId * 10 + 3;

/// Уведомления по дате, которые ещё не наступили на момент [now].
List<PlannedNotification> planDateNotifications(
  List<Reminder> reminders,
  DateTime now,
) {
  DateTime at(DateTime day) =>
      DateTime(day.year, day.month, day.day, reminderNotificationHour);

  final plan = <PlannedNotification>[];
  for (final reminder in reminders) {
    final due = reminderDueDate(reminder);
    if (due == null) continue;

    if (reminder.advanceDays > 0) {
      // Календарный день, а не «минус N×24 часа» — из-за перевода часов.
      final advanceDay = at(
        DateTime(due.year, due.month, due.day - reminder.advanceDays),
      );
      if (advanceDay.isAfter(now)) {
        plan.add(
          PlannedNotification(
            id: advanceNotificationId(reminder.id),
            time: advanceDay,
            reminder: reminder,
            kind: DateNotificationKind.advance,
            dueDate: due,
          ),
        );
      }
    }

    final dueTime = at(due);
    if (dueTime.isAfter(now)) {
      plan.add(
        PlannedNotification(
          id: dueDayNotificationId(reminder.id),
          time: dueTime,
          reminder: reminder,
          kind: DateNotificationKind.dueDay,
          dueDate: due,
        ),
      );
    }
  }
  return plan;
}
