// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_dao.dart';

// ignore_for_file: type=lint
mixin _$FuelDaoMixin on DatabaseAccessor<AppDatabase> {
  $CarsTable get cars => attachedDatabase.cars;
  $FuelEntriesTable get fuelEntries => attachedDatabase.fuelEntries;
  FuelDaoManager get managers => FuelDaoManager(this);
}

class FuelDaoManager {
  final _$FuelDaoMixin _db;
  FuelDaoManager(this._db);
  $$CarsTableTableManager get cars =>
      $$CarsTableTableManager(_db.attachedDatabase, _db.cars);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db.attachedDatabase, _db.fuelEntries);
}
