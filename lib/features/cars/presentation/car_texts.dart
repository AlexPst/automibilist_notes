import '../../../core/utils/formatters.dart';
import '../../../data/models/car.dart';
import '../../../data/models/fuel_type.dart';
import '../../../l10n/app_localizations.dart';

String fuelTypeLabel(AppLocalizations l10n, FuelType type) {
  return switch (type) {
    FuelType.ai92 => l10n.fuelAi92,
    FuelType.ai95 => l10n.fuelAi95,
    FuelType.ai98 => l10n.fuelAi98,
    FuelType.ai100 => l10n.fuelAi100,
    FuelType.diesel => l10n.fuelDiesel,
    FuelType.lpg => l10n.fuelLpg,
    FuelType.cng => l10n.fuelCng,
  };
}

/// «Lada Vesta».
String carTitle(Car car) => '${car.brand} ${car.model}';

/// «А 123 ВС 77 · 2019 г. · АИ-95».
String carSubtitle(AppLocalizations l10n, Car car) {
  return [
    if (car.plateNumber != null) car.plateNumber!,
    if (car.year != null) l10n.carYearValue('${car.year}'),
    fuelTypeLabel(l10n, car.fuelType),
    if (car.tankVolume != null)
      l10n.carTankVolumeValue(formatDecimal(car.tankVolume!)),
  ].join(' · ');
}
