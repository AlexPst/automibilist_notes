import 'package:drift/drift.dart';

import '../daos/cars_dao.dart';
import '../database/app_database.dart';
import '../models/car.dart';
import '../models/car_draft.dart';
import '../storage/car_photo_storage.dart';

class CarsRepository {
  CarsRepository(this._dao, this._photos);

  final CarsDao _dao;
  final CarPhotoStorage _photos;

  Stream<List<Car>> watchAll() {
    return _dao.watchAll().map((rows) => rows.map(_toCar).toList());
  }

  /// Добавляет автомобиль и возвращает его id.
  Future<int> add(CarDraft draft) async {
    final photo = draft.photoPath == null
        ? null
        : await _photos.import(draft.photoPath!);
    return _dao.insertCar(_toCompanion(draft, photo));
  }

  Future<void> update(int id, CarDraft draft) async {
    final old = await _dao.getById(id);
    if (old == null) return;

    // Фото меняется, только если пользователь выбрал другое или удалил его.
    var photo = old.photoFileName;
    if (draft.photoPath != _photoPath(old.photoFileName)) {
      photo = draft.photoPath == null
          ? null
          : await _photos.import(draft.photoPath!);
    }

    await _dao.updateCar(id, _toCompanion(draft, photo));

    if (old.photoFileName != null && old.photoFileName != photo) {
      await _photos.delete(old.photoFileName!);
    }
  }

  Future<void> delete(int id) async {
    final old = await _dao.getById(id);
    if (old == null) return;
    await _dao.deleteCar(id);
    if (old.photoFileName != null) await _photos.delete(old.photoFileName!);
  }

  String? _photoPath(String? fileName) {
    return fileName == null ? null : _photos.resolve(fileName).path;
  }

  Car _toCar(CarRecord row) {
    return Car(
      id: row.id,
      brand: row.brand,
      model: row.model,
      year: row.year,
      plateNumber: row.plateNumber,
      fuelType: row.fuelType,
      tankVolume: row.tankVolume,
      initialMileage: row.initialMileage,
      photoPath: _photoPath(row.photoFileName),
    );
  }

  CarsCompanion _toCompanion(CarDraft draft, String? photoFileName) {
    return CarsCompanion(
      brand: Value(draft.brand),
      model: Value(draft.model),
      year: Value(draft.year),
      plateNumber: Value(draft.plateNumber),
      fuelType: Value(draft.fuelType),
      tankVolume: Value(draft.tankVolume),
      initialMileage: Value(draft.initialMileage),
      photoFileName: Value(photoFileName),
    );
  }
}
