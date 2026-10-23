import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'backup/backup_service.dart';
import 'database/app_database.dart';
import 'repositories/cars_repository.dart';
import 'repositories/expenses_repository.dart';
import 'repositories/fuel_repository.dart';
import 'repositories/reminders_repository.dart';
import 'repositories/service_repository.dart';
import 'repositories/settings_repository.dart';
import 'storage/car_photo_storage.dart';

part 'data_providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

/// Папка приложения известна только после старта —
/// провайдер переопределяется в `main()` (и в тестах).
@Riverpod(keepAlive: true)
CarPhotoStorage carPhotoStorage(Ref ref) {
  throw UnimplementedError('carPhotoStorageProvider должен быть переопределён');
}

@Riverpod(keepAlive: true)
CarsRepository carsRepository(Ref ref) {
  return CarsRepository(
    ref.watch(appDatabaseProvider).carsDao,
    ref.watch(carPhotoStorageProvider),
  );
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository(ref.watch(appDatabaseProvider).settingsDao);
}

@Riverpod(keepAlive: true)
FuelRepository fuelRepository(Ref ref) {
  return FuelRepository(ref.watch(appDatabaseProvider).fuelDao);
}

@Riverpod(keepAlive: true)
ExpensesRepository expensesRepository(Ref ref) {
  return ExpensesRepository(ref.watch(appDatabaseProvider).expensesDao);
}

@Riverpod(keepAlive: true)
RemindersRepository remindersRepository(Ref ref) {
  return RemindersRepository(ref.watch(appDatabaseProvider).remindersDao);
}

@Riverpod(keepAlive: true)
ServiceRepository serviceRepository(Ref ref) {
  return ServiceRepository(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
BackupService backupService(Ref ref) {
  return BackupService(
    ref.watch(appDatabaseProvider),
    ref.watch(carPhotoStorageProvider),
  );
}
