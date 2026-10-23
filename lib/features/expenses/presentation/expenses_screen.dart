import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/expense.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/widgets/car_selector_button.dart';
import '../application/expenses_providers.dart';
import '../domain/expense_filter.dart';
import 'expense_category_ui.dart';
import 'widgets/expense_filter_bar.dart';

/// Прочие расходы активного автомобиля с фильтром.
class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final car = ref.watch(activeCarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.expensesTitle),
        actions: const [CarSelectorButton()],
      ),
      floatingActionButton: car == null
          ? null
          : FloatingActionButton(
              tooltip: l10n.expenseAdd,
              onPressed: () => context.push(AppRoutes.expenseNew),
              child: const Icon(Icons.add),
            ),
      body: car == null
          ? const Center(child: CircularProgressIndicator())
          : _ExpensesBody(carId: car.id),
    );
  }
}

class _ExpensesBody extends ConsumerWidget {
  const _ExpensesBody({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final all = ref.watch(expensesProvider(carId)).value;
    final filtered = ref.watch(filteredExpensesProvider(carId));
    if (all == null || filtered == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (all.isEmpty) return const _EmptyExpenses();

    return Column(
      children: [
        const ExpenseFilterBar(),
        Expanded(
          child: filtered.isEmpty
              ? const _NothingFound()
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 88),
                  itemCount: filtered.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) return _TotalCard(expenses: filtered);
                    return _ExpenseTile(expense: filtered[index - 1]);
                  },
                ),
        ),
      ],
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.expensesTotal, style: theme.textTheme.bodySmall),
                  Text(
                    formatMoney(totalAmount(expenses)),
                    key: const Key('expenses_total'),
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Text(l10n.expensesCount(expenses.length)),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final details = [
      [
        formatDate(expense.date),
        if (expense.mileage != null)
          l10n.mileageValue(formatInt(expense.mileage!)),
      ].join(' · '),
      if (expense.comment != null) expense.comment!,
    ].join('\n');

    return ListTile(
      key: ValueKey('expense_${expense.id}'),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.secondaryContainer,
        child: Icon(
          expenseCategoryIcon(expense.category),
          color: theme.colorScheme.onSecondaryContainer,
        ),
      ),
      title: Text(expenseCategoryLabel(l10n, expense.category)),
      subtitle: Text(details, maxLines: 3, overflow: TextOverflow.ellipsis),
      isThreeLine: expense.comment != null,
      trailing: Text(
        formatMoney(expense.amount),
        style: theme.textTheme.titleMedium,
      ),
      onTap: () => context.push(AppRoutes.expenseEdit(expense.id)),
    );
  }
}

class _NothingFound extends ConsumerWidget {
  const _NothingFound();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.expensesNothingFound, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () =>
                  ref.read(expenseFilterStateProvider.notifier).reset(),
              child: Text(l10n.expensesResetFilter),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyExpenses extends StatelessWidget {
  const _EmptyExpenses();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.payments_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(l10n.expensesEmptyTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(l10n.expensesEmptyText, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
