import 'package:drift/drift.dart';

/// Настройки приложения в виде пар «ключ — значение».
@DataClassName('SettingEntry')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
