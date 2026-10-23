import '../../../data/models/expense.dart';
import '../../../data/models/expense_category.dart';

/// Период для фильтра расходов.
sealed class ExpensePeriod {
  const ExpensePeriod();

  /// Границы периода `[start, end)` относительно [now]; `null` — без границ.
  ({DateTime start, DateTime end})? range(DateTime now);
}

class AllTime extends ExpensePeriod {
  const AllTime();

  @override
  ({DateTime start, DateTime end})? range(DateTime now) => null;
}

class ThisMonth extends ExpensePeriod {
  const ThisMonth();

  @override
  ({DateTime start, DateTime end}) range(DateTime now) => (
    start: DateTime(now.year, now.month),
    end: DateTime(now.year, now.month + 1),
  );
}

class ThisYear extends ExpensePeriod {
  const ThisYear();

  @override
  ({DateTime start, DateTime end}) range(DateTime now) =>
      (start: DateTime(now.year), end: DateTime(now.year + 1));
}

/// Произвольный период; оба дня включительно.
class CustomPeriod extends ExpensePeriod {
  const CustomPeriod({required this.from, required this.to});

  final DateTime from;
  final DateTime to;

  @override
  ({DateTime start, DateTime end}) range(DateTime now) => (
    start: DateTime(from.year, from.month, from.day),
    end: DateTime(to.year, to.month, to.day + 1),
  );
}

/// Фильтр списка расходов.
class ExpenseFilter {
  const ExpenseFilter({
    this.categories = const {},
    this.period = const AllTime(),
  });

  /// Выбранные категории; пустое множество — все категории.
  final Set<ExpenseCategory> categories;
  final ExpensePeriod period;

  bool get isActive => categories.isNotEmpty || period is! AllTime;

  ExpenseFilter copyWith({
    Set<ExpenseCategory>? categories,
    ExpensePeriod? period,
  }) {
    return ExpenseFilter(
      categories: categories ?? this.categories,
      period: period ?? this.period,
    );
  }

  bool matches(Expense expense, DateTime now) {
    if (categories.isNotEmpty && !categories.contains(expense.category)) {
      return false;
    }
    final range = period.range(now);
    if (range == null) return true;
    return !expense.date.isBefore(range.start) &&
        expense.date.isBefore(range.end);
  }

  List<Expense> apply(List<Expense> expenses, DateTime now) =>
      expenses.where((e) => matches(e, now)).toList();
}

/// Сумма расходов.
double totalAmount(Iterable<Expense> expenses) =>
    expenses.fold(0, (sum, e) => sum + e.amount);
