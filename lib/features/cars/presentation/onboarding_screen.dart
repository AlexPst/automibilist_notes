import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/presentation/restore_backup.dart';

/// Показывается, пока не добавлен ни один автомобиль.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.directions_car_filled_outlined,
                  size: 96,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.onboardingTitle,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.onboardingText,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () => context.push(AppRoutes.onboardingNewCar),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.carAdd),
                ),
                const SizedBox(height: 8),
                // После переустановки данные возвращают отсюда.
                TextButton.icon(
                  onPressed: () => restoreFromBackup(context, ref),
                  icon: const Icon(Icons.restore),
                  label: Text(l10n.onboardingRestore),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
