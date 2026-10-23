import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../cars/application/cars_providers.dart';
import '../../expenses/application/expenses_providers.dart';
import '../../fuel/application/fuel_providers.dart';
import '../../service/application/service_providers.dart';
import '../domain/stats_period.dart';
import '../domain/stats_summary.dart';

part 'stats_providers.g.dart';

/// Выбранный на экране статистики период.
@Riverpod(keepAlive: true)
class SelectedStatsPeriod extends _$SelectedStatsPeriod {
  @override
  StatsPeriod build() => StatsPeriod.month;

  void select(StatsPeriod period) => state = period;
}

/// Статистика автомобиля за период; `null`, пока данные грузятся.
@riverpod
StatsSummary? stats(Ref ref, int carId, StatsPeriod period) {
  final car = ref.watch(carByIdProvider(carId));
  final fuel = ref.watch(fuelEntriesProvider(carId)).value;
  final expenses = ref.watch(expensesProvider(carId)).value;
  final service = ref.watch(serviceRecordsProvider(carId)).value;
  if (car == null || fuel == null || expenses == null || service == null) {
    return null;
  }
  return buildStats(
    period: period,
    now: DateTime.now(),
    initialMileage: car.initialMileage,
    fuel: fuel,
    expenses: expenses,
    service: service,
  );
}
