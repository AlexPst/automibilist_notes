import 'package:intl/intl.dart';

import '../../../core/utils/formatters.dart';
import '../../../data/models/car.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/fuel_entry.dart';
import '../../../data/models/service_record.dart';
import '../../../l10n/app_localizations.dart';
import '../../expenses/presentation/expense_category_ui.dart';

/// Отчёт по автомобилю в CSV для Excel и Google Таблиц.
///
/// Разделитель «;» и десятичная запятая — так ожидает русский Excel;
/// BOM в начале — чтобы кириллица открылась без выбора кодировки.
String buildCsvReport({
  required AppLocalizations l10n,
  required List<FuelEntry> fuel,
  required List<Expense> expenses,
  required List<ServiceRecord> service,
}) {
  final date = DateFormat('dd.MM.yyyy');
  final money = NumberFormat('0.00', 'ru_RU');
  final number = NumberFormat('0.##', 'ru_RU');

  final rows = <(DateTime, List<String>)>[
    for (final f in fuel)
      (
        f.date,
        [
          date.format(f.date),
          l10n.csvTypeFuel,
          '',
          money.format(f.totalCost),
          '${f.mileage}',
          number.format(f.liters),
          money.format(f.pricePerLiter),
          f.isFullTank ? l10n.csvYes : l10n.csvNo,
          f.station ?? '',
          f.comment ?? '',
        ],
      ),
    for (final e in expenses)
      (
        e.date,
        [
          date.format(e.date),
          l10n.csvTypeExpense,
          expenseCategoryLabel(l10n, e.category),
          money.format(e.amount),
          e.mileage?.toString() ?? '',
          '',
          '',
          '',
          '',
          e.comment ?? '',
        ],
      ),
    for (final s in service)
      (
        s.date,
        [
          date.format(s.date),
          l10n.csvTypeService,
          s.title,
          s.cost == null ? '' : money.format(s.cost!),
          '${s.mileage}',
          '',
          '',
          '',
          s.station ?? '',
          s.comment ?? '',
        ],
      ),
  ]..sort((a, b) => a.$1.compareTo(b.$1));

  final header = [
    l10n.csvDate,
    l10n.csvType,
    l10n.csvCategory,
    l10n.csvAmount(currencySymbol),
    l10n.csvMileage,
    l10n.csvLiters,
    l10n.csvPrice(currencySymbol),
    l10n.csvFullTank,
    l10n.csvPlace,
    l10n.csvComment,
  ];

  final lines = [
    header,
    for (final r in rows) r.$2,
  ].map((cells) => cells.map(csvCell).join(';'));
  return '﻿${lines.join('\r\n')}\r\n';
}

/// Ячейка в кавычках, если в ней есть разделитель, кавычки или перенос.
String csvCell(String value) {
  if (!value.contains(RegExp('[;"\r\n]'))) return value;
  return '"${value.replaceAll('"', '""')}"';
}

/// «cardiary-lada-vesta-2026-10-23.csv».
String csvFileName(Car car, DateTime now) {
  final name = '${car.brand}-${car.model}'
      .toLowerCase()
      .replaceAll(RegExp(r'[^\p{L}\p{N}]+', unicode: true), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  final day = DateFormat('yyyy-MM-dd').format(now);
  return 'cardiary-$name-$day.csv';
}
