import 'expense_category.dart';

/// Данные расхода из формы — для создания или изменения записи.
class ExpenseDraft {
  const ExpenseDraft({
    required this.carId,
    required this.date,
    required this.category,
    required this.amount,
    this.mileage,
    this.comment,
  });

  final int carId;
  final DateTime date;
  final ExpenseCategory category;
  final double amount;
  final int? mileage;
  final String? comment;
}
