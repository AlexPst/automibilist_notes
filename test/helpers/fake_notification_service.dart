import 'package:cardiary/core/notifications/notification_service.dart';

/// Запоминает уведомления вместо показа.
class FakeNotificationService implements NotificationService {
  final shown = <({int id, String title, String body})>[];
  final scheduled = <int, ({DateTime time, String title, String body})>{};
  int permissionRequests = 0;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return true;
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {
    shown.add((id: id, title: title, body: body));
  }

  @override
  Future<void> scheduleAt({
    required int id,
    required DateTime time,
    required String title,
    required String body,
  }) async {
    scheduled[id] = (time: time, title: title, body: body);
  }

  @override
  Future<void> cancelAllScheduled() async => scheduled.clear();
}
