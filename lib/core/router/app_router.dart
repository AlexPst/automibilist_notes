import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/car.dart';
import '../../features/cars/application/cars_providers.dart';
import '../../features/cars/presentation/car_form_screen.dart';
import '../../features/cars/presentation/cars_screen.dart';
import '../../features/cars/presentation/onboarding_screen.dart';
import '../../features/expenses/presentation/expense_form_screen.dart';
import '../../features/expenses/presentation/expenses_screen.dart';
import '../../features/fuel/presentation/fuel_form_screen.dart';
import '../../features/fuel/presentation/fuel_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/service/domain/reminder_templates.dart';
import '../../features/service/presentation/reminder_form_screen.dart';
import '../../features/service/presentation/service_record_form_screen.dart';
import '../../features/service/presentation/service_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/stats/presentation/stats_screen.dart';
import '../widgets/main_shell.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Роутер пересчитывает redirect при изменении списка автомобилей.
  final cars = ValueNotifier<AsyncValue<List<Car>>>(const AsyncLoading());
  ref.listen(
    carsListProvider,
    (_, next) => cars.value = next,
    fireImmediately: true,
  );

  // Навигатор над нижней панелью — для полноэкранных форм.
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  GoRoute fullScreen(String path, Widget Function(GoRouterState) builder) {
    return GoRoute(
      path: path,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => builder(state),
    );
  }

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    refreshListenable: cars,
    redirect: (context, state) => _redirect(cars.value, state.uri.path),
    routes: [
      // У каждой вкладки свой стек навигации, состояние вкладок сохраняется.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          _branch(AppRoutes.home, const HomeScreen()),
          _branch(
            AppRoutes.fuel,
            const FuelScreen(),
            routes: [
              fullScreen('new', (state) => const FuelFormScreen()),
              fullScreen(
                ':id/edit',
                (state) => FuelFormScreen(
                  entryId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          _branch(
            AppRoutes.expenses,
            const ExpensesScreen(),
            routes: [
              fullScreen('new', (state) => const ExpenseFormScreen()),
              fullScreen(
                ':id/edit',
                (state) => ExpenseFormScreen(
                  expenseId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          _branch(
            AppRoutes.service,
            const ServiceScreen(),
            routes: [
              fullScreen(
                'reminders/new',
                (state) => ReminderFormScreen(
                  template: ReminderTemplate.values
                      .asNameMap()[state.uri.queryParameters['template']],
                ),
              ),
              fullScreen(
                'reminders/:id/edit',
                (state) => ReminderFormScreen(
                  reminderId: int.parse(state.pathParameters['id']!),
                ),
              ),
              fullScreen(
                'records/new',
                (state) => ServiceRecordFormScreen(
                  reminderId: int.tryParse(
                    state.uri.queryParameters['reminderId'] ?? '',
                  ),
                ),
              ),
              fullScreen(
                'records/:id/edit',
                (state) => ServiceRecordFormScreen(
                  recordId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          _branch(AppRoutes.stats, const StatsScreen()),
        ],
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) =>
                const CarFormScreen(fromOnboarding: true),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.cars,
        builder: (context, state) => const CarsScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const CarFormScreen(),
          ),
          GoRoute(
            path: ':id/edit',
            builder: (context, state) =>
                CarFormScreen(carId: int.parse(state.pathParameters['id']!)),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    cars.dispose();
  });
  return router;
}

/// Без автомобилей доступен только онбординг; с ними — всё, кроме него.
String? _redirect(AsyncValue<List<Car>> cars, String path) {
  final list = cars.value;
  if (list == null) return null;

  final onOnboarding = path.startsWith(AppRoutes.onboarding);
  if (list.isEmpty && !onOnboarding) return AppRoutes.onboarding;
  if (list.isNotEmpty && onOnboarding) return AppRoutes.home;
  return null;
}

StatefulShellBranch _branch(
  String path,
  Widget screen, {
  List<RouteBase> routes = const [],
}) {
  return StatefulShellBranch(
    routes: [
      GoRoute(path: path, builder: (context, state) => screen, routes: routes),
    ],
  );
}
