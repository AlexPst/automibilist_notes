import '../../../data/models/car.dart';

/// Активный автомобиль: выбранный пользователем, а если он не выбран
/// или удалён — первый из списка.
Car? pickActiveCar(List<Car> cars, int? selectedId) {
  if (cars.isEmpty) return null;
  for (final car in cars) {
    if (car.id == selectedId) return car;
  }
  return cars.first;
}
