// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Выбранный на экране статистики период.

@ProviderFor(SelectedStatsPeriod)
final selectedStatsPeriodProvider = SelectedStatsPeriodProvider._();

/// Выбранный на экране статистики период.
final class SelectedStatsPeriodProvider
    extends $NotifierProvider<SelectedStatsPeriod, StatsPeriod> {
  /// Выбранный на экране статистики период.
  SelectedStatsPeriodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedStatsPeriodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedStatsPeriodHash();

  @$internal
  @override
  SelectedStatsPeriod create() => SelectedStatsPeriod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsPeriod value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsPeriod>(value),
    );
  }
}

String _$selectedStatsPeriodHash() =>
    r'625707d6929bf018192809c141cd2284b6fb8462';

/// Выбранный на экране статистики период.

abstract class _$SelectedStatsPeriod extends $Notifier<StatsPeriod> {
  StatsPeriod build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StatsPeriod, StatsPeriod>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StatsPeriod, StatsPeriod>,
              StatsPeriod,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Статистика автомобиля за период; `null`, пока данные грузятся.

@ProviderFor(stats)
final statsProvider = StatsFamily._();

/// Статистика автомобиля за период; `null`, пока данные грузятся.

final class StatsProvider
    extends $FunctionalProvider<StatsSummary?, StatsSummary?, StatsSummary?>
    with $Provider<StatsSummary?> {
  /// Статистика автомобиля за период; `null`, пока данные грузятся.
  StatsProvider._({
    required StatsFamily super.from,
    required (int, StatsPeriod) super.argument,
  }) : super(
         retry: null,
         name: r'statsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$statsHash();

  @override
  String toString() {
    return r'statsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<StatsSummary?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatsSummary? create(Ref ref) {
    final argument = this.argument as (int, StatsPeriod);
    return stats(ref, argument.$1, argument.$2);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsSummary? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsSummary?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$statsHash() => r'6b169f2a902d51727bb2920bffbcf132199bdd35';

/// Статистика автомобиля за период; `null`, пока данные грузятся.

final class StatsFamily extends $Family
    with $FunctionalFamilyOverride<StatsSummary?, (int, StatsPeriod)> {
  StatsFamily._()
    : super(
        retry: null,
        name: r'statsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Статистика автомобиля за период; `null`, пока данные грузятся.

  StatsProvider call(int carId, StatsPeriod period) =>
      StatsProvider._(argument: (carId, period), from: this);

  @override
  String toString() => r'statsProvider';
}
