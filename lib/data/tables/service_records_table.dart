import 'package:drift/drift.dart';

import 'cars_table.dart';
import 'reminders_table.dart';

/// Запись о выполненном ТО или ремонте.
@DataClassName('ServiceRecordRow')
class ServiceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// При удалении автомобиля его записи ТО удаляются.
  IntColumn get carId =>
      integer().references(Cars, #id, onDelete: KeyAction.cascade)();

  /// Напоминание, которое продлила эта запись; при удалении
  /// напоминания запись остаётся.
  IntColumn get reminderId => integer().nullable().references(
    Reminders,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Вид работ.
  TextColumn get title => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get mileage => integer()();
  RealColumn get cost => real().nullable()();

  /// СТО.
  TextColumn get station => text().nullable()();
  TextColumn get comment => text().nullable()();
}
