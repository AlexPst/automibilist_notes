import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/analytics/analytics.dart';
import 'core/analytics/analytics_providers.dart';
import 'core/notifications/notification_providers.dart';
import 'core/notifications/notification_service.dart';
import 'core/settings/settings_providers.dart';
import 'core/startup/first_launch.dart';
import 'data/data_providers.dart';
import 'data/storage/car_photo_storage.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Форматы дат, чисел и валюты — русские.
  Intl.defaultLocale = 'ru_RU';
  await initializeDateFormatting('ru_RU');

  final appDirectory = await getApplicationDocumentsDirectory();

  final l10n = lookupAppLocalizations(const Locale('ru'));
  final notifications = LocalNotificationService(
    channelName: l10n.notificationChannelName,
    channelDescription: l10n.notificationChannelDescription,
  );
  await notifications.init();

  final container = ProviderContainer(
    overrides: [
      carPhotoStorageProvider.overrideWithValue(CarPhotoStorage(appDirectory)),
      notificationServiceProvider.overrideWithValue(notifications),
    ],
  );
  // Нужно знать заранее, чтобы экран загрузки и тема не мигали.
  await container.read(isFirstLaunchProvider.future);
  // Riverpod ставит на паузу потоки без слушателей — подписываемся,
  // пока ждём первое значение настроек.
  final settingsSubscription = container.listen(appSettingsProvider, (_, _) {});
  final settings = await container.read(appSettingsProvider.future);
  settingsSubscription.close();

  // Аналитика — с учётом согласия пользователя из настроек.
  container
      .read(analyticsHolderProvider.notifier)
      .use(
        await AppMetricaAnalytics.activate(enabled: settings.analyticsEnabled),
      );

  runApp(
    UncontrolledProviderScope(container: container, child: const CarDiaryApp()),
  );
}
