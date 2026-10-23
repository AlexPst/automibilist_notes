import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../tables/settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.attachedDatabase);

  Stream<String?> watchValue(String key) {
    return (select(
      settings,
    )..where((s) => s.key.equals(key))).map((s) => s.value).watchSingleOrNull();
  }

  /// Все настройки как «ключ → значение».
  Stream<Map<String, String>> watchAll() {
    return select(settings)
        .watch()
        .map((rows) => {for (final r in rows) r.key: r.value});
  }

  Future<String?> getValue(String key) {
    return (select(
      settings,
    )..where((s) => s.key.equals(key))).map((s) => s.value).getSingleOrNull();
  }

  Future<void> setValue(String key, String value) {
    return into(
      settings,
    ).insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));
  }
}
