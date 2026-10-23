import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/data_providers.dart';
import '../../../data/models/fuel_entry.dart';
import '../domain/fuel_consumption.dart';

part 'fuel_providers.g.dart';

/// Заправки автомобиля, новые сверху.
@riverpod
Stream<List<FuelEntry>> fuelEntries(Ref ref, int carId) {
  return ref.watch(fuelRepositoryProvider).watchForCar(carId);
}

@riverpod
FuelConsumption fuelConsumption(Ref ref, int carId) {
  final entries = ref.watch(fuelEntriesProvider(carId)).value;
  if (entries == null) return FuelConsumption.empty;
  return calculateConsumption(entries);
}

@riverpod
Future<FuelEntry?> fuelEntry(Ref ref, int id) {
  return ref.watch(fuelRepositoryProvider).getById(id);
}
