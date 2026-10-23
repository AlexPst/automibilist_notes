import 'package:drift/drift.dart';

import 'cars_table.dart';

/// Напоминание о периодической работе: «масло каждые 10 000 км или 12 мес».
@DataClassName('ReminderRecord')
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// При удалении автомобиля его напоминания удаляются.
  IntColumn get carId =>
      integer().references(Cars, #id, onDelete: KeyAction.cascade)();

  /// Вид работ.
  TextColumn get title => text()();

  /// Интервал по пробегу, км (может не быть).
  IntColumn get intervalKm => integer().nullable()();

  /// Интервал по времени, месяцы (может не быть).
  IntColumn get intervalMonths => integer().nullable()();

  /// Когда работу делали последний раз — от этого считается следующий срок.
  DateTimeColumn get lastDoneDate => dateTime()();
  IntColumn get lastDoneMileage => integer().nullable()();

  /// За сколько дней до срока предупредить.
  IntColumn get advanceDays => integer().withDefault(const Constant(7))();

  /// За сколько км до срока предупредить.
  IntColumn get advanceKm => integer().withDefault(const Constant(500))();

  /// Срок по пробегу, о котором уже сообщили (чтобы не повторяться).
  IntColumn get notifiedDueMileage => integer().nullable()();
}
