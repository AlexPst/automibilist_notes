import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/models/fuel_entry_draft.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/repositories/fuel_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late FuelRepository fuel;
  late CarsRepository cars;
  late int carId;

  setUp(() async {
    db = createTestDatabase();
    fuel = FuelRepository(db.fuelDao);
    cars = CarsRepository(db.carsDao, createTestPhotoStorage());
    carId = await cars.add(testCarDraft());
  });

  FuelEntryDraft draft(int day, int mileage, {int? car}) => FuelEntryDraft(
    carId: car ?? carId,
    date: DateTime(2026, 10, day, 18, 45),
    mileage: mileage,
    liters: 40.5,
    pricePerLiter: 56.9,
    totalCost: 2304.45,
    isFullTank: false,
    station: 'Лукойл',
    comment: 'по пути',
  );

  test('добавленная заправка сохраняется со всеми полями', () async {
    final id = await fuel.add(draft(5, 10000));

    final entry = (await fuel.getById(id))!;
    expect(entry.carId, carId);
    // Время отбрасывается — хранится только день.
    expect(entry.date, DateTime(2026, 10, 5));
    expect(entry.mileage, 10000);
    expect(entry.liters, 40.5);
    expect(entry.pricePerLiter, 56.9);
    expect(entry.totalCost, 2304.45);
    expect(entry.isFullTank, isFalse);
    expect(entry.station, 'Лукойл');
    expect(entry.comment, 'по пути');
  });

  test('список — только заправки этого авто, новые сверху', () async {
    final otherCar = await cars.add(testCarDraft(brand: 'Kia'));
    await fuel.add(draft(1, 10000));
    await fuel.add(draft(9, 10900));
    await fuel.add(draft(5, 10500));
    await fuel.add(draft(3, 20000, car: otherCar));

    final list = await fuel.watchForCar(carId).first;
    expect(list.map((e) => e.mileage), [10900, 10500, 10000]);
  });

  test('изменение и удаление', () async {
    final id = await fuel.add(draft(1, 10000));

    await fuel.update(id, draft(2, 10100));
    expect((await fuel.getById(id))!.mileage, 10100);

    await fuel.delete(id);
    expect(await fuel.getById(id), isNull);
  });

  test('при удалении авто удаляются и его заправки', () async {
    final id = await fuel.add(draft(1, 10000));

    await cars.delete(carId);

    expect(await fuel.getById(id), isNull);
  });
}
