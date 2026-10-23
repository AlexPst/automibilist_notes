import 'package:cardiary/data/models/car.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:cardiary/features/cars/application/active_car.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Car car(int id) => Car(
    id: id,
    brand: 'Car',
    model: '$id',
    fuelType: FuelType.ai95,
    initialMileage: 0,
  );

  final cars = [car(1), car(2), car(3)];

  test('без автомобилей активного нет', () {
    expect(pickActiveCar(const [], 1), isNull);
  });

  test('возвращает выбранный автомобиль', () {
    expect(pickActiveCar(cars, 2)?.id, 2);
  });

  test('если ничего не выбрано — первый', () {
    expect(pickActiveCar(cars, null)?.id, 1);
  });

  test('если выбранный удалён — первый', () {
    expect(pickActiveCar(cars, 42)?.id, 1);
  });
}
