/// Период статистики.
enum StatsPeriod {
  month,
  year,
  all;

  /// Границы `[start, end)` относительно [now]; у «всего времени» начала нет.
  ({DateTime? start, DateTime end}) range(DateTime now) {
    return switch (this) {
      StatsPeriod.month => (
        start: DateTime(now.year, now.month),
        end: DateTime(now.year, now.month + 1),
      ),
      StatsPeriod.year => (
        start: DateTime(now.year),
        end: DateTime(now.year + 1),
      ),
      StatsPeriod.all => (start: null, end: DateTime(now.year, now.month + 1)),
    };
  }

  bool contains(DateTime date, DateTime now) {
    final r = range(now);
    return (r.start == null || !date.isBefore(r.start!)) &&
        date.isBefore(r.end);
  }
}
