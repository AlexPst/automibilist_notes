import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/utils/display_texts.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/widgets/car_selector_button.dart';
import '../application/stats_providers.dart';
import '../domain/stats_period.dart';
import '../domain/stats_summary.dart';
import 'stats_texts.dart';
import 'widgets/category_donut.dart';
import 'widgets/consumption_line.dart';
import 'widgets/monthly_bars.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final car = ref.watch(activeCarProvider);
    final period = ref.watch(selectedStatsPeriodProvider);
    final stats = car == null ? null : ref.watch(statsProvider(car.id, period));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statsTitle),
        actions: const [CarSelectorButton()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<StatsPeriod>(
                segments: [
                  for (final p in StatsPeriod.values)
                    ButtonSegment(
                      value: p,
                      label: Text(statsPeriodLabel(l10n, p)),
                    ),
                ],
                selected: {period},
                showSelectedIcon: false,
                onSelectionChanged: (s) => ref
                    .read(selectedStatsPeriodProvider.notifier)
                    .select(s.single),
              ),
            ),
          ),
          Expanded(
            child: stats == null
                ? const Center(child: CircularProgressIndicator())
                : stats.isEmpty
                ? const _Empty()
                : _StatsBody(stats: stats),
          ),
        ],
      ),
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody({required this.stats});

  final StatsSummary stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final average = stats.averageConsumption;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        _SummaryCard(stats: stats),
        if (stats.byCategory.isNotEmpty)
          _Section(
            title: l10n.statsByCategory,
            child: CategoryDonut(byCategory: stats.byCategory),
          ),
        _Section(
          title: l10n.statsByMonth,
          child: MonthlyBars(months: stats.byMonth),
        ),
        _Section(
          title: l10n.statsConsumption(consumptionUnitLabel(l10n)),
          subtitle: average == null
              ? null
              : l10n.statsAvgForPeriod(consumptionText(l10n, average)),
          child: stats.segments.isEmpty
              ? Text(
                  l10n.statsConsumptionEmpty,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : ConsumptionLine(segments: stats.segments),
        ),
      ],
    );
  }
}

/// Главные цифры периода: потрачено, проехано, стоимость километра.
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.stats});

  final StatsSummary stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final perKm = stats.costPerKm;
    final fuelPerKm = stats.fuelCostPerKm;

    Widget figure(String label, String value, [String? note]) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: muted),
          const SizedBox(height: 2),
          Text(value, style: theme.textTheme.titleMedium),
          if (note != null) Text(note, style: muted),
        ],
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.statsTotal, style: muted),
            Text(
              formatMoney(stats.total),
              key: const Key('stats_total'),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                figure(
                  l10n.statsDistance,
                  l10n.mileageValue(formatInt(stats.distance)),
                ),
                const SizedBox(width: 16),
                figure(
                  l10n.statsCostPerKm,
                  perKm == null
                      ? l10n.noValue
                      : l10n.costPerKmValue(formatMoney(perKm)),
                  fuelPerKm == null || fuelPerKm == 0
                      ? null
                      : l10n.statsFuelCostPerKm(formatMoney(fuelPerKm)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child, this.subtitle});

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            if (subtitle != null)
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

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
              Icons.bar_chart_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(l10n.statsEmptyTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(l10n.statsEmptyText, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
