/// Данные напоминания из формы.
class ReminderDraft {
  const ReminderDraft({
    required this.carId,
    required this.title,
    required this.lastDoneDate,
    this.intervalKm,
    this.intervalMonths,
    this.lastDoneMileage,
    this.advanceDays = 7,
    this.advanceKm = 500,
  });

  final int carId;
  final String title;
  final int? intervalKm;
  final int? intervalMonths;
  final DateTime lastDoneDate;
  final int? lastDoneMileage;
  final int advanceDays;
  final int advanceKm;
}
