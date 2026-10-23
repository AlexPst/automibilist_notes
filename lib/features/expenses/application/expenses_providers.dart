import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/data_providers.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/expense_category.dart';
import '../domain/expense_filter.dart';

part 'expenses_providers.g.dart';

/// Расходы автомобиля, новые сверху.
@riverpod
Stream<List<Expense>> expenses(Ref ref, int carId) {
  return ref.watch(expensesRepositoryProvider).watchForCar(carId);
}

@riverpod
Future<Expense?> expense(Ref ref, int id) {
  return ref.watch(expensesRepositoryProvider).getById(id);
}

/// Текущий фильтр списка расходов (живёт, пока открыто приложение).
@Riverpod(keepAlive: true)
class ExpenseFilterState extends _$ExpenseFilterState {
  @override
  ExpenseFilter build() => const ExpenseFilter();

  void toggleCategory(ExpenseCategory category) {
    final categories = {...state.categories};
    if (!categories.remove(category)) categories.add(category);
    state = state.copyWith(categories: categories);
  }

  void setPeriod(ExpensePeriod period) {
    state = state.copyWith(period: period);
  }

  void reset() => state = const ExpenseFilter();
}

/// Расходы активного авто после фильтра; `null`, пока данные грузятся.
@riverpod
List<Expense>? filteredExpenses(Ref ref, int carId) {
  final all = ref.watch(expensesProvider(carId)).value;
  if (all == null) return null;
  return ref.watch(expenseFilterStateProvider).apply(all, DateTime.now());
}
