import 'package:cardiary/features/fuel/domain/fuel_amount_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FuelAmountCalculator calc;

  setUp(() => calc = FuelAmountCalculator());

  test('одно поле — пересчитывать нечего', () {
    expect(
      calc.onEdited(
        FuelAmountField.liters,
        liters: 40,
        price: null,
        total: null,
      ),
      isNull,
    );
  });

  test('литры и цена → сумма', () {
    calc.onEdited(FuelAmountField.liters, liters: 40, price: null, total: null);
    final r = calc.onEdited(
      FuelAmountField.price,
      liters: 40,
      price: 56.9,
      total: null,
    );
    expect(r, (field: FuelAmountField.total, value: 2276.0));
  });

  test('сумма и цена → литры', () {
    calc.onEdited(
      FuelAmountField.total,
      liters: null,
      price: null,
      total: 2000,
    );
    final r = calc.onEdited(
      FuelAmountField.price,
      liters: null,
      price: 56.9,
      total: 2000,
    );
    expect(r, (field: FuelAmountField.liters, value: 35.15));
  });

  test('сумма и литры → цена', () {
    calc.onEdited(
      FuelAmountField.total,
      liters: null,
      price: null,
      total: 2000,
    );
    final r = calc.onEdited(
      FuelAmountField.liters,
      liters: 40,
      price: null,
      total: 2000,
    );
    expect(r, (field: FuelAmountField.price, value: 50.0));
  });

  test('пересчитывается поле, которое трогали давнее остальных', () {
    calc.onEdited(FuelAmountField.liters, liters: 40, price: null, total: null);
    calc.onEdited(FuelAmountField.price, liters: 40, price: 50, total: null);
    // Сумма посчиталась (2000), теперь пользователь сам правит сумму:
    // давнее всего трогали литры — их и пересчитываем.
    final r = calc.onEdited(
      FuelAmountField.total,
      liters: 40,
      price: 50,
      total: 2500,
    );
    expect(r, (field: FuelAmountField.liters, value: 50.0));

    // Снова правим цену — давнее всего теперь литры (их считали
    // автоматически), так что пересчитываются они.
    final r2 = calc.onEdited(
      FuelAmountField.price,
      liters: 50,
      price: 62.5,
      total: 2500,
    );
    expect(r2, (field: FuelAmountField.liters, value: 40.0));
  });

  test('подставленная цена считается введённой', () {
    calc.markEdited(FuelAmountField.price);
    final r = calc.onEdited(
      FuelAmountField.liters,
      liters: 30,
      price: 55.55,
      total: null,
    );
    expect(r, (field: FuelAmountField.total, value: 1666.5));
  });

  test('очищенное поле не участвует в расчёте', () {
    calc.onEdited(FuelAmountField.liters, liters: 40, price: null, total: null);
    calc.onEdited(
      FuelAmountField.liters,
      liters: null,
      price: null,
      total: null,
    );
    expect(
      calc.onEdited(
        FuelAmountField.price,
        liters: null,
        price: 50,
        total: null,
      ),
      isNull,
    );
  });

  test('нулевая цена не приводит к делению на ноль', () {
    calc.onEdited(
      FuelAmountField.total,
      liters: null,
      price: null,
      total: 2000,
    );
    expect(
      calc.onEdited(FuelAmountField.price, liters: null, price: 0, total: 2000),
      isNull,
    );
  });

  test('округление до копеек', () {
    expect(roundTo2(33.333333), 33.33);
    expect(roundTo2(2276.005), 2276.01);
  });
}
