import 'expense_category.dart';

/// Расход на автомобиль (кроме топлива).
class Expense {
  const Expense({
    required this.id,
    required this.carId,
    required this.date,
    required this.category,
    required this.amount,
    this.mileage,
    this.comment,
  });

  final int id;
  final int carId;

  /// День расхода (без времени).
  final DateTime date;
  final ExpenseCategory category;
  final double amount;

  /// Пробег на момент расхода, км.
  final int? mileage;
  final String? comment;
}
