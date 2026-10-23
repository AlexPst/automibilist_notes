/// Заправка автомобиля.
class FuelEntry {
  const FuelEntry({
    required this.id,
    required this.carId,
    required this.date,
    required this.mileage,
    required this.liters,
    required this.pricePerLiter,
    required this.totalCost,
    required this.isFullTank,
    this.station,
    this.comment,
  });

  final int id;
  final int carId;

  /// День заправки (без времени).
  final DateTime date;

  /// Показание одометра, км.
  final int mileage;
  final double liters;
  final double pricePerLiter;
  final double totalCost;

  /// Залит полный бак — нужно для расчёта расхода.
  final bool isFullTank;
  final String? station;
  final String? comment;
}
