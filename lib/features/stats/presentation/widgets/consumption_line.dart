import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/chart_palette.dart';
import '../../../../core/utils/display_texts.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../fuel/domain/fuel_consumption.dart';

/// Линия расхода топлива по отрезкам «от полного до полного».
class ConsumptionLine extends StatelessWidget {
  const ConsumptionLine({super.key, required this.segments});

  final List<ConsumptionSegment> segments;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final axisStyle = theme.textTheme.labelSmall?.copyWith(
      color: colors.onSurfaceVariant,
    );
    final lineColor = ChartPalette.primary(context);
    final dayMonth = DateFormat('dd.MM', 'ru');

    // Значения уже в выбранных единицах (л/100 км или км/л).
    final values = [
      for (final s in segments) displayConsumption(s.consumption),
    ];
    final low = values.reduce((a, b) => a < b ? a : b);
    final high = values.reduce((a, b) => a > b ? a : b);
    // Поля сверху и снизу, чтобы линия не прилипала к краям.
    final pad = ((high - low) * 0.2).clamp(0.5, double.infinity);

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (segments.length - 1).toDouble().clamp(1, double.infinity),
          minY: (low - pad).clamp(0, double.infinity).floorToDouble(),
          maxY: (high + pad).ceilToDouble(),
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
                reservedSize: 36,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(formatOneDecimal(value), style: axisStyle),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  // Подписи только у первой и последней точки — без каши.
                  final show =
                      value == i &&
                      i < segments.length &&
                      (i == 0 || i == segments.length - 1);
                  return SideTitleWidget(
                    meta: meta,
                    child: show
                        ? Text(
                            dayMonth.format(segments[i].entry.date),
                            style: axisStyle,
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => colors.inverseSurface,
              getTooltipItems: (spots) => [
                for (final spot in spots)
                  LineTooltipItem(
                    '${formatDate(segments[spot.x.toInt()].entry.date)}\n'
                    '${l10n.consumptionValue(formatOneDecimal(spot.y), consumptionUnitLabel(l10n))}',
                    TextStyle(color: colors.onInverseSurface),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (final (i, v) in values.indexed) FlSpot(i.toDouble(), v),
              ],
              color: lineColor,
              barWidth: 2,
              dotData: FlDotData(
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: lineColor,
                      strokeWidth: 2,
                      strokeColor: colors.surfaceContainerLow,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
