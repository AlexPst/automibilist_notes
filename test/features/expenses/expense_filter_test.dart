import 'package:cardiary/data/models/expense.dart';
import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/features/expenses/domain/expense_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 10, 22, 15, 30);
  var nextId = 0;

  Expense expense(DateTime date, ExpenseCategory category, double amount) =>
      Expense(
        id: ++nextId,
        carId: 1,
        date: date,
        category: category,
        amount: amount,
      );

  final wash = expense(DateTime(2026, 10, 1), ExpenseCategory.wash, 500);
  final repair = expense(DateTime(2026, 10, 31), ExpenseCategory.repair, 8000);
  final septemberParking = expense(
    DateTime(2026, 9, 30),
    ExpenseCategory.parking,
    200,
  );
  final januaryTax = expense(DateTime(2026, 1, 1), ExpenseCategory.tax, 3000);
  final lastYearFine = expense(
    DateTime(2025, 12, 31),
    ExpenseCategory.fines,
    1500,
  );
  final all = [wash, repair, septemberParking, januaryTax, lastYearFine];

  List<int> ids(List<Expense> list) => list.map((e) => e.id).toList();

  test('без фильтра — все расходы', () {
    const filter = ExpenseFilter();
    expect(filter.isActive, isFalse);
    expect(filter.apply(all, now), all);
  });

  group('категории', () {
    test('одна категория', () {
      const filter = ExpenseFilter(categories: {ExpenseCategory.wash});
      expect(ids(filter.apply(all, now)), [wash.id]);
    });

    test('несколько категорий', () {
      const filter = ExpenseFilter(
        categories: {ExpenseCategory.wash, ExpenseCategory.tax},
      );
      expect(ids(filter.apply(all, now)), [wash.id, januaryTax.id]);
    });
  });

  group('период', () {
    test('этот месяц: с 1-го по последний день включительно', () {
      const filter = ExpenseFilter(period: ThisMonth());
      expect(ids(filter.apply(all, now)), [wash.id, repair.id]);
    });

    test('этот год: с 1 января, без прошлого года', () {
      const filter = ExpenseFilter(period: ThisYear());
      expect(ids(filter.apply(all, now)), [
        wash.id,
        repair.id,
        septemberParking.id,
        januaryTax.id,
      ]);
    });

    test('месяц в декабре переходит через год', () {
      final range = const ThisMonth().range(DateTime(2026, 12, 15));
      expect(range.start, DateTime(2026, 12));
      expect(range.end, DateTime(2027));
    });

    test('произвольный период включает оба крайних дня', () {
      final filter = ExpenseFilter(
        period: CustomPeriod(
          from: DateTime(2026, 9, 30),
          to: DateTime(2026, 10, 1),
        ),
      );
      expect(ids(filter.apply(all, now)), [wash.id, septemberParking.id]);
    });

    test('период из одного дня', () {
      final filter = ExpenseFilter(
        period: CustomPeriod(
          from: DateTime(2025, 12, 31),
          to: DateTime(2025, 12, 31),
        ),
      );
      expect(ids(filter.apply(all, now)), [lastYearFine.id]);
    });
  });

  test('категория и период вместе', () {
    const filter = ExpenseFilter(
      categories: {ExpenseCategory.wash, ExpenseCategory.fines},
      period: ThisYear(),
    );
    expect(filter.isActive, isTrue);
    expect(ids(filter.apply(all, now)), [wash.id]);
  });

  test('сумма расходов', () {
    expect(totalAmount(all), 13200);
    expect(totalAmount(const []), 0);
  });
}
