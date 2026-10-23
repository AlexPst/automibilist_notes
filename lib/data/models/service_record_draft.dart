/// Данные записи ТО из формы.
class ServiceRecordDraft {
  const ServiceRecordDraft({
    required this.carId,
    required this.title,
    required this.date,
    required this.mileage,
    this.reminderId,
    this.cost,
    this.station,
    this.comment,
  });

  final int carId;
  final int? reminderId;
  final String title;
  final DateTime date;
  final int mileage;
  final double? cost;
  final String? station;
  final String? comment;
}
