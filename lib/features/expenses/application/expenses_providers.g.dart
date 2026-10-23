// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Расходы автомобиля, новые сверху.

@ProviderFor(expenses)
final expensesProvider = ExpensesFamily._();

/// Расходы автомобиля, новые сверху.

final class ExpensesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Expense>>,
          List<Expense>,
          Stream<List<Expense>>
        >
    with $FutureModifier<List<Expense>>, $StreamProvider<List<Expense>> {
  /// Расходы автомобиля, новые сверху.
  ExpensesProvider._({
    required ExpensesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'expensesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$expensesHash();

  @override
  String toString() {
    return r'expensesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Expense>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Expense>> create(Ref ref) {
    final argument = this.argument as int;
    return expenses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$expensesHash() => r'd4cdd728ac377da816967236cf3b0699da88cfdb';

/// Расходы автомобиля, новые сверху.

final class ExpensesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Expense>>, int> {
  ExpensesFamily._()
    : super(
        retry: null,
        name: r'expensesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Расходы автомобиля, новые сверху.

  ExpensesProvider call(int carId) =>
      ExpensesProvider._(argument: carId, from: this);

  @override
  String toString() => r'expensesProvider';
}

@ProviderFor(expense)
final expenseProvider = ExpenseFamily._();

final class ExpenseProvider
    extends
        $FunctionalProvider<AsyncValue<Expense?>, Expense?, FutureOr<Expense?>>
    with $FutureModifier<Expense?>, $FutureProvider<Expense?> {
  ExpenseProvider._({
    required ExpenseFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'expenseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$expenseHash();

  @override
  String toString() {
    return r'expenseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Expense?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Expense?> create(Ref ref) {
    final argument = this.argument as int;
    return expense(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$expenseHash() => r'fe37315d377fd4da3b0e0acee87963f237d0c4d4';

final class ExpenseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Expense?>, int> {
  ExpenseFamily._()
    : super(
        retry: null,
        name: r'expenseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExpenseProvider call(int id) => ExpenseProvider._(argument: id, from: this);

  @override
  String toString() => r'expenseProvider';
}

/// Текущий фильтр списка расходов (живёт, пока открыто приложение).

@ProviderFor(ExpenseFilterState)
final expenseFilterStateProvider = ExpenseFilterStateProvider._();

/// Текущий фильтр списка расходов (живёт, пока открыто приложение).
final class ExpenseFilterStateProvider
    extends $NotifierProvider<ExpenseFilterState, ExpenseFilter> {
  /// Текущий фильтр списка расходов (живёт, пока открыто приложение).
  ExpenseFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseFilterStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseFilterStateHash();

  @$internal
  @override
  ExpenseFilterState create() => ExpenseFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseFilter>(value),
    );
  }
}

String _$expenseFilterStateHash() =>
    r'57f7579c22ea034bf402ce961a4a201993540cda';

/// Текущий фильтр списка расходов (живёт, пока открыто приложение).

abstract class _$ExpenseFilterState extends $Notifier<ExpenseFilter> {
  ExpenseFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ExpenseFilter, ExpenseFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExpenseFilter, ExpenseFilter>,
              ExpenseFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Расходы активного авто после фильтра; `null`, пока данные грузятся.

@ProviderFor(filteredExpenses)
final filteredExpensesProvider = FilteredExpensesFamily._();

/// Расходы активного авто после фильтра; `null`, пока данные грузятся.

final class FilteredExpensesProvider
    extends $FunctionalProvider<List<Expense>?, List<Expense>?, List<Expense>?>
    with $Provider<List<Expense>?> {
  /// Расходы активного авто после фильтра; `null`, пока данные грузятся.
  FilteredExpensesProvider._({
    required FilteredExpensesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'filteredExpensesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredExpensesHash();

  @override
  String toString() {
    return r'filteredExpensesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Expense>?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Expense>? create(Ref ref) {
    final argument = this.argument as int;
    return filteredExpenses(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Expense>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Expense>?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredExpensesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredExpensesHash() => r'ef1616f0baa38df059511498e036f52134ba94e1';

/// Расходы активного авто после фильтра; `null`, пока данные грузятся.

final class FilteredExpensesFamily extends $Family
    with $FunctionalFamilyOverride<List<Expense>?, int> {
  FilteredExpensesFamily._()
    : super(
        retry: null,
        name: r'filteredExpensesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Расходы активного авто после фильтра; `null`, пока данные грузятся.

  FilteredExpensesProvider call(int carId) =>
      FilteredExpensesProvider._(argument: carId, from: this);

  @override
  String toString() => r'filteredExpensesProvider';
}
