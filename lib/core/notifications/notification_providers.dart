import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'notification_service.dart';

part 'notification_providers.g.dart';

/// Плагин уведомлений инициализируется в `main()` — провайдер
/// переопределяется там (и в тестах).
@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  throw UnimplementedError(
    'notificationServiceProvider должен быть переопределён',
  );
}
