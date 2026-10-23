import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/service_record.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/widgets/car_selector_button.dart';
import '../application/service_providers.dart';
import 'widgets/reminder_card.dart';
import 'widgets/template_picker.dart';

/// Вкладка «ТО»: напоминания и история работ активного автомобиля.
class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key});

  @override
  ConsumerState<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this)
    ..addListener(() => setState(() {}));

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _addReminder() async {
    final picked = await pickReminderTemplate(context);
    if (picked == null || !mounted) return;
    context.push(AppRoutes.reminderNew(picked.$1?.name));
  }

  Future<void> _scheduleTestNotification() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(reminderNotificationsProvider).scheduleTest(DateTime.now());
    messenger.showSnackBar(SnackBar(content: Text(l10n.notifTestScheduled)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final car = ref.watch(activeCarProvider);
    final onReminders = _tabs.index == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.serviceTitle),
        actions: [
          // Только в отладочной сборке: проверка уведомлений на устройстве.
          if (kDebugMode)
            PopupMenuButton<void>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: _scheduleTestNotification,
                  child: Text(l10n.notifTestMenu),
                ),
              ],
            ),
          const CarSelectorButton(),
        ],
        bottom: TabBar(
          controller: _tabs,
          tabs: [
            Tab(text: l10n.serviceTabReminders),
            Tab(text: l10n.serviceTabHistory),
          ],
        ),
      ),
      floatingActionButton: car == null
          ? null
          : FloatingActionButton(
              tooltip: onReminders ? l10n.reminderAdd : l10n.serviceRecordAdd,
              onPressed: onReminders
                  ? _addReminder
                  : () => context.push(AppRoutes.serviceRecordNew()),
              child: const Icon(Icons.add),
            ),
      body: car == null
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabs,
              children: [
                _RemindersTab(carId: car.id),
                _HistoryTab(carId: car.id),
              ],
            ),
    );
  }
}

class _RemindersTab extends ConsumerWidget {
  const _RemindersTab({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(reminderStatusesProvider(carId));
    if (items == null) return const Center(child: CircularProgressIndicator());
    if (items.isEmpty) {
      return _Empty(
        icon: Icons.notifications_none,
        title: l10n.remindersEmptyTitle,
        text: l10n.remindersEmptyText,
      );
    }
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 88),
      children: [for (final item in items) ReminderCard(item: item)],
    );
  }
}

class _HistoryTab extends ConsumerWidget {
  const _HistoryTab({required this.carId});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final records = ref.watch(serviceRecordsProvider(carId)).value;
    if (records == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (records.isEmpty) {
      return _Empty(
        icon: Icons.build_outlined,
        title: l10n.historyEmptyTitle,
        text: l10n.historyEmptyText,
      );
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 88),
      children: [for (final r in records) _RecordTile(record: r)],
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({required this.record});

  final ServiceRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final details = [
      '${formatDate(record.date)} · '
          '${l10n.mileageValue(formatInt(record.mileage))}',
      if (record.station != null) record.station!,
    ].join('\n');

    return ListTile(
      key: ValueKey('service_${record.id}'),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.secondaryContainer,
        child: Icon(
          Icons.build_outlined,
          color: theme.colorScheme.onSecondaryContainer,
        ),
      ),
      title: Text(record.title),
      subtitle: Text(details),
      isThreeLine: record.station != null,
      trailing: record.cost == null
          ? null
          : Text(formatMoney(record.cost!), style: theme.textTheme.titleMedium),
      onTap: () => context.push(AppRoutes.serviceRecordEdit(record.id)),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
