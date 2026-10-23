// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_launch.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Это первый запуск приложения. Значение загружается в `main()`
/// до показа интерфейса, чтобы экран загрузки не мигал.

@ProviderFor(isFirstLaunch)
final isFirstLaunchProvider = IsFirstLaunchProvider._();

/// Это первый запуск приложения. Значение загружается в `main()`
/// до показа интерфейса, чтобы экран загрузки не мигал.

final class IsFirstLaunchProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Это первый запуск приложения. Значение загружается в `main()`
  /// до показа интерфейса, чтобы экран загрузки не мигал.
  IsFirstLaunchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isFirstLaunchProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isFirstLaunchHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isFirstLaunch(ref);
  }
}

String _$isFirstLaunchHash() => r'0ea08b3c97fbf3cceaffaa8ce01680329db02f35';
