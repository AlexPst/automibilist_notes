import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  final today = DateTime.now();

  Future<void> openFuelTab(WidgetTester tester) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Заправки'),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> enter(WidgetTester tester, String key, String text) async {
    final field = find.byKey(Key(key));
    await tester.ensureVisible(field);
    await tester.enterText(field, text);
    await tester.pump();
  }

  String fieldText(WidgetTester tester, String key) {
    final field = tester.widget<TextField>(
      find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(TextField),
      ),
    );
    return field.controller!.text;
  }

  Future<void> save(WidgetTester tester) async {
    final button = find.byKey(const Key('fuel_save'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  testWidgets('пустой список заправок', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openFuelTab(tester);

    expect(find.text('Пока нет заправок'), findsOneWidget);
  });

  testWidgets('добавление двух заправок показывает расход', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openFuelTab(tester);

    // Первая заправка: литры и цена → сумма считается сама.
    await tester.tap(find.byTooltip('Добавить заправку'));
    await tester.pumpAndSettle();
    await enter(tester, 'fuel_mileage', '12500');
    await enter(tester, 'fuel_liters', '40');
    await enter(tester, 'fuel_price', '50');
    expect(fieldText(tester, 'fuel_total'), '2000');
    await save(tester);

    expect(find.text('Пока нет заправок'), findsNothing);
    expect(
      find.text('Появится после двух заправок до полного бака'),
      findsOneWidget,
    );

    // Вторая: цена подставилась из прошлой, вводим сумму → литры.
    await tester.tap(find.byTooltip('Добавить заправку'));
    await tester.pumpAndSettle();
    expect(fieldText(tester, 'fuel_price'), '50');
    await enter(tester, 'fuel_mileage', '13000');
    await enter(tester, 'fuel_total', '2000');
    expect(fieldText(tester, 'fuel_liters'), '40');
    await save(tester);

    // 40 л на 500 км.
    expect(find.text('8,0 л/100 км'), findsOneWidget);
    expect(find.text('8,0'), findsOneWidget);
  });

  testWidgets('записи за один день не ограничивают друг друга', (tester) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      fuel: [testFuelDraft(date: today, mileage: 13000)],
    );
    await openFuelTab(tester);

    // Например, забыли внести утреннюю заправку и добавляем её вечером.
    await tester.tap(find.byTooltip('Добавить заправку'));
    await tester.pumpAndSettle();
    await enter(tester, 'fuel_mileage', '12900');
    await enter(tester, 'fuel_liters', '30');
    await save(tester);

    expect(find.text('Новая заправка'), findsNothing);
    expect(find.textContaining('12\u00A0900 км'), findsOneWidget);
  });

  testWidgets('пробег меньше, чем в записи за прошлый день, — ошибка', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      fuel: [
        testFuelDraft(
          date: today.subtract(const Duration(days: 3)),
          mileage: 13000,
        ),
      ],
    );
    await openFuelTab(tester);

    await tester.tap(find.byTooltip('Добавить заправку'));
    await tester.pumpAndSettle();
    await enter(tester, 'fuel_mileage', '12900');
    await enter(tester, 'fuel_liters', '30');
    await save(tester);

    expect(
      find.text('Меньше, чем в более ранней записи (13 000 км)'),
      findsOneWidget,
    );
    expect(find.text('Новая заправка'), findsOneWidget);
  });

  testWidgets('неполный бак отмечается в списке, удаление записи', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      fuel: [
        testFuelDraft(
          date: today.subtract(const Duration(days: 1)),
          mileage: 13000,
          isFullTank: false,
        ),
      ],
    );
    await openFuelTab(tester);

    expect(find.byTooltip('Неполный бак'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('fuel_1')));
    await tester.pumpAndSettle();
    expect(find.text('Заправка'), findsOneWidget);

    await tester.tap(find.byTooltip('Удалить'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Удалить'));
    await tester.pumpAndSettle();

    expect(find.text('Пока нет заправок'), findsOneWidget);
  });
}
