import 'package:cardiary/data/models/expense.dart';
import 'package:cardiary/data/models/expense_category.dart';
import 'package:cardiary/data/models/fuel_entry.dart';
import 'package:cardiary/data/models/service_record.dart';
import 'package:cardiary/features/stats/domain/distance.dart';
import 'package:cardiary/features/stats/domain/spending.dart';
import 'package:cardiary/features/stats/domain/stats_period.dart';
import 'package:cardiary/features/stats/domain/stats_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 10, 23, 12);
  var nextId = 0;

  FuelEntry fuel(
    DateTime date,
    int mileage,
    double liters, {
    bool full = true,
  }) => FuelEntry(
    id: ++nextId,
    carId: 1,
    date: date,
    mileage: mileage,
    liters: liters,
    pricePerLiter: 50,
    totalCost: liters * 50,
    isFullTank: full,
  );

  Expense expense(
    DateTime date,
    ExpenseCategory category,
    double amount, {
    int? mileage,
  }) => Expense(
    id: ++nextId,
    carId: 1,
    date: date,
    category: category,
    amount: amount,
    mileage: mileage,
  );

  ServiceRecord service(DateTime date, int mileage, double? cost) =>
      ServiceRecord(
        id: ++nextId,
        carId: 1,
        title: 'Масло',
        date: date,
        mileage: mileage,
        cost: cost,
      );

  group('периоды', () {
    test('месяц и год — включительно, без соседних', () {
      expect(StatsPeriod.month.contains(DateTime(2026, 10, 1), now), isTrue);
      expect(StatsPeriod.month.contains(DateTime(2026, 10, 31), now), isTrue);
      expect(StatsPeriod.month.contains(DateTime(2026, 9, 30), now), isFalse);
      expect(StatsPeriod.year.contains(DateTime(2026, 1, 1), now), isTrue);
      expect(StatsPeriod.year.contains(DateTime(2025, 12, 31), now), isFalse);
      expect(StatsPeriod.all.contains(DateTime(2000), now), isTrue);
    });
  });

  group('траты', () {
    test('ТО без стоимости не считается тратой', () {
      final items = collectSpending(
        fuel: [fuel(DateTime(2026, 10, 1), 1000, 40)],
        expenses: [],
        service: [
          service(DateTime(2026, 10, 2), 1100, null),
          service(DateTime(2026, 10, 3), 1200, 4500),
        ],
      );
      expect(items.map((s) => (s.category, s.amount)), [
        (StatsCategory.fuel, 2000.0),
        (StatsCategory.service, 4500.0),
      ]);
    });

    test('категории расходов сводятся к восьми', () {
      expect(
        StatsCategory.ofExpense(ExpenseCategory.parts),
        StatsCategory.repair,
      );
      expect(
        StatsCategory.ofExpense(ExpenseCategory.parking),
        StatsCategory.other,
      );
      expect(StatsCategory.values, hasLength(8));
    });

    test('суммы по категориям — в постоянном порядке, без пустых', () {
      final totals = totalsByCategory([
        Spending(now, 300, StatsCategory.wash),
        Spending(now, 2000, StatsCategory.fuel),
        Spending(now, 1000, StatsCategory.fuel),
        Spending(now, 5000, StatsCategory.repair),
      ]);
      expect(totals.keys, [
        StatsCategory.fuel,
        StatsCategory.repair,
        StatsCategory.wash,
      ]);
      expect(totals[StatsCategory.fuel], 3000);
    });

    test('по месяцам: пустые месяцы — нули, через границу года', () {
      final months = totalsByMonth(
        [
          Spending(DateTime(2025, 11, 5), 100, StatsCategory.fuel),
          Spending(DateTime(2026, 1, 20), 200, StatsCategory.fuel),
          Spending(DateTime(2026, 1, 31), 50, StatsCategory.wash),
        ],
        from: DateTime(2025, 11, 15),
        to: DateTime(2026, 2, 1),
      );
      expect(months.map((m) => (m.month, m.amount)), [
        (DateTime(2025, 11), 100.0),
        (DateTime(2025, 12), 0.0),
        (DateTime(2026, 1), 250.0),
        (DateTime(2026, 2), 0.0),
      ]);
    });
  });

  group('пробег за период', () {
    final marks = <MileageMark>[
      (date: DateTime(2026, 9, 20), mileage: 15800),
      (date: DateTime(2026, 10, 5), mileage: 16000),
      (date: DateTime(2026, 10, 20), mileage: 16600),
    ];

    test('от последнего показания до периода до последнего в нём', () {
      expect(
        distanceInPeriod(
          initialMileage: 15000,
          marks: marks,
          start: DateTime(2026, 10),
          end: DateTime(2026, 11),
        ),
        800,
      );
    });

    test('всё время — от начального пробега', () {
      expect(
        distanceInPeriod(
          initialMileage: 15000,
          marks: marks,
          start: null,
          end: DateTime(2026, 11),
        ),
        1600,
      );
    });

    test('записей в периоде нет — ноль, а не минус', () {
      expect(
        distanceInPeriod(
          initialMileage: 15000,
          marks: marks,
          start: DateTime(2026, 11),
          end: DateTime(2026, 12),
        ),
        0,
      );
    });

    test('стоимость 1 км', () {
      expect(costPerKm(8000, 800), 10);
      expect(costPerKm(500, 0), isNull);
    });
  });

  test('сводка за месяц: итоги, прочие расходы, расход топлива', () {
    final stats = buildStats(
      period: StatsPeriod.month,
      now: now,
      initialMileage: 15000,
      fuel: [
        fuel(DateTime(2026, 9, 25), 15500, 40), // сентябрь — вне периода
        fuel(DateTime(2026, 10, 5), 16000, 40), // 40 л / 500 км
        fuel(DateTime(2026, 10, 15), 16300, 15, full: false),
        fuel(DateTime(2026, 10, 20), 16600, 30), // 45 л / 600 км
      ],
      expenses: [
        expense(DateTime(2026, 10, 10), ExpenseCategory.wash, 650),
        expense(DateTime(2026, 10, 11), ExpenseCategory.insurance, 12500),
        expense(DateTime(2025, 10, 11), ExpenseCategory.tax, 3000),
      ],
      service: [service(DateTime(2026, 10, 21), 16600, 4500)],
    );

    // Топливо за октябрь: (40 + 15 + 30) × 50.
    expect(stats.fuel, 4250);
    expect(stats.service, 4500);
    expect(stats.otherExpenses, 13150);
    expect(stats.total, 21900);
    // Пробег: 15 500 (до октября) → 16 600.
    expect(stats.distance, 1100);
    expect(stats.costPerKm, closeTo(19.91, 0.01));
    // Оба отрезка закончились в октябре: 85 л на 1 100 км.
    expect(stats.segments, hasLength(2));
    expect(stats.averageConsumption, closeTo(7.727, 0.001));
    // Столбцы: 6 последних месяцев, октябрь — последний.
    expect(stats.byMonth, hasLength(monthPeriodBars));
    expect(stats.byMonth.last.month, DateTime(2026, 10));
    expect(stats.byMonth.last.amount, 21900);
    expect(stats.byMonth[4].amount, 2000); // сентябрь
  });

  test('пустая сводка', () {
    final stats = buildStats(
      period: StatsPeriod.year,
      now: now,
      initialMileage: 0,
      fuel: const [],
      expenses: const [],
      service: const [],
    );
    expect(stats.isEmpty, isTrue);
    expect(stats.costPerKm, isNull);
    expect(stats.byMonth, hasLength(10)); // январь–октябрь
  });
}
