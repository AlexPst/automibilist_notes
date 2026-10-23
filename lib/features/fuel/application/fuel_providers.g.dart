// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Заправки автомобиля, новые сверху.

@ProviderFor(fuelEntries)
final fuelEntriesProvider = FuelEntriesFamily._();

/// Заправки автомобиля, новые сверху.

final class FuelEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FuelEntry>>,
          List<FuelEntry>,
          Stream<List<FuelEntry>>
        >
    with $FutureModifier<List<FuelEntry>>, $StreamProvider<List<FuelEntry>> {
  /// Заправки автомобиля, новые сверху.
  FuelEntriesProvider._({
    required FuelEntriesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fuelEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fuelEntriesHash();

  @override
  String toString() {
    return r'fuelEntriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<FuelEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FuelEntry>> create(Ref ref) {
    final argument = this.argument as int;
    return fuelEntries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FuelEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fuelEntriesHash() => r'4bcdd1ff25560d994e08af3033276b392e092440';

/// Заправки автомобиля, новые сверху.

final class FuelEntriesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<FuelEntry>>, int> {
  FuelEntriesFamily._()
    : super(
        retry: null,
        name: r'fuelEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Заправки автомобиля, новые сверху.

  FuelEntriesProvider call(int carId) =>
      FuelEntriesProvider._(argument: carId, from: this);

  @override
  String toString() => r'fuelEntriesProvider';
}

@ProviderFor(fuelConsumption)
final fuelConsumptionProvider = FuelConsumptionFamily._();

final class FuelConsumptionProvider
    extends
        $FunctionalProvider<FuelConsumption, FuelConsumption, FuelConsumption>
    with $Provider<FuelConsumption> {
  FuelConsumptionProvider._({
    required FuelConsumptionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fuelConsumptionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fuelConsumptionHash();

  @override
  String toString() {
    return r'fuelConsumptionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<FuelConsumption> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FuelConsumption create(Ref ref) {
    final argument = this.argument as int;
    return fuelConsumption(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FuelConsumption value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FuelConsumption>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FuelConsumptionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fuelConsumptionHash() => r'1d2a957203c9fecf31403a94b7f8e5981d5f1fb8';

final class FuelConsumptionFamily extends $Family
    with $FunctionalFamilyOverride<FuelConsumption, int> {
  FuelConsumptionFamily._()
    : super(
        retry: null,
        name: r'fuelConsumptionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FuelConsumptionProvider call(int carId) =>
      FuelConsumptionProvider._(argument: carId, from: this);

  @override
  String toString() => r'fuelConsumptionProvider';
}

@ProviderFor(fuelEntry)
final fuelEntryProvider = FuelEntryFamily._();

final class FuelEntryProvider
    extends
        $FunctionalProvider<
          AsyncValue<FuelEntry?>,
          FuelEntry?,
          FutureOr<FuelEntry?>
        >
    with $FutureModifier<FuelEntry?>, $FutureProvider<FuelEntry?> {
  FuelEntryProvider._({
    required FuelEntryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fuelEntryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fuelEntryHash();

  @override
  String toString() {
    return r'fuelEntryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FuelEntry?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<FuelEntry?> create(Ref ref) {
    final argument = this.argument as int;
    return fuelEntry(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FuelEntryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fuelEntryHash() => r'd87f5d8d3394be569772477b9e9f556f4c1e983e';

final class FuelEntryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FuelEntry?>, int> {
  FuelEntryFamily._()
    : super(
        retry: null,
        name: r'fuelEntryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FuelEntryProvider call(int id) =>
      FuelEntryProvider._(argument: id, from: this);

  @override
  String toString() => r'fuelEntryProvider';
}
