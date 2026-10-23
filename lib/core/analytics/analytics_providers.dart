import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'analytics.dart';

part 'analytics_providers.g.dart';

/// Аналитика приложения. По умолчанию (и в тестах) выключена;
/// `main()` подключает AppMetrica, когда прочитаны настройки.
@Riverpod(keepAlive: true)
class AnalyticsHolder extends _$AnalyticsHolder {
  @override
  Analytics build() => const NoAnalytics();

  void use(Analytics analytics) => state = analytics;
}
