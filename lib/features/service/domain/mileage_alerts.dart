import 'dart:math';

import '../../../data/models/reminder.dart';
import 'reminder_status.dart';

/// Напоминание, о котором пора сообщить по пробегу.
class MileageAlert {
  const MileageAlert({
    required this.reminder,
    required this.dueMileage,
    required this.currentMileage,
  });

  final Reminder reminder;
  final int dueMileage;
  final int currentMileage;

  int get kmLeft => dueMileage - currentMileage;
}

/// Напоминания, до срока которых осталось не больше
/// [Reminder.advanceKm] км и о которых ещё не сообщали.
List<MileageAlert> mileageAlerts(List<Reminder> reminders, int currentMileage) {
  final alerts = <MileageAlert>[];
  for (final reminder in reminders) {
    final due = reminderDueMileage(reminder);
    if (due == null) continue;
    if (due - currentMileage > reminder.advanceKm) continue;
    if (reminder.notifiedDueMileage == due) continue;
    alerts.add(
      MileageAlert(
        reminder: reminder,
        dueMileage: due,
        currentMileage: currentMileage,
      ),
    );
  }
  return alerts;
}

/// Текущий пробег: наибольший из начального и всех введённых.
int currentMileageOf(int initialMileage, Iterable<int> mileages) =>
    mileages.fold(initialMileage, max);
