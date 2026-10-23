/// Пути экранов приложения.
abstract final class AppRoutes {
  static const home = '/';
  static const fuel = '/fuel';
  static const expenses = '/expenses';
  static const service = '/service';
  static const stats = '/stats';

  static const onboarding = '/onboarding';
  static const onboardingNewCar = '/onboarding/new';
  static const cars = '/cars';
  static const settings = '/settings';
  static const carNew = '/cars/new';
  static String carEdit(int id) => '/cars/$id/edit';
  static const fuelNew = '/fuel/new';
  static String fuelEdit(int id) => '/fuel/$id/edit';
  static const expenseNew = '/expenses/new';
  static String expenseEdit(int id) => '/expenses/$id/edit';

  /// [template] — имя значения `ReminderTemplate`.
  static String reminderNew([String? template]) =>
      '/service/reminders/new${template == null ? '' : '?template=$template'}';
  static String reminderEdit(int id) => '/service/reminders/$id/edit';

  /// [reminderId] — напоминание, которое продлит запись.
  static String serviceRecordNew([int? reminderId]) =>
      '/service/records/new${reminderId == null ? '' : '?reminderId=$reminderId'}';
  static String serviceRecordEdit(int id) => '/service/records/$id/edit';
}
