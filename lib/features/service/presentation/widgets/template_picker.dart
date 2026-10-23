import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/reminder_templates.dart';
import '../reminder_texts.dart';

/// Выбор шаблона нового напоминания.
///
/// `null` — меню закрыли; `(null,)` — «своё» напоминание без шаблона.
Future<(ReminderTemplate?,)?> pickReminderTemplate(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return showModalBottomSheet<(ReminderTemplate?,)>(
    context: context,
    // Поверх нижней панели навигации.
    useRootNavigator: true,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          for (final t in ReminderTemplate.values)
            ListTile(
              leading: Icon(templateIcon(t)),
              title: Text(templateTitle(l10n, t)),
              subtitle: Text(
                intervalText(l10n, km: t.intervalKm, months: t.intervalMonths),
              ),
              onTap: () => Navigator.of(context).pop((t,)),
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: Text(l10n.reminderCustom),
            onTap: () => Navigator.of(context).pop((null,)),
          ),
        ],
      ),
    ),
  );
}
