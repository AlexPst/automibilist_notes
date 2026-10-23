import 'package:drift/drift.dart';

import '../models/fuel_type.dart';

@DataClassName('CarRecord')
class Cars extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brand => text()();
  TextColumn get model => text()();
  IntColumn get year => integer().nullable()();
  TextColumn get plateNumber => text().nullable()();
  TextColumn get fuelType => textEnum<FuelType>()();

  /// Объём бака, л.
  RealColumn get tankVolume => real().nullable()();

  /// Начальный пробег, км.
  IntColumn get initialMileage => integer()();

  /// Имя файла фото в папке фотографий приложения.
  TextColumn get photoFileName => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
