import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/service_providers.dart';

/// Следит за напоминаниями, пока приложение открыто:
/// пересобирает расписание уведомлений по дате и проверяет сроки
/// по пробегу при каждом его изменении.
class ReminderEffects extends ConsumerStatefulWidget {
  const ReminderEffects({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ReminderEffects> createState() => _ReminderEffectsState();
}

class _ReminderEffectsState extends ConsumerState<ReminderEffects> {
  /// Задачи выполняются по очереди, чтобы одно оповещение
  /// не отправилось дважды.
  Future<void> _queue = Future.value();

  void _enqueue(Future<void> Function() task) {
    _queue = _queue.then((_) => task()).catchError((Object e, StackTrace s) {
      FlutterError.reportError(FlutterErrorDetails(exception: e, stack: s));
    });
  }

  @override
  void initState() {
    super.initState();
    final notifications = ref.read(reminderNotificationsProvider);

    ref.listenManual(notificationScheduleInputProvider, (_, input) {
      if (input == null) return;
      _enqueue(
        () => notifications.reschedule(
          input.reminders,
          input.cars,
          DateTime.now(),
        ),
      );
    }, fireImmediately: true);

    ref.listenManual(mileageCheckInputProvider, (_, input) {
      if (input == null) return;
      _enqueue(() async {
        final alerts = await notifications.checkMileage(
          input.car,
          input.reminders,
          input.mileage,
        );
        if (alerts.isNotEmpty) {
          _showSnackBar(alerts.map((a) => a.reminder.title).join(', '));
        }
      });
    }, fireImmediately: true);
  }

  void _showSnackBar(String titles) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.mileageAlertSnack(titles)),
        // С кнопкой действия SnackBar по умолчанию не исчезает и
        // закрывает кнопку «+» — пусть уходит сам, уведомление останется.
        persist: false,
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: l10n.open,
          onPressed: () => ref.read(appRouterProvider).go(AppRoutes.service),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
