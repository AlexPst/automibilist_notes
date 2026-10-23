// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Аналитика приложения. По умолчанию (и в тестах) выключена;
/// `main()` подключает AppMetrica, когда прочитаны настройки.

@ProviderFor(AnalyticsHolder)
final analyticsHolderProvider = AnalyticsHolderProvider._();

/// Аналитика приложения. По умолчанию (и в тестах) выключена;
/// `main()` подключает AppMetrica, когда прочитаны настройки.
final class AnalyticsHolderProvider
    extends $NotifierProvider<AnalyticsHolder, Analytics> {
  /// Аналитика приложения. По умолчанию (и в тестах) выключена;
  /// `main()` подключает AppMetrica, когда прочитаны настройки.
  AnalyticsHolderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsHolderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsHolderHash();

  @$internal
  @override
  AnalyticsHolder create() => AnalyticsHolder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Analytics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Analytics>(value),
    );
  }
}

String _$analyticsHolderHash() => r'510889a60f2b1a0faab3d95653fff52eeaa349e5';

/// Аналитика приложения. По умолчанию (и в тестах) выключена;
/// `main()` подключает AppMetrica, когда прочитаны настройки.

abstract class _$AnalyticsHolder extends $Notifier<Analytics> {
  Analytics build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Analytics, Analytics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Analytics, Analytics>,
              Analytics,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
