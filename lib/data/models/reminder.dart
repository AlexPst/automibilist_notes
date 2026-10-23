/// Напоминание о периодической работе.
class Reminder {
  const Reminder({
    required this.id,
    required this.carId,
    required this.title,
    required this.lastDoneDate,
    required this.advanceDays,
    required this.advanceKm,
    this.intervalKm,
    this.intervalMonths,
    this.lastDoneMileage,
    this.notifiedDueMileage,
  });

  final int id;
  final int carId;

  /// Вид работ.
  final String title;

  /// Интервал по пробегу, км.
  final int? intervalKm;

  /// Интервал по времени, месяцы.
  final int? intervalMonths;

  /// Когда работу делали последний раз.
  final DateTime lastDoneDate;
  final int? lastDoneMileage;

  /// За сколько дней / км до срока предупредить.
  final int advanceDays;
  final int advanceKm;

  /// Срок по пробегу, о котором уже сообщили.
  final int? notifiedDueMileage;
}
