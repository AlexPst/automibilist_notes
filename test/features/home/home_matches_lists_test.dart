import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/data/models/reminder_draft.dart';
import 'package:cardiary/data/models/service_record_draft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

/// Критерий итерации 5: цифры на Главной совпадают с данными в списках.
void main() {
  final now = DateTime.now();
  final thisMonth = DateTime(now.year, now.month, 1);
  final prevMonth = DateTime(now.year, now.month - 1, 15);

  String text(WidgetTester tester, String key) =>
      tester.widget<Text>(find.byKey(Key(key))).data!;

  Future<void> openTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> pumpData(WidgetTester tester) => pumpTestApp(
    tester,
    cars: [testCarDraft()], // начальный пробег 12 000
    fuel: [
      testFuelDraft(date: prevMonth, mileage: 12500, liters: 40),
      testFuelDraft(date: thisMonth, mileage: 13000, liters: 40, price: 55),
    ],
    expenses: [
      testExpenseDraft(
        date: thisMonth,
        category: ExpenseCategory.wash,
        amount: 650,
        mileage: 13100,
      ),
      testExpenseDraft(
        date: thisMonth,
        category: ExpenseCategory.parking,
        amount: 350,
      ),
      testExpenseDraft(
        date: prevMonth,
        category: ExpenseCategory.tax,
        amount: 3000,
      ),
    ],
    serviceRecords: [
      ServiceRecordDraft(
        carId: 1,
        title: 'Замена масла',
        date: thisMonth,
        mileage: 13200,
        cost: 4500,
      ),
    ],
    reminders: [
      ReminderDraft(
        carId: 1,
        title: 'ОСАГО',
        intervalMonths: 12,
        lastDoneDate: DateTime(now.year - 1, now.month, now.day + 3),
      ),
    ],
  );

  testWidgets('Главная: пробег, расход, месяц, напоминания', (tester) async {
    await pumpData(tester);

    final nbsp = RegExp('[  ]');
    String plain(String key) => text(tester, key).replaceAll(nbsp, ' ');

    // Пробег — наибольший из всех записей (ТО на 13 200).
    expect(plain('home_mileage_value'), '13 200 км');
    // Месяц: топливо 40 × 55, ТО 4 500, прочие 650 + 350.
    expect(plain('home_month_fuel'), '2 200,00 ₽');
    expect(plain('home_month_service'), '4 500,00 ₽');
    expect(plain('home_month_other'), '1 000,00 ₽');
    expect(plain('home_month_total'), '7 700,00 ₽');
    expect(find.text('ОСАГО'), findsOneWidget);
  });

  testWidgets('прочие расходы за месяц = итог списка расходов «Этот месяц»', (
    tester,
  ) async {
    await pumpData(tester);
    final homeOther = text(tester, 'home_month_other');

    await openTab(tester, 'Расходы');
    final chip = find.widgetWithText(ChoiceChip, 'Этот месяц');
    await tester.ensureVisible(chip);
    await tester.tap(chip);
    await tester.pumpAndSettle();

    expect(text(tester, 'expenses_total'), homeOther);
  });

  testWidgets('средний расход = средний расход на экране заправок', (
    tester,
  ) async {
    await pumpData(tester);
    final homeConsumption = text(tester, 'home_consumption_value');

    await openTab(tester, 'Заправки');

    // 40 л на 500 км = 8,0 л/100 км.
    expect(homeConsumption, '8,0 л/100 км');
    expect(text(tester, 'fuel_average'), homeConsumption);
  });

  testWidgets('итог месяца = «Всего» в статистике за месяц', (tester) async {
    await pumpData(tester);
    final homeTotal = text(tester, 'home_month_total');

    await openTab(tester, 'Статистика');
    expect(text(tester, 'stats_total'), homeTotal);

    // За всё время добавляются траты прошлого месяца: 2 000 + 3 000.
    await tester.tap(find.text('Всё время'));
    await tester.pumpAndSettle();
    expect(
      text(tester, 'stats_total').replaceAll(RegExp('[  ]'), ' '),
      '12 700,00 ₽',
    );
  });
}
