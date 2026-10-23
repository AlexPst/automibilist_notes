import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/spending.dart';
import '../stats_texts.dart';

/// Кольцевая диаграмма расходов по категориям с легендой.
///
/// Легенда показывает сумму и долю — цвет никогда не единственный
/// способ узнать категорию.
class CategoryDonut extends StatelessWidget {
  const CategoryDonut({super.key, required this.byCategory});

  final Map<StatsCategory, double> byCategory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final total = byCategory.values.fold(0.0, (a, b) => a + b);
    final surface = theme.colorScheme.surfaceContainerLow;

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: -90,
                  centerSpaceRadius: 64,
                  // Зазор цвета фона между секторами.
                  sectionsSpace: 2,
                  borderData: FlBorderData(show: false),
                  sections: [
                    for (final MapEntry(key: c, value: v) in byCategory.entries)
                      PieChartSectionData(
                        value: v,
                        color: statsCategoryColor(context, c),
                        radius: 28,
                        showTitle: false,
                        borderSide: BorderSide(color: surface, width: 0),
                      ),
                  ],
                ),
              ),
              Text(
                formatMoney(total),
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (final MapEntry(key: c, value: v) in byCategory.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statsCategoryColor(context, c),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(statsCategoryLabel(l10n, c))),
                Text(formatMoney(v), style: theme.textTheme.bodyMedium),
                SizedBox(
                  width: 52,
                  child: Text(
                    '${(v / total * 100).round()} %',
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
