import 'dart:math';

/// Запись с показанием одометра.
typedef MileageMark = ({DateTime date, int mileage});

/// Пробег за период `[start, end)`: от наибольшего показания до начала
/// периода (или начального пробега) до наибольшего показания в нём.
int distanceInPeriod({
  required int initialMileage,
  required Iterable<MileageMark> marks,
  required DateTime? start,
  required DateTime end,
}) {
  var before = initialMileage;
  var until = initialMileage;
  for (final m in marks) {
    if (!m.date.isBefore(end)) continue;
    until = max(until, m.mileage);
    if (start != null && m.date.isBefore(start)) {
      before = max(before, m.mileage);
    }
  }
  return max(0, until - before);
}

/// Стоимость 1 км или `null`, если за период не ездили.
double? costPerKm(double total, int distance) =>
    distance > 0 ? total / distance : null;
