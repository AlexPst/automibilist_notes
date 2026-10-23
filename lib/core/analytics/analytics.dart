import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';

/// События аналитики. Только факты действий — без сумм, пробегов,
/// названий и других пользовательских данных.
enum AnalyticsEvent {
  carAdded('car_added'),
  fuelAdded('fuel_added'),
  expenseAdded('expense_added'),
  reminderAdded('reminder_added'),
  serviceRecordAdded('service_record_added'),
  backupCreated('backup_created'),
  backupRestored('backup_restored'),
  csvExported('csv_exported');

  const AnalyticsEvent(this.id);

  final String id;
}

/// Аналитика и отчёты о сбоях. Интерфейс отделён от SDK, чтобы
/// приложение работало без ключа AppMetrica и в тестах.
abstract interface class Analytics {
  /// Подключена ли аналитика (есть ключ).
  bool get isAvailable;

  Future<void> log(AnalyticsEvent event);

  /// Согласие пользователя на отправку статистики.
  Future<void> setEnabled(bool enabled);
}

/// Аналитика выключена: ключа нет или это тест.
class NoAnalytics implements Analytics {
  const NoAnalytics();

  @override
  bool get isAvailable => false;

  @override
  Future<void> log(AnalyticsEvent event) async {}

  @override
  Future<void> setEnabled(bool enabled) async {}
}

class AppMetricaAnalytics implements Analytics {
  AppMetricaAnalytics._();

  /// Ключ передаётся при сборке:
  /// `flutter build apk --dart-define=APPMETRICA_API_KEY=...`.
  static const apiKey = String.fromEnvironment('APPMETRICA_API_KEY');

  /// Включает AppMetrica, если при сборке передан ключ.
  static Future<Analytics> activate({required bool enabled}) async {
    if (apiKey.isEmpty) return const NoAnalytics();

    await AppMetrica.activate(
      AppMetricaConfig(
        apiKey,
        // Сбои Flutter-кода SDK перехватывает сам (FlutterError.onError).
        crashReporting: true,
        nativeCrashReporting: true,
        flutterCrashReporting: true,
        dataSendingEnabled: enabled,
        // Местоположение и рекламный идентификатор не нужны.
        locationTracking: false,
        advIdentifiersTracking: false,
        logs: kDebugMode,
      ),
    );

    // Ошибки вне Flutter-фреймворка (асинхронный код без обработчика).
    PlatformDispatcher.instance.onError = (error, stack) {
      AppMetrica.reportUnhandledException(
        AppMetricaErrorDescription.fromObjectAndStackTrace(error, stack),
      );
      return false; // пусть ошибка обработается и стандартно
    };
    return AppMetricaAnalytics._();
  }

  @override
  bool get isAvailable => true;

  @override
  Future<void> log(AnalyticsEvent event) => AppMetrica.reportEvent(event.id);

  @override
  Future<void> setEnabled(bool enabled) =>
      AppMetrica.setDataSendingEnabled(enabled);
}
