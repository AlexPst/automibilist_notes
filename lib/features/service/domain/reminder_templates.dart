/// Готовые шаблоны напоминаний. Названия — в локализации.
enum ReminderTemplate {
  oil(intervalKm: 10000, intervalMonths: 12),
  airFilter(intervalKm: 15000, intervalMonths: 12),
  cabinFilter(intervalKm: 15000, intervalMonths: 12),
  fuelFilter(intervalKm: 30000),
  osago(intervalMonths: 12, advanceDays: 14),
  inspection(intervalMonths: 12, advanceDays: 14),
  summerTyres(intervalMonths: 12),
  winterTyres(intervalMonths: 12);

  const ReminderTemplate({
    this.intervalKm,
    this.intervalMonths,
    this.advanceDays = 7,
  });

  final int? intervalKm;
  final int? intervalMonths;
  final int advanceDays;
}
