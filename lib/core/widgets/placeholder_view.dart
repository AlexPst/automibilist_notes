import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Заглушка для ещё не реализованного раздела.
class PlaceholderView extends StatelessWidget {
  const PlaceholderView({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).placeholderSoon,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
