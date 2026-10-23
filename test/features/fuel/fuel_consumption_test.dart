import 'package:cardiary/data/models/fuel_entry.dart';
import 'package:cardiary/features/fuel/domain/fuel_consumption.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var nextId = 0;
  setUp(() => nextId = 0);

  FuelEntry fill(
    int day,
    int mileage,
    double liters, {
    bool full = true,
    int? id,
  }) {
    return FuelEntry(
      id: id ?? ++nextId,
      carId: 1,
      date: DateTime(2026, 10, day),
      mileage: mileage,
      liters: liters,
      pricePerLiter: 50,
      totalCost: liters * 50,
      isFullTank: full,
    );
  }

  test('нет заправок — нет расхода', () {
    final r = calculateConsumption(const []);
    expect(r.byEntryId, isEmpty);
    expect(r.average, isNull);
  });

  test('одна заправка — расход ещё не известен', () {
    final r = calculateConsumption([fill(1, 10000, 40)]);
    expect(r.byEntryId, isEmpty);
    expect(r.average, isNull);
  });

  test('два полных бака: литры второй заправки на пройденный путь', () {
    final a = fill(1, 10000, 50);
    final b = fill(5, 10500, 40);

    final r = calculateConsumption([a, b]);

    // 40 л на 500 км = 8 л/100 км; литры первой заправки не учитываются.
    expect(r.byEntryId, {b.id: 8.0});
    expect(r.average, 8.0);
  });

  test('неполные баки между полными суммируются в отрезок', () {
    final a = fill(1, 10000, 50);
    final p1 = fill(3, 10200, 10, full: false);
    final p2 = fill(5, 10400, 15, full: false);
    final b = fill(7, 10600, 20);

    final r = calculateConsumption([a, p1, p2, b]);

    // (10 + 15 + 20) л на 600 км = 7,5 л/100 км.
    expect(r.byEntryId, {b.id: 7.5});
    expect(r.byEntryId.containsKey(p1.id), isFalse);
    expect(r.byEntryId.containsKey(p2.id), isFalse);
    expect(r.average, 7.5);
  });

  test('заправки до первого полного бака не учитываются', () {
    final p0 = fill(1, 9000, 30, full: false);
    final a = fill(2, 9500, 20);
    final b = fill(4, 10000, 35);

    final r = calculateConsumption([p0, a, b]);

    expect(r.byEntryId.keys, [b.id]);
    expect(r.byEntryId[b.id], closeTo(7.0, 1e-9));
  });

  test('неполные баки после последнего полного ждут следующего', () {
    final a = fill(1, 10000, 50);
    final b = fill(3, 10500, 40);
    final p = fill(5, 10800, 15, full: false);

    final r = calculateConsumption([a, b, p]);

    expect(r.byEntryId, {b.id: 8.0});
    expect(r.average, 8.0);
  });

  test('только неполные баки — расхода нет', () {
    final r = calculateConsumption([
      fill(1, 10000, 20, full: false),
      fill(2, 10300, 20, full: false),
    ]);
    expect(r.byEntryId, isEmpty);
    expect(r.average, isNull);
  });

  test('несколько отрезков и средний расход по всему пути', () {
    final a = fill(1, 10000, 50);
    final b = fill(3, 10500, 40); // 8 л/100 км
    final p = fill(5, 10700, 10, full: false);
    final c = fill(7, 11000, 30); // (10 + 30) / 500 = 8 л/100 км
    final d = fill(9, 11200, 20); // 20 / 200 = 10 л/100 км

    final r = calculateConsumption([a, b, p, c, d]);

    expect(r.byEntryId[b.id], 8.0);
    expect(r.byEntryId[c.id], 8.0);
    expect(r.byEntryId[d.id], 10.0);
    // Средний — не среднее арифметическое отрезков, а всё топливо
    // на весь путь: (40 + 40 + 20) / 1200 × 100.
    expect(r.average, closeTo(8.333, 0.001));
  });

  test('порядок во входном списке не важен', () {
    final a = fill(1, 10000, 50);
    final p = fill(3, 10200, 10, full: false);
    final b = fill(5, 10500, 30);

    final r = calculateConsumption([b, a, p]);

    expect(r.byEntryId, {b.id: 8.0});
  });

  test('заправки в один день упорядочиваются по пробегу', () {
    final a = fill(1, 10000, 50);
    final b = fill(1, 10400, 32, id: 100);
    final c = fill(1, 10300, 5, full: false, id: 200);

    final r = calculateConsumption([a, b, c]);

    // c (10 300 км) раньше b (10 400 км): (5 + 32) / 400 × 100.
    expect(r.byEntryId, {b.id: 9.25});
  });

  test('нулевой путь между полными баками не даёт расхода', () {
    final a = fill(1, 10000, 50);
    final b = fill(1, 10000, 2);
    final c = fill(3, 10500, 40);

    final r = calculateConsumption([a, b, c]);

    expect(r.byEntryId.containsKey(b.id), isFalse);
    expect(r.byEntryId[c.id], 8.0);
  });
}
