import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/settings/app_settings.dart';
import 'core/settings/settings_providers.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/formatters.dart';
import 'core/widgets/first_launch_overlay.dart';
import 'core/widgets/rebuild_on_change.dart';
import 'features/service/presentation/widgets/reminder_effects.dart';
import 'l10n/app_localizations.dart';

class CarDiaryApp extends ConsumerWidget {
  const CarDiaryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settings =
        ref.watch(appSettingsProvider).value ?? const AppSettings();

    final format = DisplayFormat(
      currency: settings.currency,
      consumptionUnit: settings.consumptionUnit,
    );
    displayFormat = format;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: const Locale('ru', 'RU'),
      supportedLocales: const [Locale('ru', 'RU')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      // При смене валюты и единиц всё перерисовывается с новыми значениями.
      builder: (context, child) => RebuildOnChange(
        value: format,
        child: FirstLaunchOverlay(child: ReminderEffects(child: child!)),
      ),
    );
  }
}
