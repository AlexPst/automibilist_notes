import 'package:cardiary/data/models/reminder_draft.dart';
import 'package:cardiary/features/service/domain/notification_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_notification_service.dart';
import '../../helpers/test_app.dart';

void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  Future<void> openTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapKey(WidgetTester tester, String key) async {
    final finder = find.byKey(Key(key));
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  String fieldText(WidgetTester tester, String key) => tester
      .widget<TextField>(
        find.descendant(
          of: find.byKey(Key(key)),
          matching: find.byType(TextField),
        ),
      )
      .controller!
      .text;

  /// Текст без неразрывных пробелов — для сравнения чисел и дат.
  bool hasText(String text) => find
      .byWidgetPredicate(
        (w) =>
            w is Text && (w.data ?? '').replaceAll(RegExp('[  ]'), ' ') == text,
      )
      .evaluate()
      .isNotEmpty;

  ReminderDraft oil({int lastMileage = 12000}) => ReminderDraft(
    carId: 1,
    title: 'Замена масла',
    intervalKm: 10000,
    lastDoneDate: today,
    lastDoneMileage: lastMileage,
  );

  testWidgets('напоминание из шаблона', (tester) async {
    final notifications = FakeNotificationService();
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      notifications: notifications,
    );
    await openTab(tester, 'ТО');
    expect(find.text('Нет напоминаний'), findsOneWidget);

    await tester.tap(find.byTooltip('Добавить напоминание'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Замена масла'));
    await tester.pumpAndSettle();

    // Шаблон заполнил форму, пробег — текущий.
    expect(fieldText(tester, 'reminder_title'), 'Замена масла');
    expect(fieldText(tester, 'reminder_interval_km'), '10000');
    expect(fieldText(tester, 'reminder_interval_months'), '12');
    expect(fieldText(tester, 'reminder_last_mileage'), '12000');
    await tapKey(tester, 'reminder_save');

    expect(find.text('Замена масла'), findsOneWidget);
    expect(hasText('22 000 км · через 10 000 км'), isTrue);
    expect(notifications.permissionRequests, 1);
    // По дате: заранее и в день срока.
    expect(notifications.scheduled.keys, [
      advanceNotificationId(1),
      dueDayNotificationId(1),
    ]);
  });

  testWidgets('без интервала напоминание не сохраняется', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openTab(tester, 'ТО');
    await tester.tap(find.byTooltip('Добавить напоминание'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Своё напоминание'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('reminder_title')), 'Ремень');
    await tapKey(tester, 'reminder_save');

    expect(find.text('Укажите интервал в км или месяцах'), findsNWidgets(2));
    expect(find.text('Новое напоминание'), findsOneWidget);
  });

  testWidgets('«Выполнено» создаёт запись ТО и продлевает напоминание', (
    tester,
  ) async {
    await pumpTestApp(tester, cars: [testCarDraft()], reminders: [oil()]);
    await openTab(tester, 'ТО');

    await tester.tap(find.text('Выполнено'));
    await tester.pumpAndSettle();
    expect(fieldText(tester, 'record_title'), 'Замена масла');
    expect(
      find.text('Следующий срок напоминания посчитается от этой записи'),
      findsOneWidget,
    );
    await tester.enterText(find.byKey(const Key('record_mileage')), '21000');
    await tester.enterText(find.byKey(const Key('record_cost')), '4500');
    await tapKey(tester, 'record_save');

    // Новый срок — от пробега записи.
    expect(hasText('31 000 км · через 10 000 км'), isTrue);

    await tester.tap(find.text('История'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ListTile, 'Замена масла'), findsOneWidget);
    expect(hasText('4 500,00 ₽'), isTrue);
  });

  testWidgets('срок по пробегу: уведомление и сообщение после заправки', (
    tester,
  ) async {
    final notifications = FakeNotificationService();
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      reminders: [oil()],
      notifications: notifications,
    );
    expect(notifications.shown, isEmpty);

    // Заправка на 21 600 км: до замены масла 400 км.
    await openTab(tester, 'Заправки');
    await tester.tap(find.byTooltip('Добавить заправку'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('fuel_mileage')), '21600');
    await tester.enterText(find.byKey(const Key('fuel_liters')), '40');
    await tester.enterText(find.byKey(const Key('fuel_price')), '50');
    await tapKey(tester, 'fuel_save');

    expect(notifications.shown, hasLength(1));
    expect(notifications.shown.single.title, 'Скоро: Замена масла');
    expect(find.text('Подходит срок: Замена масла'), findsOneWidget);

    // Сообщение исчезает само.
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
    expect(find.text('Подходит срок: Замена масла'), findsNothing);

    // Вторая заправка — повторного уведомления нет.
    await tester.tap(find.byTooltip('Добавить заправку'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('fuel_mileage')), '21800');
    await tester.enterText(find.byKey(const Key('fuel_liters')), '10');
    await tapKey(tester, 'fuel_save');
    expect(notifications.shown, hasLength(1));
    expect(find.text('Подходит срок: Замена масла'), findsNothing);
  });

  testWidgets('просроченное напоминание выделено', (tester) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      reminders: [
        ReminderDraft(
          carId: 1,
          title: 'ОСАГО',
          intervalMonths: 12,
          lastDoneDate: DateTime(today.year - 1, today.month, today.day - 3),
        ),
      ],
    );
    await openTab(tester, 'ТО');

    expect(find.textContaining('просрочено на 3 дня'), findsOneWidget);
    final card = tester.widget<Card>(find.byKey(const ValueKey('reminder_1')));
    final context = tester.element(find.byKey(const ValueKey('reminder_1')));
    expect(card.color, Theme.of(context).colorScheme.errorContainer);
  });
}
