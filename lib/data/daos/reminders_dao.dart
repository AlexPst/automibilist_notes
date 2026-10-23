import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../tables/reminders_table.dart';

part 'reminders_dao.g.dart';

@DriftAccessor(tables: [Reminders])
class RemindersDao extends DatabaseAccessor<AppDatabase>
    with _$RemindersDaoMixin {
  RemindersDao(super.attachedDatabase);

  Stream<List<ReminderRecord>> watchForCar(int carId) {
    return (select(reminders)
          ..where((r) => r.carId.equals(carId))
          ..orderBy([(r) => OrderingTerm.asc(r.id)]))
        .watch();
  }

  /// Напоминания всех автомобилей — для расписания уведомлений.
  Stream<List<ReminderRecord>> watchAll() => select(reminders).watch();

  Future<ReminderRecord?> getById(int id) {
    return (select(reminders)..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertReminder(RemindersCompanion reminder) =>
      into(reminders).insert(reminder);

  Future<void> updateReminder(int id, RemindersCompanion reminder) {
    return (update(reminders)..where((r) => r.id.equals(id))).write(reminder);
  }

  Future<void> deleteReminder(int id) {
    return (delete(reminders)..where((r) => r.id.equals(id))).go();
  }
}
