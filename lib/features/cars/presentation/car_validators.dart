import '../../../core/utils/formatters.dart';
import '../../../l10n/app_localizations.dart';

/// Проверки полей формы автомобиля. Возвращают текст ошибки или `null`.
class CarValidators {
  CarValidators(this.l10n, {DateTime? now}) : _now = now ?? DateTime.now();

  final AppLocalizations l10n;
  final DateTime _now;

  static const maxNameLength = 50;
  static const maxPlateLength = 12;
  static const minYear = 1900;
  static const maxTankVolume = 300.0;
  static const maxMileage = 9999999;

  int get maxYear => _now.year + 1;

  String? brand(String? value) => _requiredText(value, maxNameLength);

  String? model(String? value) => _requiredText(value, maxNameLength);

  String? year(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final year = parseInt(value);
    if (year == null) return l10n.errorNotNumber;
    if (year < minYear || year > maxYear) {
      return l10n.errorRange('$minYear', '$maxYear');
    }
    return null;
  }

  String? plate(String? value) {
    if (value == null) return null;
    if (normalizePlate(value).length > maxPlateLength) {
      return l10n.errorTooLong(maxPlateLength);
    }
    return null;
  }

  String? tankVolume(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final volume = parseDecimal(value);
    if (volume == null) return l10n.errorNotNumber;
    if (volume < 1 || volume > maxTankVolume) {
      return l10n.errorRange('1', formatDecimal(maxTankVolume));
    }
    return null;
  }

  String? initialMileage(String? value) {
    if (value == null || value.trim().isEmpty) return l10n.errorRequired;
    final mileage = parseInt(value);
    if (mileage == null) return l10n.errorNotNumber;
    if (mileage < 0 || mileage > maxMileage) {
      return l10n.errorRange('0', formatInt(maxMileage));
    }
    return null;
  }

  String? _requiredText(String? value, int maxLength) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n.errorRequired;
    if (text.length > maxLength) return l10n.errorTooLong(maxLength);
    return null;
  }
}

/// «а 123 вс  77» → «А 123 ВС 77».
String normalizePlate(String value) =>
    value.trim().replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
