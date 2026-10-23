import 'package:drift/drift.dart';

import 'cars_table.dart';

@DataClassName('FuelEntryRecord')
class FuelEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// При удалении автомобиля его заправки удаляются.
  IntColumn get carId =>
      integer().references(Cars, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();

  /// Показание одометра, км.
  IntColumn get mileage => integer()();
  RealColumn get liters => real()();
  RealColumn get pricePerLiter => real()();
  RealColumn get totalCost => real()();
  BoolColumn get isFullTank => boolean()();
  TextColumn get station => text().nullable()();
  TextColumn get comment => text().nullable()();
}
