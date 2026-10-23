import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../data/models/expense_category.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/expenses_providers.dart';
import '../../domain/expense_filter.dart';
import '../expense_category_ui.dart';

/// Две строки чипов: период и категории.
class ExpenseFilterBar extends ConsumerWidget {
  const ExpenseFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final filter = ref.watch(expenseFilterStateProvider);
    final notifier = ref.read(expenseFilterStateProvider.notifier);
    final period = filter.period;

    Widget periodChip(String label, ExpensePeriod value, bool selected) {
      return ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => notifier.setPeriod(value),
      );
    }

    return Column(
      children: [
        _ChipRow(
          children: [
            periodChip(l10n.periodAll, const AllTime(), period is AllTime),
            periodChip(
              l10n.periodMonth,
              const ThisMonth(),
              period is ThisMonth,
            ),
            periodChip(l10n.periodYear, const ThisYear(), period is ThisYear),
            ChoiceChip(
              key: const Key('period_custom'),
              label: Text(
                period is CustomPeriod
                    ? l10n.periodRange(
                        formatDate(period.from),
                        formatDate(period.to),
                      )
                    : l10n.periodCustom,
              ),
              selected: period is CustomPeriod,
              onSelected: (_) => _pickRange(context, notifier, period),
            ),
          ],
        ),
        _ChipRow(
          children: [
            for (final category in ExpenseCategory.values)
              FilterChip(
                avatar: Icon(expenseCategoryIcon(category), size: 18),
                label: Text(expenseCategoryLabel(l10n, category)),
                selected: filter.categories.contains(category),
                showCheckmark: false,
                onSelected: (_) => notifier.toggleCategory(category),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickRange(
    BuildContext context,
    ExpenseFilterState notifier,
    ExpensePeriod current,
  ) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(now.year + 1, 12, 31),
      initialDateRange: current is CustomPeriod
          ? DateTimeRange(start: current.from, end: current.to)
          : null,
    );
    if (range != null) {
      notifier.setPeriod(CustomPeriod(from: range.start, to: range.end));
    }
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          for (final (i, child) in children.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            child,
          ],
        ],
      ),
    );
  }
}
