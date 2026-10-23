import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../data/models/reminder.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/reminder_status.dart';
import '../domain/reminder_templates.dart';

String templateTitle(AppLocalizations l10n, ReminderTemplate t) {
  return switch (t) {
    ReminderTemplate.oil => l10n.templateOil,
    ReminderTemplate.airFilter => l10n.templateAirFilter,
    ReminderTemplate.cabinFilter => l10n.templateCabinFilter,
    ReminderTemplate.fuelFilter => l10n.templateFuelFilter,
    ReminderTemplate.osago => l10n.templateOsago,
    ReminderTemplate.inspection => l10n.templateInspection,
    ReminderTemplate.summerTyres => l10n.templateSummerTyres,
    ReminderTemplate.winterTyres => l10n.templateWinterTyres,
  };
}

IconData templateIcon(ReminderTemplate t) {
  return switch (t) {
    ReminderTemplate.oil => Icons.oil_barrel_outlined,
    ReminderTemplate.airFilter => Icons.air,
    ReminderTemplate.cabinFilter => Icons.filter_alt_outlined,
    ReminderTemplate.fuelFilter => Icons.local_gas_station_outlined,
    ReminderTemplate.osago => Icons.shield_outlined,
    ReminderTemplate.inspection => Icons.fact_check_outlined,
    ReminderTemplate.summerTyres => Icons.wb_sunny_outlined,
    ReminderTemplate.winterTyres => Icons.ac_unit,
  };
}

/// «каждые 10 000 км или 12 мес.»
String intervalText(AppLocalizations l10n, {int? km, int? months}) {
  return [
    if (km != null) l10n.reminderEveryKm(formatInt(km)),
    if (months != null) l10n.reminderEveryMonths('$months'),
  ].join(l10n.reminderOr);
}

String reminderIntervalText(AppLocalizations l10n, Reminder r) =>
    intervalText(l10n, km: r.intervalKm, months: r.intervalMonths);

/// «15 мар. 2027 г. · через 143 дня».
String? dueDateText(AppLocalizations l10n, ReminderStatus s) {
  final due = s.dueDate;
  final days = s.daysLeft;
  if (due == null || days == null) return null;
  final left = days > 0
      ? l10n.dueInDays(days)
      : days == 0
      ? l10n.dueToday
      : l10n.overdueDays(-days);
  return '${formatDate(due)} · $left';
}

/// «26 000 км · через 1 200 км».
String? dueMileageText(AppLocalizations l10n, ReminderStatus s) {
  final due = s.dueMileage;
  if (due == null) return null;
  final km = s.kmLeft;
  final left = km == null
      ? null
      : km > 0
      ? l10n.dueInKm(formatInt(km))
      : km == 0
      ? l10n.dueNowKm
      : l10n.overdueKm(formatInt(-km));
  return [l10n.mileageValue(formatInt(due)), ?left].join(' · ');
}
