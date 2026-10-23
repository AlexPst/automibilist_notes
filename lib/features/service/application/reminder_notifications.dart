import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/car.dart';
import '../../../data/models/reminder.dart';
import '../../../data/repositories/reminders_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/presentation/car_texts.dart';
import '../domain/mileage_alerts.dart';
import '../domain/notification_plan.dart';

/// Ставит уведомления по дате и сообщает о сроках по пробегу.
class ReminderNotifications {
  ReminderNotifications(this._notifications, this._reminders, this._l10n);

  final NotificationService _notifications;
  final RemindersRepository _reminders;
  final AppLocalizations _l10n;

  static const testNotificationId = 1;

  /// Пересобирает расписание: проще и надёжнее, чем отслеживать
  /// изменения каждого напоминания.
  Future<void> reschedule(
    List<Reminder> reminders,
    Map<int, Car> cars,
    DateTime now,
  ) async {
    await _notifications.cancelAllScheduled();
    for (final planned in planDateNotifications(reminders, now)) {
      final car = cars[planned.reminder.carId];
      if (car == null) continue;
      final title = planned.reminder.title;
      await _notifications.scheduleAt(
        id: planned.id,
        time: planned.time,
        title: switch (planned.kind) {
          DateNotificationKind.advance => _l10n.notifSoonTitle(title),
          DateNotificationKind.dueDay => _l10n.notifDueTitle(title),
        },
        body: _l10n.notifDateBody(carTitle(car), formatDate(planned.dueDate)),
      );
    }
  }

  /// Проверяет сроки по пробегу; о каждом сроке сообщает один раз.
  /// Возвращает новые оповещения — их показывают и в приложении.
  Future<List<MileageAlert>> checkMileage(
    Car car,
    List<Reminder> reminders,
    int currentMileage,
  ) async {
    final alerts = mileageAlerts(reminders, currentMileage);
    for (final alert in alerts) {
      final title = alert.reminder.title;
      await _notifications.show(
        id: mileageNotificationId(alert.reminder.id),
        title: alert.kmLeft <= 0
            ? _l10n.notifMileageDueTitle(title)
            : _l10n.notifSoonTitle(title),
        body: _l10n.notifMileageBody(
          carTitle(car),
          formatInt(alert.dueMileage),
          formatInt(alert.currentMileage),
        ),
      );
      await _reminders.markMileageNotified(alert.reminder.id, alert.dueMileage);
    }
    return alerts;
  }

  /// Тестовое уведомление через минуту — для проверки на устройстве.
  Future<void> scheduleTest(DateTime now) async {
    await _notifications.requestPermission();
    await _notifications.scheduleAt(
      id: testNotificationId,
      time: now.add(const Duration(minutes: 1)),
      title: _l10n.notifTestTitle,
      body: _l10n.notifTestBody,
    );
  }
}
