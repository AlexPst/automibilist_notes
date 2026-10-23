import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/data/models/expense_draft.dart';
import 'package:cardiary/data/repositories/cars_repository.dart';
import 'package:cardiary/data/repositories/expenses_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_database.dart';

void main() {
  late ExpensesRepository expenses;
  late CarsRepository cars;
  late int carId;

  setUp(() async {
    final db = createTestDatabase();
    expenses = ExpensesRepository(db.expensesDao);
    cars = CarsRepository(db.carsDao, createTestPhotoStorage());
    carId = await cars.add(testCarDraft());
  });

  ExpenseDraft draft(int day, {int? car, int? mileage}) => ExpenseDraft(
    carId: car ?? carId,
    date: DateTime(2026, 10, day, 9, 15),
    category: ExpenseCategory.insurance,
    amount: 12500.5,
    mileage: mileage,
    comment: 'ОСАГО',
  );

  test('добавленный расход сохраняется со всеми полями', () async {
    final id = await expenses.add(draft(5, mileage: 16000));

    final e = (await expenses.getById(id))!;
    expect(e.carId, carId);
    expect(e.date, DateTime(2026, 10, 5));
    expect(e.category, ExpenseCategory.insurance);
    expect(e.amount, 12500.5);
    expect(e.mileage, 16000);
    expect(e.comment, 'ОСАГО');
  });

  test('пробег необязателен', () async {
    final id = await expenses.add(draft(5));
    expect((await expenses.getById(id))!.mileage, isNull);
  });

  test('список — только расходы этого авто, новые сверху', () async {
    final other = await cars.add(testCarDraft(brand: 'Kia'));
    await expenses.add(draft(1));
    await expenses.add(draft(9));
    await expenses.add(draft(5));
    await expenses.add(draft(7, car: other));

    final list = await expenses.watchForCar(carId).first;
    expect(list.map((e) => e.date.day), [9, 5, 1]);
  });

  test('изменение и удаление', () async {
    final id = await expenses.add(draft(1));

    await expenses.update(
      id,
      ExpenseDraft(
        carId: carId,
        date: DateTime(2026, 10, 2),
        category: ExpenseCategory.wash,
        amount: 600,
      ),
    );
    final updated = (await expenses.getById(id))!;
    expect(updated.category, ExpenseCategory.wash);
    expect(updated.amount, 600);
    expect(updated.comment, isNull);

    await expenses.delete(id);
    expect(await expenses.getById(id), isNull);
  });

  test('при удалении авто удаляются и его расходы', () async {
    final id = await expenses.add(draft(1));
    await cars.delete(carId);
    expect(await expenses.getById(id), isNull);
  });
}
