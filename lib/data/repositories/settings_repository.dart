import 'package:flutter/material.dart';

import '../../core/settings/app_settings.dart';
import '../daos/settings_dao.dart';

class SettingsRepository {
  SettingsRepository(this._dao);

  final SettingsDao _dao;

  static const _activeCarKey = 'active_car_id';
  static const _firstLaunchDoneKey = 'first_launch_done';
  static const _currencyKey = 'currency';
  static const _consumptionUnitKey = 'consumption_unit';
  static const _themeModeKey = 'theme_mode';
  static const _analyticsKey = 'analytics_enabled';

  /// Id выбранного пользователем автомобиля (может указывать на удалённый).
  Stream<int?> watchActiveCarId() {
    return _dao
        .watchValue(_activeCarKey)
        .map((value) => value == null ? null : int.tryParse(value));
  }

  Future<void> setActiveCarId(int id) {
    return _dao.setValue(_activeCarKey, id.toString());
  }

  /// Был ли уже показан экран первого запуска.
  Future<bool> isFirstLaunchDone() async {
    return await _dao.getValue(_firstLaunchDoneKey) != null;
  }

  Future<void> markFirstLaunchDone() => _dao.setValue(_firstLaunchDoneKey, '1');

  /// Настройки приложения; неизвестные значения заменяются значениями
  /// по умолчанию.
  Stream<AppSettings> watchAppSettings() {
    return _dao.watchAll().map((values) {
      T pick<T extends Enum>(List<T> all, String key, T fallback) =>
          all.asNameMap()[values[key]] ?? fallback;
      return AppSettings(
        currency: pick(Currency.values, _currencyKey, Currency.rub),
        consumptionUnit: pick(
          ConsumptionUnit.values,
          _consumptionUnitKey,
          ConsumptionUnit.litersPer100Km,
        ),
        themeMode: pick(ThemeMode.values, _themeModeKey, ThemeMode.system),
        analyticsEnabled: values[_analyticsKey] != 'false',
      );
    });
  }

  Future<void> setCurrency(Currency value) =>
      _dao.setValue(_currencyKey, value.name);

  Future<void> setConsumptionUnit(ConsumptionUnit value) =>
      _dao.setValue(_consumptionUnitKey, value.name);

  Future<void> setThemeMode(ThemeMode value) =>
      _dao.setValue(_themeModeKey, value.name);

  Future<void> setAnalyticsEnabled(bool value) =>
      _dao.setValue(_analyticsKey, '$value');
}
