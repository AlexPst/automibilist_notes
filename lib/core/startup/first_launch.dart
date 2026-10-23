import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/data_providers.dart';

part 'first_launch.g.dart';

/// Это первый запуск приложения. Значение загружается в `main()`
/// до показа интерфейса, чтобы экран загрузки не мигал.
@Riverpod(keepAlive: true)
Future<bool> isFirstLaunch(Ref ref) async {
  final done = await ref.watch(settingsRepositoryProvider).isFirstLaunchDone();
  return !done;
}
