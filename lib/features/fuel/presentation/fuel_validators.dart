import '../../../core/utils/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/mileage_validation.dart';

/// Проверки полей формы заправки. Возвращают текст ошибки или `null`.
class FuelValidators {
  FuelValidators(this.l10n);

  final AppLocalizations l10n;

  static const maxLiters = 500.0;
  static const maxPrice = 1000.0;
  static const maxTotal = 1000000.0;

  String? mileage(String? value, MileageBounds bounds) {
    final mileage = parseInt(value ?? '');
    if (value == null || value.trim().isEmpty) return l10n.errorRequired;
    if (mileage == null) return l10n.errorNotNumber;
    return switch (bounds.check(mileage)) {
      null => null,
      MileageProblem.belowInitial => l10n.errorMileageBelowInitial(
        formatInt(bounds.min),
      ),
      MileageProblem.belowPrevious => l10n.errorMileageBelowPrevious(
        formatInt(bounds.min),
      ),
      MileageProblem.aboveNext => l10n.errorMileageAboveNext(
        formatInt(bounds.max!),
      ),
    };
  }

  String? liters(String? value) => _amount(value, maxLiters);

  String? price(String? value) => _amount(value, maxPrice);

  String? total(String? value) => _amount(value, maxTotal);

  String? _amount(String? value, double max) {
    if (value == null || value.trim().isEmpty) return l10n.errorRequired;
    final number = parseDecimal(value);
    if (number == null) return l10n.errorNotNumber;
    if (number <= 0) return l10n.errorPositive;
    if (number > max) return l10n.errorRange('0', formatDecimal(max));
    return null;
  }
}
