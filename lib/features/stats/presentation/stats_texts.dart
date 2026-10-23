import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/chart_palette.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/spending.dart';
import '../domain/stats_period.dart';

String statsCategoryLabel(AppLocalizations l10n, StatsCategory c) {
  return switch (c) {
    StatsCategory.fuel => l10n.statsCatFuel,
    StatsCategory.service => l10n.statsCatService,
    StatsCategory.repair => l10n.statsCatRepair,
    StatsCategory.insurance => l10n.statsCatInsurance,
    StatsCategory.tax => l10n.statsCatTax,
    StatsCategory.fines => l10n.statsCatFines,
    StatsCategory.wash => l10n.statsCatWash,
    StatsCategory.other => l10n.statsCatOther,
  };
}

/// Цвет закреплён за категорией и не зависит от её доли.
Color statsCategoryColor(BuildContext context, StatsCategory c) =>
    ChartPalette.slot(context, c.index);

String statsPeriodLabel(AppLocalizations l10n, StatsPeriod p) {
  return switch (p) {
    StatsPeriod.month => l10n.statsPeriodMonth,
    StatsPeriod.year => l10n.statsPeriodYear,
    StatsPeriod.all => l10n.statsPeriodAll,
  };
}

/// «октябрь» — месяц в именительном падеже.
String monthName(DateTime date) => DateFormat.LLLL('ru').format(date);

/// «окт.» — подпись столбца.
String monthShort(DateTime date) => DateFormat.LLL('ru').format(date);

/// «октябрь 2026».
String monthWithYear(DateTime date) => DateFormat('LLLL y', 'ru').format(date);
