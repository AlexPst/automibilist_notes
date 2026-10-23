import 'package:cardiary/data/models/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  Future<void> openExpensesTab(WidgetTester tester) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Расходы'),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Текст суммы «Итого» без неразрывных пробелов.
  String total(WidgetTester tester) => tester
      .widget<Text>(find.byKey(const Key('expenses_total')))
      .data!
      .replaceAll(' ', ' ');

  Finder chip(String label) => find.widgetWithText(FilterChip, label);

  /// Чипы лежат в горизонтально прокручиваемых строках.
  Future<void> tapChip(WidgetTester tester, Finder chip) async {
    await tester.ensureVisible(chip);
    await tester.pumpAndSettle();
    await tester.tap(chip);
    await tester.pumpAndSettle();
  }

  testWidgets('пустой список расходов', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openExpensesTab(tester);

    expect(find.text('Пока нет расходов'), findsOneWidget);
  });

  testWidgets('добавление расхода', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    await openExpensesTab(tester);

    await tester.tap(find.byTooltip('Добавить расход'));
    await tester.pumpAndSettle();

    // Без категории и суммы не сохраняется.
    await tester.tap(find.byKey(const Key('expense_save')));
    await tester.pumpAndSettle();
    expect(find.text('Обязательное поле'), findsNWidgets(2));

    await tester.tap(find.byKey(const Key('expense_category')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Мойка').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('expense_amount')), '650,5');
    await tester.enterText(find.byKey(const Key('expense_comment')), 'Керхер');
    await tester.tap(find.byKey(const Key('expense_save')));
    await tester.pumpAndSettle();

    expect(find.text('Пока нет расходов'), findsNothing);
    expect(find.widgetWithText(ListTile, 'Мойка'), findsOneWidget);
    expect(find.textContaining('Керхер'), findsOneWidget);
    expect(total(tester), '650,50 ₽');
  });

  testWidgets('фильтр по категории и периоду', (tester) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      expenses: [
        testExpenseDraft(
          date: today,
          category: ExpenseCategory.wash,
          amount: 500,
        ),
        testExpenseDraft(
          date: today,
          category: ExpenseCategory.parking,
          amount: 200,
        ),
        testExpenseDraft(
          date: DateTime(today.year - 1, 6, 1),
          category: ExpenseCategory.wash,
          amount: 400,
        ),
      ],
    );
    await openExpensesTab(tester);
    expect(total(tester), '1 100,00 ₽');
    expect(find.text('3 записи'), findsOneWidget);

    // Только мойки — за всё время.
    await tapChip(tester, chip('Мойка'));
    expect(total(tester), '900,00 ₽');
    expect(find.widgetWithText(ListTile, 'Парковка'), findsNothing);

    // Мойки за этот год.
    await tapChip(tester, find.widgetWithText(ChoiceChip, 'Этот год'));
    expect(total(tester), '500,00 ₽');
    expect(find.text('1 запись'), findsOneWidget);

    // Штрафов нет — пусто, фильтр можно сбросить.
    await tapChip(tester, chip('Мойка'));
    await tapChip(tester, chip('Штрафы'));
    expect(find.text('Нет расходов по выбранному фильтру'), findsOneWidget);

    await tester.tap(find.text('Сбросить фильтр'));
    await tester.pumpAndSettle();
    expect(total(tester), '1 100,00 ₽');
  });

  testWidgets('редактирование и удаление расхода', (tester) async {
    await pumpTestApp(
      tester,
      cars: [testCarDraft()],
      expenses: [
        testExpenseDraft(
          date: today,
          category: ExpenseCategory.tax,
          amount: 3000,
        ),
      ],
    );
    await openExpensesTab(tester);

    await tester.tap(find.byKey(const ValueKey('expense_1')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('expense_amount')), '3500');
    await tester.tap(find.byKey(const Key('expense_save')));
    await tester.pumpAndSettle();
    expect(total(tester), '3 500,00 ₽');

    await tester.tap(find.byKey(const ValueKey('expense_1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Удалить'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Удалить'));
    await tester.pumpAndSettle();

    expect(find.text('Пока нет расходов'), findsOneWidget);
  });
}
