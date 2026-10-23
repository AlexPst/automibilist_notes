import '../../../data/models/expense.dart';
import '../../../data/models/expense_category.dart';
import '../../../data/models/fuel_entry.dart';
import '../../../data/models/service_record.dart';

/// Категории статистики. Их ровно восемь — по числу различимых цветов
/// графика; редкие категории расходов объединены.
enum StatsCategory {
  fuel,
  service,
  repair,
  insurance,
  tax,
  fines,
  wash,
  other;

  static StatsCategory ofExpense(ExpenseCategory c) => switch (c) {
    ExpenseCategory.repair || ExpenseCategory.parts => repair,
    ExpenseCategory.insurance => insurance,
    ExpenseCategory.tax => tax,
    ExpenseCategory.fines => fines,
    ExpenseCategory.wash => wash,
    ExpenseCategory.parking || ExpenseCategory.other => other,
  };
}

/// Одна трата: заправка, расход или оплаченное ТО.
class Spending {
  const Spending(this.date, this.amount, this.category);

  final DateTime date;
  final double amount;
  final StatsCategory category;
}

/// Все траты автомобиля в одном списке.
List<Spending> collectSpending({
  required List<FuelEntry> fuel,
  required List<Expense> expenses,
  required List<ServiceRecord> service,
}) {
  return [
    for (final f in fuel) Spending(f.date, f.totalCost, StatsCategory.fuel),
    for (final e in expenses)
      Spending(e.date, e.amount, StatsCategory.ofExpense(e.category)),
    for (final s in service)
      if (s.cost != null && s.cost! > 0)
        Spending(s.date, s.cost!, StatsCategory.service),
  ];
}

double totalOf(Iterable<Spending> items) =>
    items.fold(0, (sum, s) => sum + s.amount);

/// Суммы по категориям в порядке [StatsCategory]; пустые не включаются.
Map<StatsCategory, double> totalsByCategory(Iterable<Spending> items) {
  final totals = <StatsCategory, double>{};
  for (final s in items) {
    totals[s.category] = (totals[s.category] ?? 0) + s.amount;
  }
  return {
    for (final c in StatsCategory.values)
      if (totals[c] case final total? when total > 0) c: total,
  };
}

/// Сумма за месяц (первое число месяца).
class MonthTotal {
  const MonthTotal(this.month, this.amount);

  final DateTime month;
  final double amount;
}

/// Суммы по месяцам с [from] по [to] включительно, пустые месяцы — нули.
List<MonthTotal> totalsByMonth(
  Iterable<Spending> items, {
  required DateTime from,
  required DateTime to,
}) {
  final sums = <DateTime, double>{};
  for (final s in items) {
    final month = DateTime(s.date.year, s.date.month);
    sums[month] = (sums[month] ?? 0) + s.amount;
  }
  return [
    for (
      var m = DateTime(from.year, from.month);
      !m.isAfter(DateTime(to.year, to.month));
      m = DateTime(m.year, m.month + 1)
    )
      MonthTotal(m, sums[m] ?? 0),
  ];
}
