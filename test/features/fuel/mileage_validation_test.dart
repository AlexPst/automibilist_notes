import 'package:cardiary/data/models/fuel_entry.dart';
import 'package:cardiary/features/fuel/domain/mileage_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FuelEntry fill(int id, int day, int mileage) => FuelEntry(
    id: id,
    carId: 1,
    date: DateTime(2026, 10, day),
    mileage: mileage,
    liters: 40,
    pricePerLiter: 50,
    totalCost: 2000,
    isFullTank: true,
  );

  final entries = [fill(1, 1, 10000), fill(2, 10, 10500), fill(3, 20, 11000)];

  MileageBounds bounds(int day, {int? excludeId}) => MileageBounds.forDate(
    entries: entries,
    date: DateTime(2026, 10, day),
    initialMileage: 9000,
    excludeId: excludeId,
  );

  test('без заправок нижняя граница — начальный пробег', () {
    final b = MileageBounds.forDate(
      entries: const [],
      date: DateTime(2026, 10, 1),
      initialMileage: 9000,
    );
    expect(b.check(8999), MileageProblem.belowInitial);
    expect(b.check(9000), isNull);
    expect(b.max, isNull);
  });

  test('новая заправка позже всех: не меньше последнего пробега', () {
    final b = bounds(25);
    expect(b.check(10999), MileageProblem.belowPrevious);
    expect(b.check(11000), isNull);
    expect(b.check(99999), isNull);
  });

  test('заправка задним числом: между соседями', () {
    final b = bounds(5);
    expect(b.min, 10000);
    expect(b.max, 10500);
    expect(b.check(9999), MileageProblem.belowPrevious);
    expect(b.check(10501), MileageProblem.aboveNext);
    expect(b.check(10200), isNull);
  });

  test('заправка раньше всех: ограничена сверху и начальным пробегом', () {
    final earlier = MileageBounds.forDate(
      entries: entries,
      date: DateTime(2026, 9, 1),
      initialMileage: 9000,
    );
    expect(earlier.check(8000), MileageProblem.belowInitial);
    expect(earlier.check(10001), MileageProblem.aboveNext);
    expect(earlier.check(9500), isNull);
  });

  test('записи за тот же день не ограничивают друг друга', () {
    final b = bounds(10);
    expect(b.min, 10000);
    expect(b.max, 11000);
    expect(b.check(10400), isNull);
  });

  test('при редактировании сама запись не мешает', () {
    final b = bounds(20, excludeId: 3);
    expect(b.max, isNull);
    expect(b.check(10500), isNull);
  });
}
