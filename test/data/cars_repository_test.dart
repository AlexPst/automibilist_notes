import 'dart:io';

import 'package:cardiary/data/models/car_draft.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/storage/car_photo_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late CarsRepository repository;
  late CarPhotoStorage photos;

  setUp(() {
    final db = createTestDatabase();
    photos = createTestPhotoStorage();
    repository = CarsRepository(db.carsDao, photos);
  });

  /// Временный файл, имитирующий снимок из галереи.
  String fakePickedPhoto() {
    final dir = Directory.systemTemp.createTempSync('picked_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final file = File('${dir.path}/photo.jpg')..writeAsBytesSync([1, 2, 3]);
    return file.path;
  }

  CarDraft draft({String brand = 'Lada', String? photoPath}) => CarDraft(
    brand: brand,
    model: 'Vesta',
    fuelType: FuelType.ai95,
    initialMileage: 15000,
    year: 2019,
    plateNumber: 'А 123 ВС 77',
    tankVolume: 55,
    photoPath: photoPath,
  );

  test('добавленный автомобиль появляется в списке со всеми полями', () async {
    final id = await repository.add(draft());

    final cars = await repository.watchAll().first;
    expect(cars, hasLength(1));
    final car = cars.single;
    expect(car.id, id);
    expect(car.brand, 'Lada');
    expect(car.model, 'Vesta');
    expect(car.fuelType, FuelType.ai95);
    expect(car.initialMileage, 15000);
    expect(car.year, 2019);
    expect(car.plateNumber, 'А 123 ВС 77');
    expect(car.tankVolume, 55);
    expect(car.photoPath, isNull);
  });

  test('список отсортирован по порядку добавления', () async {
    await repository.add(draft(brand: 'Lada'));
    await repository.add(draft(brand: 'Kia'));

    final cars = await repository.watchAll().first;
    expect(cars.map((c) => c.brand), ['Lada', 'Kia']);
  });

  test('изменение сохраняется', () async {
    final id = await repository.add(draft());

    await repository.update(
      id,
      const CarDraft(
        brand: 'Kia',
        model: 'Rio',
        fuelType: FuelType.ai92,
        initialMileage: 100,
      ),
    );

    final car = (await repository.watchAll().first).single;
    expect(car.brand, 'Kia');
    expect(car.model, 'Rio');
    expect(car.fuelType, FuelType.ai92);
    expect(car.year, isNull);
    expect(car.plateNumber, isNull);
    expect(car.tankVolume, isNull);
  });

  test('удаление убирает автомобиль из списка', () async {
    final id1 = await repository.add(draft(brand: 'Lada'));
    await repository.add(draft(brand: 'Kia'));

    await repository.delete(id1);

    final cars = await repository.watchAll().first;
    expect(cars.map((c) => c.brand), ['Kia']);
  });

  group('фото', () {
    test('копируется в папку приложения', () async {
      final picked = fakePickedPhoto();
      await repository.add(draft(photoPath: picked));

      final car = (await repository.watchAll().first).single;
      expect(car.photoPath, isNot(picked));
      expect(car.photoPath, startsWith(photos.directory.path));
      expect(File(car.photoPath!).readAsBytesSync(), [1, 2, 3]);
    });

    test('сохраняется без изменений, если фото не меняли', () async {
      final id = await repository.add(draft(photoPath: fakePickedPhoto()));
      final before = (await repository.watchAll().first).single.photoPath;

      await repository.update(id, draft(brand: 'Kia', photoPath: before));

      final after = (await repository.watchAll().first).single.photoPath;
      expect(after, before);
      expect(File(after!).existsSync(), isTrue);
    });

    test('при замене старый файл удаляется', () async {
      final id = await repository.add(draft(photoPath: fakePickedPhoto()));
      final old = (await repository.watchAll().first).single.photoPath!;

      await repository.update(id, draft(photoPath: fakePickedPhoto()));

      final current = (await repository.watchAll().first).single.photoPath!;
      expect(current, isNot(old));
      expect(File(old).existsSync(), isFalse);
      expect(File(current).existsSync(), isTrue);
    });

    test('при удалении фото файл удаляется', () async {
      final id = await repository.add(draft(photoPath: fakePickedPhoto()));
      final old = (await repository.watchAll().first).single.photoPath!;

      await repository.update(id, draft());

      expect((await repository.watchAll().first).single.photoPath, isNull);
      expect(File(old).existsSync(), isFalse);
    });

    test('при удалении автомобиля файл удаляется', () async {
      final id = await repository.add(draft(photoPath: fakePickedPhoto()));
      final old = (await repository.watchAll().first).single.photoPath!;

      await repository.delete(id);

      expect(File(old).existsSync(), isFalse);
    });
  });
}
