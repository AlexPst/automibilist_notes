import '../../../data/models/fuel_entry.dart';

enum MileageProblem {
  /// Меньше начального пробега автомобиля.
  belowInitial,

  /// Меньше, чем в записи с более ранней датой.
  belowPrevious,

  /// Больше, чем в записи с более поздней датой.
  aboveNext,
}

/// Допустимый диапазон пробега для записи на дату [date].
///
/// Записи за тот же день не ограничивают друг друга: их порядок
/// определяется самим пробегом.
class MileageBounds {
  const MileageBounds({
    required this.min,
    required this.minIsInitial,
    required this.max,
  });

  factory MileageBounds.forDate({
    required List<FuelEntry> entries,
    required DateTime date,
    required int initialMileage,
    int? excludeId,
  }) {
    final day = _dayOf(date);
    var min = initialMileage;
    var minIsInitial = true;
    int? max;

    for (final entry in entries) {
      if (entry.id == excludeId) continue;
      final entryDay = _dayOf(entry.date);
      if (entryDay.isBefore(day) && entry.mileage >= min) {
        min = entry.mileage;
        minIsInitial = false;
      } else if (entryDay.isAfter(day) &&
          (max == null || entry.mileage < max)) {
        max = entry.mileage;
      }
    }
    return MileageBounds(min: min, minIsInitial: minIsInitial, max: max);
  }

  final int min;

  /// Нижняя граница — начальный пробег авто, а не другая запись.
  final bool minIsInitial;
  final int? max;

  MileageProblem? check(int mileage) {
    if (mileage < min) {
      return minIsInitial
          ? MileageProblem.belowInitial
          : MileageProblem.belowPrevious;
    }
    if (max != null && mileage > max!) return MileageProblem.aboveNext;
    return null;
  }

  static DateTime _dayOf(DateTime d) => DateTime(d.year, d.month, d.day);
}
