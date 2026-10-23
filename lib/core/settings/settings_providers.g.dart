// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Настройки приложения. Первое значение загружается в `main()` до показа
/// интерфейса, чтобы тема не мигала.

@ProviderFor(appSettings)
final appSettingsProvider = AppSettingsProvider._();

/// Настройки приложения. Первое значение загружается в `main()` до показа
/// интерфейса, чтобы тема не мигала.

final class AppSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppSettings>,
          AppSettings,
          Stream<AppSettings>
        >
    with $FutureModifier<AppSettings>, $StreamProvider<AppSettings> {
  /// Настройки приложения. Первое значение загружается в `main()` до показа
  /// интерфейса, чтобы тема не мигала.
  AppSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingsHash();

  @$internal
  @override
  $StreamProviderElement<AppSettings> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AppSettings> create(Ref ref) {
    return appSettings(ref);
  }
}

String _$appSettingsHash() => r'b4f4c90d472d6c1295f646536a647ca2246dd7b8';
