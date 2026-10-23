import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  Future<void> fillField(WidgetTester tester, String key, String text) async {
    final field = find.byKey(Key(key));
    await tester.ensureVisible(field);
    await tester.enterText(field, text);
  }

  Future<void> tapSave(WidgetTester tester) async {
    final save = find.byKey(const Key('car_save'));
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();
  }

  testWidgets('без автомобилей показывается онбординг', (tester) async {
    await pumpTestApp(tester);

    expect(find.text('Добавьте первый автомобиль'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('первый автомобиль добавляется с онбординга', (tester) async {
    await pumpTestApp(tester);

    await tester.tap(find.text('Добавить автомобиль'));
    await tester.pumpAndSettle();
    expect(find.text('Новый автомобиль'), findsOneWidget);

    // Пустая форма не сохраняется.
    await tapSave(tester);
    expect(find.text('Обязательное поле'), findsNWidgets(3));

    await fillField(tester, 'car_brand', 'Lada');
    await fillField(tester, 'car_model', 'Vesta');
    await fillField(tester, 'car_mileage', '15000');
    await fillField(tester, 'car_plate', 'а123вс77');
    await tapSave(tester);

    // Попали на Главную, на карточке — новый автомобиль.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Lada Vesta'), findsOneWidget);
    expect(find.textContaining('А123ВС77'), findsOneWidget);
  });

  testWidgets('переключение активного автомобиля', (tester) async {
    await pumpTestApp(
      tester,
      cars: [
        testCarDraft(brand: 'Lada', model: 'Vesta'),
        testCarDraft(brand: 'Kia', model: 'Rio'),
      ],
    );
    // По умолчанию активен первый.
    expect(find.text('Lada Vesta'), findsOneWidget);

    await tester.tap(find.byTooltip('Выбрать автомобиль'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kia Rio'));
    await tester.pumpAndSettle();

    expect(find.text('Kia Rio'), findsOneWidget);
    expect(find.text('Lada Vesta'), findsNothing);
  });

  testWidgets('добавление второго авто делает его активным', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);

    await tester.tap(find.byTooltip('Выбрать автомобиль'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Управление автомобилями'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await fillField(tester, 'car_brand', 'Kia');
    await fillField(tester, 'car_model', 'Rio');
    await fillField(tester, 'car_mileage', '500');
    await tapSave(tester);

    // Вернулись к списку: в нём два авто, Kia активна.
    expect(find.text('Автомобили'), findsOneWidget);
    expect(find.text('Lada Vesta'), findsOneWidget);
    final kia = tester.widget<ListTile>(
      find.ancestor(of: find.text('Kia Rio'), matching: find.byType(ListTile)),
    );
    expect(kia.selected, isTrue);
  });

  testWidgets('удаление последнего авто возвращает на онбординг', (
    tester,
  ) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);

    await tester.tap(find.byTooltip('Выбрать автомобиль'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Управление автомобилями'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Удалить'));
    await tester.pumpAndSettle();
    expect(find.text('Удалить автомобиль?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Удалить'));
    await tester.pumpAndSettle();

    expect(find.text('Добавьте первый автомобиль'), findsOneWidget);
  });
}
