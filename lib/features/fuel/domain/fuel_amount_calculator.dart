/// Поля заправки, связанные формулой «сумма = литры × цена».
enum FuelAmountField { liters, price, total }

/// Пересчитывает третье поле, когда заполнены любые два.
///
/// Пересчитывается поле, которое пользователь трогал давнее остальных:
/// ввели литры и цену — посчиталась сумма; потом исправили сумму —
/// пересчитались литры (цена осталась, как ввели).
class FuelAmountCalculator {
  /// Поля, введённые пользователем, — последнее изменённое первым.
  final List<FuelAmountField> _edited = [];

  /// Отмечает поле как введённое пользователем без пересчёта
  /// (например, цена, подставленная из прошлой заправки).
  void markEdited(FuelAmountField field) {
    _edited
      ..remove(field)
      ..insert(0, field);
    if (_edited.length > 2) _edited.removeLast();
  }

  /// Пользователь изменил [field]. Возвращает поле и значение, которое
  /// нужно подставить, или `null`, если пересчитывать нечего.
  ({FuelAmountField field, double value})? onEdited(
    FuelAmountField field, {
    required double? liters,
    required double? price,
    required double? total,
  }) {
    final values = {
      FuelAmountField.liters: liters,
      FuelAmountField.price: price,
      FuelAmountField.total: total,
    };

    if (values[field] == null) {
      // Поле очистили — оно больше не участвует в расчёте.
      _edited.remove(field);
      return null;
    }
    markEdited(field);

    // Учитываем только поля с корректными значениями.
    final sources = _edited.where((f) => (values[f] ?? 0) > 0).toList();
    if (sources.length < 2) return null;

    final target = FuelAmountField.values.firstWhere(
      (f) => !sources.contains(f),
    );
    final l = values[FuelAmountField.liters];
    final p = values[FuelAmountField.price];
    final t = values[FuelAmountField.total];

    final value = switch (target) {
      FuelAmountField.total => l! * p!,
      FuelAmountField.liters => t! / p!,
      FuelAmountField.price => t! / l!,
    };
    return (field: target, value: roundTo2(value));
  }
}

/// Округление до сотых (копейки, сотые литра).
double roundTo2(double value) => (value * 100).roundToDouble() / 100;
