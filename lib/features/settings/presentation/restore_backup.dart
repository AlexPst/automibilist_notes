import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/analytics/analytics_providers.dart';
import '../../../core/files/file_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/snack_bars.dart';
import '../../../data/backup/backup_service.dart';
import '../../../data/data_providers.dart';
import '../../../l10n/app_localizations.dart';

/// Выбор файла копии, сводка, подтверждение и восстановление.
/// Доступно из настроек и с экрана первого автомобиля.
Future<void> restoreFromBackup(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final service = ref.read(backupServiceProvider);

  final bytes = await ref.read(fileTransferProvider).pick();
  if (bytes == null || !context.mounted) return;

  final Backup backup;
  try {
    backup = service.read(bytes);
  } on BackupException catch (e) {
    messenger.show(
      SnackBar(
        content: Text(switch (e.problem) {
          BackupProblem.invalidFile => l10n.backupInvalid,
          BackupProblem.newerVersion => l10n.backupNewer,
        }),
      ),
    );
    return;
  }

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.backupRestoreTitle),
      content: Text(
        l10n.backupRestoreMessage(
          formatDate(backup.createdAt),
          backup.cars,
          backup.fuelEntries,
          backup.expenses,
          backup.reminders,
          backup.serviceRecords,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.backupRestoreConfirm),
        ),
      ],
    ),
  );
  if (confirmed != true) return;

  try {
    await service.restore(backup);
    ref.read(analyticsHolderProvider).log(AnalyticsEvent.backupRestored);
    messenger.show(SnackBar(content: Text(l10n.backupRestored)));
  } on BackupException {
    messenger.show(SnackBar(content: Text(l10n.backupInvalid)));
  }
}
