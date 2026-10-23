import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Локальные уведомления. Интерфейс отделён от плагина, чтобы
/// в тестах подменять его.
abstract interface class NotificationService {
  /// Запрашивает разрешение на уведомления (Android 13+).
  Future<bool> requestPermission();

  Future<void> show({
    required int id,
    required String title,
    required String body,
  });

  Future<void> scheduleAt({
    required int id,
    required DateTime time,
    required String title,
    required String body,
  });

  /// Убирает все запланированные (ещё не показанные) уведомления.
  Future<void> cancelAllScheduled();
}

class LocalNotificationService implements NotificationService {
  LocalNotificationService({
    required this.channelName,
    required this.channelDescription,
  });

  final String channelName;
  final String channelDescription;

  final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'reminders';

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  /// Вызывается один раз при запуске приложения.
  Future<void> init() async {
    tz_data.initializeTimeZones();
    final zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zone.identifier));

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_notification'),
      ),
    );
  }

  NotificationDetails get _details => NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  @override
  Future<bool> requestPermission() async {
    return await _android?.requestNotificationsPermission() ?? true;
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) {
    return _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _details,
    );
  }

  @override
  Future<void> scheduleAt({
    required int id,
    required DateTime time,
    required String title,
    required String body,
  }) async {
    // Точное время — если система разрешает, иначе Android может
    // сдвинуть уведомление на несколько минут.
    final exact = await _android?.canScheduleExactNotifications() ?? false;
    await _plugin.zonedSchedule(
      id: id,
      scheduledDate: tz.TZDateTime.from(time, tz.local),
      notificationDetails: _details,
      androidScheduleMode: exact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle,
      title: title,
      body: body,
    );
  }

  @override
  Future<void> cancelAllScheduled() => _plugin.cancelAllPendingNotifications();
}
