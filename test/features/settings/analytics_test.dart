import 'package:cardiary/core/analytics/analytics.dart';
import 'package:cardiary/data/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_analytics.dart';
import '../../helpers/test_app.dart';
import '../../helpers/test_database.dart';

void main() {
  Future<void> openSettings(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Настройки'));
    await tester.pumpAndSettle();
  }

  test('согласие на статистику: по умолчанию да, сохраняется', () async {
    final settings = SettingsRepository(createTestDatabase().settingsDao);
    expect((await settings.watchAppSettings().first).analyticsEnabled, isTrue);

    await settings.setAnalyticsEnabled(false);
    expect((await settings.watchAppSettings().first).analyticsEnabled, isFalse);
  });

  testWidgets('без ключа AppMetrica переключателя нет', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openSettings(tester);

    expect(find.text('Анонимная статистика'), findsNothing);
  });

  testWidgets('переключатель отключает отправку и запоминает выбор', (
    tester,
  ) async {
    final analytics = FakeAnalytics();
    final db = await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      analytics: analytics,
    );
    await openSettings(tester);

    final toggle = find.byKey(const Key('settings_analytics'));
    expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
    await tester.tap(toggle);
    await tester.pump();
    await tester.pumpAndSettle();

    expect(analytics.enabled, isFalse);
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
    // Прямой запрос: потоки drift в тестах виджетов сами не продвигаются.
    expect(await db.settingsDao.getValue('analytics_enabled'), 'false');
  });

  testWidgets('событие при добавлении первого автомобиля', (tester) async {
    final analytics = FakeAnalytics();
    await pumpTestApp(tester, analytics: analytics);

    await tester.tap(find.text('Добавить автомобиль'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('car_brand')), 'Lada');
    await tester.enterText(find.byKey(const Key('car_model')), 'Vesta');
    await tester.enterText(find.byKey(const Key('car_mileage')), '1000');
    final save = find.byKey(const Key('car_save'));
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    // Только факт действия — без марки, модели и пробега.
    expect(analytics.events, [AnalyticsEvent.carAdded]);
  });
}
