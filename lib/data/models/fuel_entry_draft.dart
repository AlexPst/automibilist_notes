/// Данные заправки из формы — для создания или изменения записи.
class FuelEntryDraft {
  const FuelEntryDraft({
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

  final int carId;
  final DateTime date;
  final int mileage;
  final double liters;
  final double pricePerLiter;
  final double totalCost;
  final bool isFullTank;
  final String? station;
  final String? comment;
}
