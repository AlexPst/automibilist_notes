/// Запись о выполненном ТО или ремонте.
class ServiceRecord {
  const ServiceRecord({
    required this.id,
    required this.carId,
    required this.title,
    required this.date,
    required this.mileage,
    this.reminderId,
    this.cost,
    this.station,
    this.comment,
  });

  final int id;
  final int carId;

  /// Напоминание, которое продлила эта запись.
  final int? reminderId;

  /// Вид работ.
  final String title;
  final DateTime date;
  final int mileage;
  final double? cost;

  /// СТО.
  final String? station;
  final String? comment;
}
