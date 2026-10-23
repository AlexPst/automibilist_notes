import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/data_providers.dart';
import '../../../data/models/car.dart';
import 'active_car.dart';

part 'cars_providers.g.dart';

@Riverpod(keepAlive: true)
Stream<List<Car>> carsList(Ref ref) {
  return ref.watch(carsRepositoryProvider).watchAll();
}

@Riverpod(keepAlive: true)
Stream<int?> selectedCarId(Ref ref) {
  return ref.watch(settingsRepositoryProvider).watchActiveCarId();
}

/// Активный автомобиль или `null`, пока данные грузятся или машин нет.
@riverpod
Car? activeCar(Ref ref) {
  final cars = ref.watch(carsListProvider).value ?? const [];
  final selectedId = ref.watch(selectedCarIdProvider).value;
  return pickActiveCar(cars, selectedId);
}

@riverpod
Car? carById(Ref ref, int id) {
  final cars = ref.watch(carsListProvider).value ?? const [];
  for (final car in cars) {
    if (car.id == id) return car;
  }
  return null;
}
