import '../../../data/models/expense.dart';
import '../../../data/models/fuel_entry.dart';
import '../../../data/models/service_record.dart';
import '../../fuel/domain/fuel_consumption.dart';
import 'distance.dart';
import 'spending.dart';
import 'stats_period.dart';

/// Вся статистика автомобиля за период.
class StatsSummary {
  const StatsSummary({
    required this.total,
    required this.byCategory,
    required this.byMonth,
    required this.distance,
    required this.costPerKm,
    required this.fuelCostPerKm,
    required this.segments,
    required this.averageConsumption,
  });

  final double total;

  /// Суммы по категориям в постоянном порядке.
  final Map<StatsCategory, double> byCategory;
  final List<MonthTotal> byMonth;

  /// Пробег за период, км.
  final int distance;
  final double? costPerKm;
  final double? fuelCostPerKm;

  /// Отрезки «от полного до полного», закончившиеся в периоде.
  final List<ConsumptionSegment> segments;
  final double? averageConsumption;

  double get fuel => byCategory[StatsCategory.fuel] ?? 0;
  double get service => byCategory[StatsCategory.service] ?? 0;

  /// Прочие расходы (всё, кроме топлива и ТО).
  double get otherExpenses => total - fuel - service;

  bool get isEmpty => total == 0 && segments.isEmpty;
}

/// Сколько месяцев показывать на столбчатой диаграмме для «месяца».
const monthPeriodBars = 6;

StatsSummary buildStats({
  required StatsPeriod period,
  required DateTime now,
  required int initialMileage,
  required List<FuelEntry> fuel,
  required List<Expense> expenses,
  required List<ServiceRecord> service,
}) {
  final all = collectSpending(fuel: fuel, expenses: expenses, service: service);
  final inPeriod = [
    for (final s in all)
      if (period.contains(s.date, now)) s,
  ];
  final range = period.range(now);

  final total = totalOf(inPeriod);
  final byCategory = totalsByCategory(inPeriod);

  // Столбцы: для «месяца» — несколько последних месяцев для сравнения,
  // для года — с января по текущий, для всего времени — с первой траты.
  final barsFrom = switch (period) {
    StatsPeriod.month => DateTime(now.year, now.month - monthPeriodBars + 1),
    StatsPeriod.year => DateTime(now.year),
    StatsPeriod.all =>
      all.isEmpty
          ? now
          : all.map((s) => s.date).reduce((a, b) => a.isBefore(b) ? a : b),
  };
  final byMonth = totalsByMonth(all, from: barsFrom, to: now);

  final distance = distanceInPeriod(
    initialMileage: initialMileage,
    marks: [
      for (final f in fuel) (date: f.date, mileage: f.mileage),
      for (final e in expenses)
        if (e.mileage != null) (date: e.date, mileage: e.mileage!),
      for (final s in service) (date: s.date, mileage: s.mileage),
    ],
    start: range.start,
    end: range.end,
  );

  final segments = [
    for (final s in calculateConsumption(fuel).segments)
      if (period.contains(s.entry.date, now)) s,
  ];

  return StatsSummary(
    total: total,
    byCategory: byCategory,
    byMonth: byMonth,
    distance: distance,
    costPerKm: costPerKm(total, distance),
    fuelCostPerKm: costPerKm(byCategory[StatsCategory.fuel] ?? 0, distance),
    segments: segments,
    averageConsumption: averageConsumption(segments),
  );
}
