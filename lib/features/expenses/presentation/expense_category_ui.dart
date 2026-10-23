import 'package:flutter/material.dart';

import '../../../data/models/expense_category.dart';
import '../../../l10n/app_localizations.dart';

String expenseCategoryLabel(AppLocalizations l10n, ExpenseCategory category) {
  return switch (category) {
    ExpenseCategory.wash => l10n.categoryWash,
    ExpenseCategory.repair => l10n.categoryRepair,
    ExpenseCategory.parts => l10n.categoryParts,
    ExpenseCategory.insurance => l10n.categoryInsurance,
    ExpenseCategory.fines => l10n.categoryFines,
    ExpenseCategory.parking => l10n.categoryParking,
    ExpenseCategory.tax => l10n.categoryTax,
    ExpenseCategory.other => l10n.categoryOther,
  };
}

IconData expenseCategoryIcon(ExpenseCategory category) {
  return switch (category) {
    ExpenseCategory.wash => Icons.local_car_wash_outlined,
    ExpenseCategory.repair => Icons.car_repair_outlined,
    ExpenseCategory.parts => Icons.settings_outlined,
    ExpenseCategory.insurance => Icons.shield_outlined,
    ExpenseCategory.fines => Icons.gavel_outlined,
    ExpenseCategory.parking => Icons.local_parking_outlined,
    ExpenseCategory.tax => Icons.account_balance_outlined,
    ExpenseCategory.other => Icons.more_horiz,
  };
}
