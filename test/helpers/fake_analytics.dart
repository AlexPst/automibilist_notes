import 'package:cardiary/core/analytics/analytics.dart';

/// Запоминает события вместо отправки.
class FakeAnalytics implements Analytics {
  final events = <AnalyticsEvent>[];
  bool? enabled;

  @override
  bool get isAvailable => true;

  @override
  Future<void> log(AnalyticsEvent event) async => events.add(event);

  @override
  Future<void> setEnabled(bool value) async => enabled = value;
}
