// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';

/// Папка приложения известна только после старта —
/// провайдер переопределяется в `main()` (и в тестах).

@ProviderFor(carPhotoStorage)
final carPhotoStorageProvider = CarPhotoStorageProvider._();

/// Папка приложения известна только после старта —
/// провайдер переопределяется в `main()` (и в тестах).

final class CarPhotoStorageProvider
    extends
        $FunctionalProvider<CarPhotoStorage, CarPhotoStorage, CarPhotoStorage>
    with $Provider<CarPhotoStorage> {
  /// Папка приложения известна только после старта —
  /// провайдер переопределяется в `main()` (и в тестах).
  CarPhotoStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'carPhotoStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$carPhotoStorageHash();

  @$internal
  @override
  $ProviderElement<CarPhotoStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CarPhotoStorage create(Ref ref) {
    return carPhotoStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CarPhotoStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CarPhotoStorage>(value),
    );
  }
}

String _$carPhotoStorageHash() => r'6edcf3d0093c7c3744ded7fbbae7941b1e3d43e1';

@ProviderFor(carsRepository)
final carsRepositoryProvider = CarsRepositoryProvider._();

final class CarsRepositoryProvider
    extends $FunctionalProvider<CarsRepository, CarsRepository, CarsRepository>
    with $Provider<CarsRepository> {
  CarsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'carsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$carsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CarsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CarsRepository create(Ref ref) {
    return carsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CarsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CarsRepository>(value),
    );
  }
}

String _$carsRepositoryHash() => r'1778f998f60159553f21db57a324f2f94ffdc022';

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'ceeb3e57d5dc9cba2be29261c9936cfde245c538';

@ProviderFor(fuelRepository)
final fuelRepositoryProvider = FuelRepositoryProvider._();

final class FuelRepositoryProvider
    extends $FunctionalProvider<FuelRepository, FuelRepository, FuelRepository>
    with $Provider<FuelRepository> {
  FuelRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fuelRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fuelRepositoryHash();

  @$internal
  @override
  $ProviderElement<FuelRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FuelRepository create(Ref ref) {
    return fuelRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FuelRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FuelRepository>(value),
    );
  }
}

String _$fuelRepositoryHash() => r'8fc6002dba62932c6d3aa42b7947df563176d4c1';

@ProviderFor(expensesRepository)
final expensesRepositoryProvider = ExpensesRepositoryProvider._();

final class ExpensesRepositoryProvider
    extends
        $FunctionalProvider<
          ExpensesRepository,
          ExpensesRepository,
          ExpensesRepository
        >
    with $Provider<ExpensesRepository> {
  ExpensesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExpensesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExpensesRepository create(Ref ref) {
    return expensesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpensesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpensesRepository>(value),
    );
  }
}

String _$expensesRepositoryHash() =>
    r'ceecdcd466d40eae55bade2969b727cc83409805';

@ProviderFor(remindersRepository)
final remindersRepositoryProvider = RemindersRepositoryProvider._();

final class RemindersRepositoryProvider
    extends
        $FunctionalProvider<
          RemindersRepository,
          RemindersRepository,
          RemindersRepository
        >
    with $Provider<RemindersRepository> {
  RemindersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersRepositoryHash();

  @$internal
  @override
  $ProviderElement<RemindersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemindersRepository create(Ref ref) {
    return remindersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemindersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemindersRepository>(value),
    );
  }
}

String _$remindersRepositoryHash() =>
    r'd5f0aa33c329b14a6b132bf8c7a604b8bf73265a';

@ProviderFor(serviceRepository)
final serviceRepositoryProvider = ServiceRepositoryProvider._();

final class ServiceRepositoryProvider
    extends
        $FunctionalProvider<
          ServiceRepository,
          ServiceRepository,
          ServiceRepository
        >
    with $Provider<ServiceRepository> {
  ServiceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServiceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceRepository create(Ref ref) {
    return serviceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceRepository>(value),
    );
  }
}

String _$serviceRepositoryHash() => r'0bf7ea31bc940a5f3e161e226bf147e01e070eb5';

@ProviderFor(backupService)
final backupServiceProvider = BackupServiceProvider._();

final class BackupServiceProvider
    extends $FunctionalProvider<BackupService, BackupService, BackupService>
    with $Provider<BackupService> {
  BackupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupServiceHash();

  @$internal
  @override
  $ProviderElement<BackupService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupService create(Ref ref) {
    return backupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupService>(value),
    );
  }
}

String _$backupServiceHash() => r'4cc1cbc39f83c98180b00c48707e41f2f76e6fe5';
