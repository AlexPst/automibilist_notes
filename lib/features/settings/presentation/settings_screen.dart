import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/analytics/analytics_providers.dart';
import '../../../core/files/file_providers.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/settings_providers.dart';
import '../../../core/widgets/snack_bars.dart';
import '../../../data/backup/backup_service.dart';
import '../../../data/data_providers.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../expenses/application/expenses_providers.dart';
import '../../fuel/application/fuel_providers.dart';
import '../../service/application/service_providers.dart';
import '../application/csv_report.dart';
import 'restore_backup.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings =
        ref.watch(appSettingsProvider).value ?? const AppSettings();
    final repository = ref.read(settingsRepositoryProvider);
    final analytics = ref.watch(analyticsHolderProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _Header(l10n.settingsAppearance),
          _Labeled(
            label: l10n.settingsTheme,
            child: SegmentedButton<ThemeMode>(
              key: const Key('settings_theme'),
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text(l10n.themeSystem),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text(l10n.themeLight),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text(l10n.themeDark),
                ),
              ],
              selected: {settings.themeMode},
              onSelectionChanged: (s) => repository.setThemeMode(s.single),
            ),
          ),
          _Header(l10n.settingsUnits),
          ListTile(
            key: const Key('settings_currency'),
            title: Text(l10n.settingsCurrency),
            subtitle: Text(
              '${_currencyName(l10n, settings.currency)} '
              '(${settings.currency.symbol})\n${l10n.settingsCurrencyHint}',
            ),
            isThreeLine: true,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickCurrency(context, ref, settings.currency),
          ),
          _Labeled(
            label: l10n.settingsConsumption,
            child: SegmentedButton<ConsumptionUnit>(
              key: const Key('settings_unit'),
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: ConsumptionUnit.litersPer100Km,
                  label: Text(l10n.unitL100Km),
                ),
                ButtonSegment(
                  value: ConsumptionUnit.kmPerLiter,
                  label: Text(l10n.unitKmPerL),
                ),
              ],
              selected: {settings.consumptionUnit},
              onSelectionChanged: (s) =>
                  repository.setConsumptionUnit(s.single),
            ),
          ),
          if (analytics.isAvailable) ...[
            _Header(l10n.settingsPrivacy),
            SwitchListTile(
              key: const Key('settings_analytics'),
              title: Text(l10n.settingsAnalytics),
              subtitle: Text(l10n.settingsAnalyticsHint),
              value: settings.analyticsEnabled,
              onChanged: (value) {
                repository.setAnalyticsEnabled(value);
                analytics.setEnabled(value);
              },
            ),
          ],
          _Header(l10n.settingsData),
          ListTile(
            key: const Key('settings_backup'),
            leading: const Icon(Icons.backup_outlined),
            title: Text(l10n.backupCreate),
            subtitle: Text(l10n.backupCreateHint),
            onTap: () => _createBackup(context, ref),
          ),
          ListTile(
            key: const Key('settings_restore'),
            leading: const Icon(Icons.restore),
            title: Text(l10n.backupRestore),
            subtitle: Text(l10n.backupRestoreHint),
            onTap: () => restoreFromBackup(context, ref),
          ),
          ListTile(
            key: const Key('settings_csv'),
            leading: const Icon(Icons.table_view_outlined),
            title: Text(l10n.csvExport),
            subtitle: Text(l10n.csvExportHint),
            onTap: () => _exportCsv(context, ref),
          ),
        ],
      ),
    );
  }

  static String _currencyName(AppLocalizations l10n, Currency c) {
    return switch (c) {
      Currency.rub => l10n.currencyRub,
      Currency.byn => l10n.currencyByn,
      Currency.kzt => l10n.currencyKzt,
      Currency.usd => l10n.currencyUsd,
      Currency.eur => l10n.currencyEur,
    };
  }

  Future<void> _pickCurrency(
    BuildContext context,
    WidgetRef ref,
    Currency current,
  ) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showDialog<Currency>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.settingsCurrency),
        children: [
          RadioGroup<Currency>(
            groupValue: current,
            onChanged: (c) => Navigator.of(context).pop(c),
            child: Column(
              children: [
                for (final c in Currency.values)
                  RadioListTile<Currency>(
                    value: c,
                    title: Text('${_currencyName(l10n, c)} (${c.symbol})'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    if (picked != null) {
      await ref.read(settingsRepositoryProvider).setCurrency(picked);
    }
  }

  Future<void> _createBackup(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final bytes = await ref.read(backupServiceProvider).export(now);
    ref.read(analyticsHolderProvider).log(AnalyticsEvent.backupCreated);
    if (!context.mounted) return;
    await _saveOrShare(
      context,
      ref,
      fileName: BackupService.fileName(now),
      bytes: bytes,
      mimeType: 'application/json',
    );
  }

  Future<void> _exportCsv(BuildContext context, WidgetRef ref) async {
    final car = ref.read(activeCarProvider);
    if (car == null) return;
    final l10n = AppLocalizations.of(context);
    final csv = buildCsvReport(
      l10n: l10n,
      fuel: await ref.read(fuelEntriesProvider(car.id).future),
      expenses: await ref.read(expensesProvider(car.id).future),
      service: await ref.read(serviceRecordsProvider(car.id).future),
    );
    if (!context.mounted) return;
    ref.read(analyticsHolderProvider).log(AnalyticsEvent.csvExported);
    await _saveOrShare(
      context,
      ref,
      fileName: csvFileName(car, DateTime.now()),
      bytes: utf8.encode(csv),
      mimeType: 'text/csv',
    );
  }

  /// Меню «Сохранить в файл / Отправить».
  Future<void> _saveOrShare(
    BuildContext context,
    WidgetRef ref, {
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final files = ref.read(fileTransferProvider);

    final share = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: Text(l10n.fileSave),
              onTap: () => Navigator.of(context).pop(false),
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: Text(l10n.fileShare),
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
    if (share == null) return;

    try {
      if (share) {
        await files.share(fileName: fileName, bytes: bytes, mimeType: mimeType);
      } else if (await files.save(
        fileName: fileName,
        bytes: bytes,
        mimeType: mimeType,
      )) {
        messenger.show(SnackBar(content: Text(l10n.fileSaved)));
      }
    } catch (_) {
      messenger.show(SnackBar(content: Text(l10n.fileError)));
    }
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

/// Подпись и элемент управления под ней на всю ширину.
class _Labeled extends StatelessWidget {
  const _Labeled({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: child),
        ],
      ),
    );
  }
}
