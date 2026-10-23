import 'package:drift/drift.dart';

import '../daos/expenses_dao.dart';
import '../database/app_database.dart';
import '../models/expense.dart';
import '../models/expense_draft.dart';

class ExpensesRepository {
  ExpensesRepository(this._dao);

  final ExpensesDao _dao;

  /// Расходы автомобиля, новые сверху.
  Stream<List<Expense>> watchForCar(int carId) {
    return _dao.watchForCar(carId).map((rows) => rows.map(_toExpense).toList());
  }

  Future<Expense?> getById(int id) async {
    final row = await _dao.getById(id);
    return row == null ? null : _toExpense(row);
  }

  Future<int> add(ExpenseDraft draft) =>
      _dao.insertExpense(_toCompanion(draft));

  Future<void> update(int id, ExpenseDraft draft) =>
      _dao.updateExpense(id, _toCompanion(draft));

  Future<void> delete(int id) => _dao.deleteExpense(id);

  Expense _toExpense(ExpenseRecord row) {
    return Expense(
      id: row.id,
      carId: row.carId,
      date: row.date,
      category: row.category,
      amount: row.amount,
      mileage: row.mileage,
      comment: row.comment,
    );
  }

  ExpensesCompanion _toCompanion(ExpenseDraft draft) {
    return ExpensesCompanion(
      carId: Value(draft.carId),
      // Храним только день.
      date: Value(DateTime(draft.date.year, draft.date.month, draft.date.day)),
      category: Value(draft.category),
      amount: Value(draft.amount),
      mileage: Value(draft.mileage),
      comment: Value(draft.comment),
    );
  }
}
