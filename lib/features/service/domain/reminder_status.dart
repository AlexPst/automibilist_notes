import 'dart:math';

import '../../../data/models/reminder.dart';

enum ReminderUrgency { ok, soon, overdue }

/// Следующий срок напоминания и сколько до него осталось.
class ReminderStatus {
  const ReminderStatus({
    required this.urgency,
    this.dueDate,
    this.dueMileage,
    this.daysLeft,
    this.kmLeft,
  });

  final ReminderUrgency urgency;

  /// Срок по дате (если задан интервал в месяцах).
  final DateTime? dueDate;

  /// Срок по пробегу (если задан интервал в км).
  final int? dueMileage;

  /// Дней до срока; отрицательное — просрочено.
  final int? daysLeft;

  /// Км до срока; ноль или меньше — пора.
  final int? kmLeft;
}

/// [date] + [months] месяцев. Если такого дня нет (31 января + 1 месяц),
/// берётся последний день месяца.
DateTime addMonths(DateTime date, int months) {
  final target = DateTime(date.year, date.month + months);
  final daysInTarget = DateTime(target.year, target.month + 1, 0).day;
  return DateTime(target.year, target.month, min(date.day, daysInTarget));
}

/// Срок по дате, если у напоминания есть интервал в месяцах.
DateTime? reminderDueDate(Reminder r) {
  final months = r.intervalMonths;
  return months == null ? null : addMonths(r.lastDoneDate, months);
}

/// Срок по пробегу, если у напоминания есть интервал в км.
int? reminderDueMileage(Reminder r) {
  final km = r.intervalKm;
  final last = r.lastDoneMileage;
  return km == null || last == null ? null : last + km;
}

/// Целое число дней между датами без учёта времени и перевода часов.
int daysBetween(DateTime from, DateTime to) {
  final a = DateTime.utc(from.year, from.month, from.day);
  final b = DateTime.utc(to.year, to.month, to.day);
  return b.difference(a).inDays;
}

/// Состояние напоминания на день [today] при пробеге [currentMileage].
ReminderStatus reminderStatus(
  Reminder r, {
  required DateTime today,
  required int? currentMileage,
}) {
  final dueDate = reminderDueDate(r);
  final dueMileage = reminderDueMileage(r);
  final daysLeft = dueDate == null ? null : daysBetween(today, dueDate);
  final kmLeft = dueMileage == null || currentMileage == null
      ? null
      : dueMileage - currentMileage;

  final overdue =
      (daysLeft != null && daysLeft < 0) || (kmLeft != null && kmLeft <= 0);
  final soon =
      (daysLeft != null && daysLeft <= r.advanceDays) ||
      (kmLeft != null && kmLeft <= r.advanceKm);

  return ReminderStatus(
    urgency: overdue
        ? ReminderUrgency.overdue
        : soon
        ? ReminderUrgency.soon
        : ReminderUrgency.ok,
    dueDate: dueDate,
    dueMileage: dueMileage,
    daysLeft: daysLeft,
    kmLeft: kmLeft,
  );
}

/// Порядок в списке: сначала просроченные, затем ближайшие.
int compareReminderStatus(ReminderStatus a, ReminderStatus b) {
  final byUrgency = b.urgency.index.compareTo(a.urgency.index);
  if (byUrgency != 0) return byUrgency;
  const far = 1 << 30;
  final byDays = (a.daysLeft ?? far).compareTo(b.daysLeft ?? far);
  if (byDays != 0) return byDays;
  return (a.kmLeft ?? far).compareTo(b.kmLeft ?? far);
}
