import 'package:intl/intl.dart';

import '../settings/app_settings.dart';

/// Валюта и единицы расхода для форматирования.
///
/// Задаётся из настроек в корне приложения (`CarDiaryApp`); при смене
/// настроек дерево виджетов перестраивается целиком, поэтому функции
/// ниже можно вызывать откуда угодно, не передавая настройки вручную.
class DisplayFormat {
  const DisplayFormat({
    this.currency = Currency.rub,
    this.consumptionUnit = ConsumptionUnit.litersPer100Km,
  });

  final Currency currency;
  final ConsumptionUnit consumptionUnit;

  @override
  bool operator ==(Object other) =>
      other is DisplayFormat &&
      other.currency == currency &&
      other.consumptionUnit == consumptionUnit;

  @override
  int get hashCode => Object.hash(currency, consumptionUnit);
}

DisplayFormat _format = const DisplayFormat();
NumberFormat _money = _moneyFormat(Currency.rub);

DisplayFormat get displayFormat => _format;

set displayFormat(DisplayFormat value) {
  if (value.currency != _format.currency) {
    _money = _moneyFormat(value.currency);
  }
  _format = value;
}

NumberFormat _moneyFormat(Currency c) =>
    NumberFormat.currency(locale: 'ru_RU', symbol: c.symbol);

final _integer = NumberFormat.decimalPattern('ru_RU');
final _decimal = NumberFormat('#,##0.##', 'ru_RU');
final _input = NumberFormat('0.##', 'ru_RU');
final _oneDecimal = NumberFormat('0.0', 'ru_RU');

/// 125000 → «125 000».
String formatInt(int value) => _integer.format(value);

/// 45.5 → «45,5».
String formatDecimal(double value) => _decimal.format(value);

/// Знак выбранной валюты: «₽».
String get currencySymbol => _format.currency.symbol;

/// 2304.5 → «2 304,50 ₽».
String formatMoney(double value) => _money.format(value);

/// 1056.9 → «1056,9» — для полей ввода (без разделителей разрядов).
String formatInput(double value) => _input.format(value);

/// 7.84 → «7,8».
String formatOneDecimal(double value) => _oneDecimal.format(value);

/// Расход из л/100 км в выбранные единицы: 8 л/100 км = 12,5 км/л.
double displayConsumption(double litersPer100Km) {
  return switch (_format.consumptionUnit) {
    ConsumptionUnit.litersPer100Km => litersPer100Km,
    ConsumptionUnit.kmPerLiter => 100 / litersPer100Km,
  };
}

/// Расход (л/100 км) в выбранных единицах, без подписи единиц: «7,8».
String formatConsumption(double litersPer100Km) =>
    formatOneDecimal(displayConsumption(litersPer100Km));

/// 12 окт. 2026 г.
String formatDate(DateTime date) => DateFormat.yMMMd('ru').format(date);

/// Разбирает число, введённое пользователем: «45,5», «45.5», «12 000».
double? parseDecimal(String input) {
  final normalized = input
      .trim()
      .replaceAll(RegExp(r'\s'), '')
      .replaceAll(',', '.');
  if (normalized.isEmpty) return null;
  return double.tryParse(normalized);
}

/// Разбирает целое число, допускает пробелы между разрядами.
int? parseInt(String input) {
  final normalized = input.trim().replaceAll(RegExp(r'\s'), '');
  if (normalized.isEmpty) return null;
  return int.tryParse(normalized);
}
