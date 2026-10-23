import 'fuel_type.dart';

/// Автомобиль пользователя.
class Car {
  const Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.fuelType,
    required this.initialMileage,
    this.year,
    this.plateNumber,
    this.tankVolume,
    this.photoPath,
  });

  final int id;
  final String brand;
  final String model;
  final FuelType fuelType;

  /// Пробег на момент добавления авто в приложение, км.
  final int initialMileage;
  final int? year;
  final String? plateNumber;

  /// Объём бака, л.
  final double? tankVolume;

  /// Полный путь к файлу фото или `null`.
  final String? photoPath;
}
