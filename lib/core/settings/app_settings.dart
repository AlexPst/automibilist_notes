import 'package:flutter/material.dart';

/// Валюта: меняется только знак, суммы не пересчитываются.
/// В настройках хранится имя значения.
enum Currency {
  rub('₽'),
  byn('Br'),
  kzt('₸'),
  usd(r'$'),
  eur('€');

  const Currency(this.symbol);

  final String symbol;
}

/// Как показывать расход топлива. В базе он всегда в л/100 км.
enum ConsumptionUnit { litersPer100Km, kmPerLiter }

/// Пользовательские настройки приложения.
class AppSettings {
  const AppSettings({
    this.currency = Currency.rub,
    this.consumptionUnit = ConsumptionUnit.litersPer100Km,
    this.themeMode = ThemeMode.system,
    this.analyticsEnabled = true,
  });

  final Currency currency;
  final ConsumptionUnit consumptionUnit;
  final ThemeMode themeMode;

  /// Согласие на отправку анонимной статистики и отчётов о сбоях.
  final bool analyticsEnabled;

  AppSettings copyWith({
    Currency? currency,
    ConsumptionUnit? consumptionUnit,
    ThemeMode? themeMode,
    bool? analyticsEnabled,
  }) {
    return AppSettings(
      currency: currency ?? this.currency,
      consumptionUnit: consumptionUnit ?? this.consumptionUnit,
      themeMode: themeMode ?? this.themeMode,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.currency == currency &&
      other.consumptionUnit == consumptionUnit &&
      other.themeMode == themeMode &&
      other.analyticsEnabled == analyticsEnabled;

  @override
  int get hashCode =>
      Object.hash(currency, consumptionUnit, themeMode, analyticsEnabled);
}
