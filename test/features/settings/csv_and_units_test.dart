import 'package:cardiary/core/settings/app_settings.dart';
import 'package:cardiary/core/utils/formatters.dart';
import 'package:cardiary/data/models/car.dart';
import 'package:cardiary/data/models/expense.dart';
import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/data/models/fuel_entry.dart';
import 'package:cardiary/data/models/fuel_type.dart';
import 'package:cardiary/data/models/service_record.dart';
import 'package:cardiary/features/settings/application/csv_report.dart';
import 'package:cardiary/l10n/app_localizations_ru.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() => displayFormat = const DisplayFormat());

  group('CSV', () {
    final l10n = AppLocalizationsRu();

    final csv = buildCsvReport(
      l10n: l10n,
      fuel: [
        FuelEntry(
          id: 1,
          carId: 1,
          date: DateTime(2026, 10, 5),
          mileage: 16000,
          liters: 40.5,
          pricePerLiter: 56.9,
          totalCost: 2304.45,
          isFullTank: true,
          station: 'Лукойл',
        ),
      ],
      expenses: [
        Expense(
          id: 1,
          carId: 1,
          date: DateTime(2026, 10, 1),
          category: ExpenseCategory.wash,
          amount: 650,
          comment: 'сказали "как новая"; спасибо',
        ),
      ],
      service: [
        ServiceRecord(
          id: 1,
          carId: 1,
          title: 'Замена масла',
          date: DateTime(2026, 10, 9),
          mileage: 16200,
          cost: 4500,
          station: 'СТО',
        ),
      ],
    );
    final lines = csv.split('\r\n');

    test('BOM, заголовок и разделитель «;»', () {
      expect(csv.startsWith('﻿'), isTrue);
      expect(
        lines.first.substring(1),
        'Дата;Тип;Категория / вид работ;Сумма, ₽;Пробег, км;Литры;'
        'Цена за литр, ₽;Полный бак;АЗС / СТО;Комментарий',
      );
    });

    test('строки по дате, десятичная запятая, экранирование', () {
      expect(
        lines[1],
        '01.10.2026;Расход;Мойка;650,00;;;;;;'
        '"сказали ""как новая""; спасибо"',
      );
      expect(
        lines[2],
        '05.10.2026;Заправка;;2304,45;16000;40,5;56,90;да;Лукойл;',
      );
      expect(lines[3], '09.10.2026;ТО;Замена масла;4500,00;16200;;;;СТО;');
      expect(lines, hasLength(5)); // и пустая строка после последнего \r\n
    });

    test('валюта в заголовке — из настроек', () {
      displayFormat = const DisplayFormat(currency: Currency.usd);
      final usd = buildCsvReport(
        l10n: l10n,
        fuel: const [],
        expenses: const [],
        service: const [],
      );
      expect(usd, contains(r'Сумма, $'));
    });

    test('имя файла', () {
      const car = Car(
        id: 1,
        brand: 'Lada',
        model: 'Vesta SW Cross',
        fuelType: FuelType.ai95,
        initialMileage: 0,
      );
      expect(
        csvFileName(car, DateTime(2026, 10, 23)),
        'cardiary-lada-vesta-sw-cross-2026-10-23.csv',
      );
    });
  });

  group('единицы и валюта', () {
    test('по умолчанию — л/100 км и рубли', () {
      expect(formatConsumption(7.84), '7,8');
      expect(formatMoney(1500).replaceAll(' ', ' '), '1 500,00 ₽');
    });

    test('км/л — пересчёт из л/100 км', () {
      displayFormat = const DisplayFormat(
        consumptionUnit: ConsumptionUnit.kmPerLiter,
      );
      expect(displayConsumption(8), 12.5);
      expect(formatConsumption(8), '12,5');
    });

    test('знак валюты', () {
      displayFormat = const DisplayFormat(currency: Currency.eur);
      expect(currencySymbol, '€');
      expect(formatMoney(10), contains('€'));
    });
  });
}
