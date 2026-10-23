import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/chart_palette.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/spending.dart';
import '../stats_texts.dart';

/// Столбцы расходов по месяцам. Если месяцев много — прокручивается.
class MonthlyBars extends StatelessWidget {
  const MonthlyBars({super.key, required this.months});

  final List<MonthTotal> months;

  static const _barSlot = 40.0;
  static const _axisWidth = 48.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final axisStyle = theme.textTheme.labelSmall?.copyWith(
      color: colors.onSurfaceVariant,
    );
    final barColor = ChartPalette.primary(context);
    final l10n = AppLocalizations.of(context);

    // Ось в тысячах, если суммы большие: подписи короче и не переносятся.
    final maxAmount = months.fold(0.0, (m, e) => e.amount > m ? e.amount : m);
    final inThousands = maxAmount >= 1000;
    final unit = inThousands
        ? l10n.unitThousandRub(currencySymbol)
        : l10n.unitRub(currencySymbol);
    String axisLabel(double value) =>
        formatDecimal(inThousands ? value / 1000 : value);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (months.length * _barSlot + _axisWidth).clamp(
          constraints.maxWidth,
          double.infinity,
        );
        final chart = SizedBox(
          width: width,
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: colors.outlineVariant.withValues(alpha: 0.5),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: _axisWidth,
                    getTitlesWidget: (value, meta) {
                      // Подпись только у делений сетки — максимум столбца
                      // между делениями налез бы на соседнюю подпись.
                      final onGrid = value % meta.appliedInterval == 0;
                      return SideTitleWidget(
                        meta: meta,
                        child: onGrid
                            ? Text(axisLabel(value), style: axisStyle)
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(
                        monthShort(months[value.toInt()].month),
                        style: axisStyle,
                      ),
                    ),
                  ),
                ),
              ),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => colors.inverseSurface,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final m = months[group.x];
                    return BarTooltipItem(
                      '${monthWithYear(m.month)}\n${formatMoney(m.amount)}',
                      TextStyle(color: colors.onInverseSurface),
                    );
                  },
                ),
              ),
              barGroups: [
                for (final (i, m) in months.indexed)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: m.amount,
                        color: barColor,
                        width: 16,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
        final body = width <= constraints.maxWidth
            ? chart
            // Последние месяцы видны сразу, ранние — прокруткой влево.
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: chart,
              );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(unit, style: axisStyle),
            const SizedBox(height: 8),
            body,
          ],
        );
      },
    );
  }
}
