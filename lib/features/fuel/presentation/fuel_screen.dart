import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/display_texts.dart';
import '../../../data/models/fuel_entry.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/widgets/car_selector_button.dart';
import '../application/fuel_providers.dart';
import '../domain/fuel_consumption.dart';

/// Список заправок активного автомобиля с расходом.
class FuelScreen extends ConsumerWidget {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final car = ref.watch(activeCarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fuelTitle),
        actions: const [CarSelectorButton()],
      ),
      floatingActionButton: car == null
          ? null
          : FloatingActionButton(
              tooltip: l10n.fuelAdd,
              onPressed: () => context.push(AppRoutes.fuelNew),
              child: const Icon(Icons.add),
            ),
      body: car == null
          ? const Center(child: CircularProgressIndicator())
          : _FuelList(carId: car.id),
    );
  }
}

class _FuelList extends ConsumerWidget {
  const _FuelList({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(fuelEntriesProvider(carId)).value;
    if (entries == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (entries.isEmpty) return const _EmptyFuel();

    final consumption = ref.watch(fuelConsumptionProvider(carId));
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: entries.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return _AverageCard(consumption: consumption);
        final entry = entries[index - 1];
        return _FuelTile(
          entry: entry,
          consumption: consumption.byEntryId[entry.id],
        );
      },
    );
  }
}

class _AverageCard extends StatelessWidget {
  const _AverageCard({required this.consumption});

  final FuelConsumption consumption;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final average = consumption.average;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.speed, size: 32, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.fuelAvgConsumption,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    average == null
                        ? l10n.fuelAvgConsumptionEmpty
                        : consumptionText(l10n, average),
                    key: const Key('fuel_average'),
                    style: average == null
                        ? theme.textTheme.bodyMedium
                        : theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FuelTile extends StatelessWidget {
  const _FuelTile({required this.entry, required this.consumption});

  final FuelEntry entry;

  /// Расход по этой заправке или `null`, если он не считается.
  final double? consumption;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final details = [
      '${l10n.mileageValue(formatInt(entry.mileage))} · '
          '${formatMoney(entry.totalCost)}',
      l10n.fuelLitersLine(
        formatDecimal(entry.liters),
        formatMoney(entry.pricePerLiter),
      ),
      if (entry.station != null) entry.station!,
    ].join('\n');

    return ListTile(
      key: ValueKey('fuel_${entry.id}'),
      isThreeLine: true,
      title: Text.rich(
        TextSpan(
          text: formatDate(entry.date),
          children: [
            if (!entry.isFullTank)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Tooltip(
                    message: l10n.fuelPartial,
                    child: Icon(
                      Icons.battery_3_bar,
                      size: 18,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      subtitle: Text(details),
      trailing: consumption == null
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatConsumption(consumption!),
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  consumptionUnitLabel(l10n),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
      onTap: () => context.push(AppRoutes.fuelEdit(entry.id)),
    );
  }
}

class _EmptyFuel extends StatelessWidget {
  const _EmptyFuel();

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
              Icons.local_gas_station_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(l10n.fuelEmptyTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(l10n.fuelEmptyText, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
