import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../tables/expenses_table.dart';

part 'expenses_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpensesDao extends DatabaseAccessor<AppDatabase>
    with _$ExpensesDaoMixin {
  ExpensesDao(super.attachedDatabase);

  /// Расходы автомобиля, новые сверху.
  Stream<List<ExpenseRecord>> watchForCar(int carId) {
    return (select(expenses)
          ..where((e) => e.carId.equals(carId))
          ..orderBy([
            (e) => OrderingTerm.desc(e.date),
            (e) => OrderingTerm.desc(e.id),
          ]))
        .watch();
  }

  Future<ExpenseRecord?> getById(int id) {
    return (select(expenses)..where((e) => e.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertExpense(ExpensesCompanion expense) =>
      into(expenses).insert(expense);

  Future<void> updateExpense(int id, ExpensesCompanion expense) {
    return (update(expenses)..where((e) => e.id.equals(id))).write(expense);
  }

  Future<void> deleteExpense(int id) {
    return (delete(expenses)..where((e) => e.id.equals(id))).go();
  }
}
