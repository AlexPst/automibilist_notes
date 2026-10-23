import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/service_providers.dart';
import '../../domain/reminder_status.dart';
import '../reminder_texts.dart';

/// Карточка напоминания: сроки, сколько осталось, кнопка «Выполнено».
class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key, required this.item});

  final ReminderWithStatus item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final reminder = item.reminder;
    final status = item.status;

    final (background, foreground) = switch (status.urgency) {
      ReminderUrgency.overdue => (
        colors.errorContainer,
        colors.onErrorContainer,
      ),
      ReminderUrgency.soon => (
        colors.tertiaryContainer,
        colors.onTertiaryContainer,
      ),
      ReminderUrgency.ok => (null, null),
    };

    final dateLine = dueDateText(l10n, status);
    final mileageLine = dueMileageText(l10n, status);

    return Card(
      key: ValueKey('reminder_${reminder.id}'),
      color: background,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.reminderEdit(reminder.id)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: foreground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: foreground,
                  ),
                ),
                Text(
                  reminderIntervalText(l10n, reminder),
                  style: theme.textTheme.bodySmall?.copyWith(color: foreground),
                ),
                const SizedBox(height: 8),
                if (dateLine != null)
                  _Line(icon: Icons.event_outlined, text: dateLine),
                if (mileageLine != null)
                  _Line(icon: Icons.speed_outlined, text: mileageLine),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: foreground),
                    onPressed: () =>
                        context.push(AppRoutes.serviceRecordNew(reminder.id)),
                    icon: const Icon(Icons.check),
                    label: Text(l10n.reminderDone),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: DefaultTextStyle.of(context).style.color),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
