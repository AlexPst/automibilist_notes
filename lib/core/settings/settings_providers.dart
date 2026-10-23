import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data_providers.dart';
import 'app_settings.dart';

part 'settings_providers.g.dart';

/// Настройки приложения. Первое значение загружается в `main()` до показа
/// интерфейса, чтобы тема не мигала.
@Riverpod(keepAlive: true)
Stream<AppSettings> appSettings(Ref ref) {
  return ref.watch(settingsRepositoryProvider).watchAppSettings();
}
