import 'package:drift/drift.dart';

import '../models/expense_category.dart';
import 'cars_table.dart';

@DataClassName('ExpenseRecord')
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// При удалении автомобиля его расходы удаляются.
  IntColumn get carId =>
      integer().references(Cars, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();
  TextColumn get category => textEnum<ExpenseCategory>()();
  RealColumn get amount => real()();

  /// Пробег на момент расхода, км (необязательно).
  IntColumn get mileage => integer().nullable()();
  TextColumn get comment => text().nullable()();
}
