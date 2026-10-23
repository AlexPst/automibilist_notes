// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(carsList)
final carsListProvider = CarsListProvider._();

final class CarsListProvider
    extends
        $FunctionalProvider<AsyncValue<List<Car>>, List<Car>, Stream<List<Car>>>
    with $FutureModifier<List<Car>>, $StreamProvider<List<Car>> {
  CarsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'carsListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$carsListHash();

  @$internal
  @override
  $StreamProviderElement<List<Car>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Car>> create(Ref ref) {
    return carsList(ref);
  }
}

String _$carsListHash() => r'ae5a3d51c468fca68eb7dbcf5134472b488417cd';

@ProviderFor(selectedCarId)
final selectedCarIdProvider = SelectedCarIdProvider._();

final class SelectedCarIdProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, Stream<int?>>
    with $FutureModifier<int?>, $StreamProvider<int?> {
  SelectedCarIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCarIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCarIdHash();

  @$internal
  @override
  $StreamProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int?> create(Ref ref) {
    return selectedCarId(ref);
  }
}

String _$selectedCarIdHash() => r'0760d33583a90c97b9bdc529f73de298ef0a60c4';

/// Активный автомобиль или `null`, пока данные грузятся или машин нет.

@ProviderFor(activeCar)
final activeCarProvider = ActiveCarProvider._();

/// Активный автомобиль или `null`, пока данные грузятся или машин нет.

final class ActiveCarProvider extends $FunctionalProvider<Car?, Car?, Car?>
    with $Provider<Car?> {
  /// Активный автомобиль или `null`, пока данные грузятся или машин нет.
  ActiveCarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCarHash();

  @$internal
  @override
  $ProviderElement<Car?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Car? create(Ref ref) {
    return activeCar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Car? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Car?>(value),
    );
  }
}

String _$activeCarHash() => r'f4e20640143453b81625b282fdcdfd66de5dbf93';

@ProviderFor(carById)
final carByIdProvider = CarByIdFamily._();

final class CarByIdProvider extends $FunctionalProvider<Car?, Car?, Car?>
    with $Provider<Car?> {
  CarByIdProvider._({
    required CarByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'carByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$carByIdHash();

  @override
  String toString() {
    return r'carByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Car?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Car? create(Ref ref) {
    final argument = this.argument as int;
    return carById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Car? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Car?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CarByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$carByIdHash() => r'7b4ca8c07b4adb30e64c9e377b9ce198054992e5';

final class CarByIdFamily extends $Family
    with $FunctionalFamilyOverride<Car?, int> {
  CarByIdFamily._()
    : super(
        retry: null,
        name: r'carByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CarByIdProvider call(int id) => CarByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'carByIdProvider';
}
