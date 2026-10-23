import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_app.dart';

void main() {
  /// Заголовок AppBar текущего экрана.
  Finder appBarTitle(String text) =>
      find.descendant(of: find.byType(AppBar), matching: find.text(text));

  testWidgets('приложение стартует на Главной', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(appBarTitle('Главная'), findsOneWidget);
  });

  testWidgets('вкладки переключаются', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);

    const tabs = {
      'Заправки': 'Заправки',
      'Расходы': 'Расходы',
      'ТО': 'ТО и напоминания',
      'Статистика': 'Статистика',
      'Главная': 'Главная',
    };

    for (final MapEntry(key: label, value: title) in tabs.entries) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();

      expect(appBarTitle(title), findsOneWidget, reason: 'вкладка $label');
    }
  });

  testWidgets('интерфейс на русском языке', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);

    final context = tester.element(find.byType(NavigationBar));
    expect(Localizations.localeOf(context).languageCode, 'ru');
    expect(MaterialLocalizations.of(context).okButtonLabel.toLowerCase(), 'ок');
  });
}
