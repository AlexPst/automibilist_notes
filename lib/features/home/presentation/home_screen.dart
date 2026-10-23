import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/display_texts.dart';
import '../../../data/models/car.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/car_texts.dart';
import '../../cars/presentation/widgets/car_avatar.dart';
import '../../cars/presentation/widgets/car_selector_button.dart';
import '../../fuel/application/fuel_providers.dart';
import '../../service/application/service_providers.dart';
import '../../service/domain/reminder_status.dart';
import '../../service/presentation/reminder_texts.dart';
import '../../stats/application/stats_providers.dart';
import '../../stats/domain/stats_period.dart';
import '../../stats/presentation/stats_texts.dart';

/// Сколько напоминаний показывать на Главной.
const homeRemindersLimit = 3;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(activeCarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homeTitle),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context).settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
          const CarSelectorButton(),
        ],
      ),
      body: car == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ActiveCarCard(car: car),
                const SizedBox(height: 12),
                _KeyFigures(carId: car.id),
                const SizedBox(height: 12),
                _MonthSpendingCard(carId: car.id),
                const SizedBox(height: 12),
                _UpcomingReminders(carId: car.id),
              ],
            ),
    );
  }
}

class _ActiveCarCard extends StatelessWidget {
  const _ActiveCarCard({required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CarAvatar(car: car, radius: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carTitle(car), style: theme.textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(carSubtitle(l10n, car)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Плитки «Пробег» и «Средний расход».
class _KeyFigures extends ConsumerWidget {
  const _KeyFigures({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final mileage = ref.watch(currentMileageProvider(carId));
    final average = ref.watch(fuelConsumptionProvider(carId)).average;

    return Row(
      children: [
        Expanded(
          child: _Tile(
            valueKey: const Key('home_mileage_value'),
            icon: Icons.speed_outlined,
            label: l10n.homeMileage,
            value: mileage == null
                ? l10n.noValue
                : l10n.mileageValue(formatInt(mileage)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Tile(
            valueKey: const Key('home_consumption_value'),
            icon: Icons.local_gas_station_outlined,
            label: l10n.homeAvgConsumption,
            value: average == null
                ? l10n.noValue
                : consumptionText(l10n, average),
            onTap: () => context.go(AppRoutes.fuel),
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.valueKey,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  /// Ключ текста значения — для тестов.
  final Key valueKey;
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(value, key: valueKey, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

/// Расходы за текущий месяц: всего и по видам.
class _MonthSpendingCard extends ConsumerWidget {
  const _MonthSpendingCard({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final stats = ref.watch(statsProvider(carId, StatsPeriod.month));
    if (stats == null) return const SizedBox.shrink();

    Widget line(String label, double amount, String key) => Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(formatMoney(amount), key: Key(key)),
        ],
      ),
    );

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.stats),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.homeMonthSpending(monthName(DateTime.now())),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                formatMoney(stats.total),
                key: const Key('home_month_total'),
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              line(l10n.homeFuel, stats.fuel, 'home_month_fuel'),
              line(l10n.homeService, stats.service, 'home_month_service'),
              line(
                l10n.homeOtherExpenses,
                stats.otherExpenses,
                'home_month_other',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ближайшие напоминания — те же, что первыми в списке на вкладке «ТО».
class _UpcomingReminders extends ConsumerWidget {
  const _UpcomingReminders({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final items = ref.watch(reminderStatusesProvider(carId));
    if (items == null) return const SizedBox.shrink();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                l10n.homeUpcoming,
                style: theme.textTheme.titleMedium,
              ),
            ),
            if (items.isEmpty)
              ListTile(
                title: Text(l10n.homeNoReminders),
                trailing: TextButton(
                  onPressed: () => context.go(AppRoutes.service),
                  child: Text(l10n.reminderAdd),
                ),
              )
            else ...[
              for (final item in items.take(homeRemindersLimit))
                ListTile(
                  leading: _UrgencyIcon(urgency: item.status.urgency),
                  title: Text(item.reminder.title),
                  subtitle: Text(
                    [
                      dueDateText(l10n, item.status),
                      dueMileageText(l10n, item.status),
                    ].nonNulls.join('\n'),
                  ),
                  onTap: () =>
                      context.push(AppRoutes.reminderEdit(item.reminder.id)),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.service),
                  child: Text(l10n.homeAllReminders),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Значок срочности — не только цвет, но и форма.
class _UrgencyIcon extends StatelessWidget {
  const _UrgencyIcon({required this.urgency});

  final ReminderUrgency urgency;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return switch (urgency) {
      ReminderUrgency.overdue => Icon(Icons.error, color: colors.error),
      ReminderUrgency.soon => Icon(Icons.schedule, color: colors.tertiary),
      ReminderUrgency.ok => Icon(
        Icons.check_circle_outline,
        color: colors.onSurfaceVariant,
      ),
    };
  }
}
