import '../../../data/models/fuel_entry.dart';

/// Отрезок «от полного бака до полного».
class ConsumptionSegment {
  const ConsumptionSegment({
    required this.entry,
    required this.liters,
    required this.distance,
  });

  /// Заправка с полным баком, которая закрывает отрезок.
  final FuelEntry entry;
  final double liters;
  final int distance;

  /// Расход на отрезке, л/100 км.
  double get consumption => liters / distance * 100;
}

/// Результат расчёта расхода топлива.
class FuelConsumption {
  const FuelConsumption({
    required this.byEntryId,
    required this.average,
    this.segments = const [],
  });

  /// Расход, л/100 км, для заправок с полным баком, которые закрывают
  /// отрезок «от полного до полного». У остальных заправок расхода нет.
  final Map<int, double> byEntryId;

  /// Средний расход по всем закрытым отрезкам или `null`, если таких нет.
  final double? average;

  /// Закрытые отрезки по порядку — для графиков и расчёта за период.
  final List<ConsumptionSegment> segments;

  static const empty = FuelConsumption(byEntryId: {}, average: null);
}

/// Порядок заправок по времени: дата, затем пробег, затем порядок ввода.
int compareFuelEntries(FuelEntry a, FuelEntry b) {
  final byDate = a.date.compareTo(b.date);
  if (byDate != 0) return byDate;
  final byMileage = a.mileage.compareTo(b.mileage);
  if (byMileage != 0) return byMileage;
  return a.id.compareTo(b.id);
}

/// Расход методом «от полного бака до полного».
///
/// Между двумя заправками до полного бака сгорело ровно столько топлива,
/// сколько залито после первой из них (включая неполные заправки
/// и саму вторую). Делим на пройденный путь — получаем расход отрезка.
/// Заправки до первого полного бака в расчёт не попадают: неизвестно,
/// сколько было в баке.
FuelConsumption calculateConsumption(List<FuelEntry> entries) {
  final sorted = [...entries]..sort(compareFuelEntries);

  final segments = <ConsumptionSegment>[];

  FuelEntry? lastFull;
  var litersSinceFull = 0.0;

  for (final entry in sorted) {
    if (lastFull == null) {
      if (entry.isFullTank) lastFull = entry;
      continue;
    }

    litersSinceFull += entry.liters;
    if (!entry.isFullTank) continue;

    final distance = entry.mileage - lastFull.mileage;
    if (distance > 0) {
      segments.add(
        ConsumptionSegment(
          entry: entry,
          liters: litersSinceFull,
          distance: distance,
        ),
      );
    }
    lastFull = entry;
    litersSinceFull = 0;
  }

  return FuelConsumption(
    byEntryId: {for (final s in segments) s.entry.id: s.consumption},
    average: averageConsumption(segments),
    segments: segments,
  );
}

/// Средний расход: всё топливо на весь путь, а не среднее отрезков.
double? averageConsumption(Iterable<ConsumptionSegment> segments) {
  var liters = 0.0;
  var distance = 0;
  for (final s in segments) {
    liters += s.liters;
    distance += s.distance;
  }
  return distance > 0 ? liters / distance * 100 : null;
}
