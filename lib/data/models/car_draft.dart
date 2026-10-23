import 'fuel_type.dart';

/// Данные автомобиля из формы — для создания или изменения записи.
class CarDraft {
  const CarDraft({
    required this.brand,
    required this.model,
    required this.fuelType,
    required this.initialMileage,
    this.year,
    this.plateNumber,
    this.tankVolume,
    this.photoPath,
  });

  final String brand;
  final String model;
  final FuelType fuelType;

  /// Пробег на момент добавления авто в приложение, км.
  final int initialMileage;
  final int? year;
  final String? plateNumber;

  /// Объём бака, л.
  final double? tankVolume;

  /// Полный путь к выбранному фото или `null`, если фото нет.
  final String? photoPath;
}
