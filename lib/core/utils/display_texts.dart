import '../../l10n/app_localizations.dart';
import '../settings/app_settings.dart';
import 'formatters.dart';

/// «л/100 км» или «км/л» — по настройкам.
String consumptionUnitLabel(AppLocalizations l10n) {
  return switch (displayFormat.consumptionUnit) {
    ConsumptionUnit.litersPer100Km => l10n.unitL100Km,
    ConsumptionUnit.kmPerLiter => l10n.unitKmPerL,
  };
}

/// Расход (л/100 км) в выбранных единицах с подписью: «7,8 л/100 км».
String consumptionText(AppLocalizations l10n, double litersPer100Km) =>
    l10n.consumptionValue(
      formatConsumption(litersPer100Km),
      consumptionUnitLabel(l10n),
    );
