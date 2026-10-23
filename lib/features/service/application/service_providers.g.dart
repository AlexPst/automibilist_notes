// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reminders)
final remindersProvider = RemindersFamily._();

final class RemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reminder>>,
          List<Reminder>,
          Stream<List<Reminder>>
        >
    with $FutureModifier<List<Reminder>>, $StreamProvider<List<Reminder>> {
  RemindersProvider._({
    required RemindersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'remindersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remindersHash();

  @override
  String toString() {
    return r'remindersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Reminder>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reminder>> create(Ref ref) {
    final argument = this.argument as int;
    return reminders(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RemindersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remindersHash() => r'ee81e9ced87cf87fd6b05a16b8b97298e8a67df3';

final class RemindersFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Reminder>>, int> {
  RemindersFamily._()
    : super(
        retry: null,
        name: r'remindersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RemindersProvider call(int carId) =>
      RemindersProvider._(argument: carId, from: this);

  @override
  String toString() => r'remindersProvider';
}

@ProviderFor(allReminders)
final allRemindersProvider = AllRemindersProvider._();

final class AllRemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reminder>>,
          List<Reminder>,
          Stream<List<Reminder>>
        >
    with $FutureModifier<List<Reminder>>, $StreamProvider<List<Reminder>> {
  AllRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allRemindersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allRemindersHash();

  @$internal
  @override
  $StreamProviderElement<List<Reminder>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reminder>> create(Ref ref) {
    return allReminders(ref);
  }
}

String _$allRemindersHash() => r'394054c1f10cf711dd0893599281c31a8d85169b';

@ProviderFor(reminder)
final reminderProvider = ReminderFamily._();

final class ReminderProvider
    extends
        $FunctionalProvider<
          AsyncValue<Reminder?>,
          Reminder?,
          FutureOr<Reminder?>
        >
    with $FutureModifier<Reminder?>, $FutureProvider<Reminder?> {
  ReminderProvider._({
    required ReminderFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reminderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reminderHash();

  @override
  String toString() {
    return r'reminderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Reminder?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Reminder?> create(Ref ref) {
    final argument = this.argument as int;
    return reminder(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReminderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reminderHash() => r'6b9d6b541e6e4caa5ecdbe9ce0c1b2c0a6856607';

final class ReminderFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Reminder?>, int> {
  ReminderFamily._()
    : super(
        retry: null,
        name: r'reminderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReminderProvider call(int id) => ReminderProvider._(argument: id, from: this);

  @override
  String toString() => r'reminderProvider';
}

/// Записи ТО автомобиля, новые сверху.

@ProviderFor(serviceRecords)
final serviceRecordsProvider = ServiceRecordsFamily._();

/// Записи ТО автомобиля, новые сверху.

final class ServiceRecordsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ServiceRecord>>,
          List<ServiceRecord>,
          Stream<List<ServiceRecord>>
        >
    with
        $FutureModifier<List<ServiceRecord>>,
        $StreamProvider<List<ServiceRecord>> {
  /// Записи ТО автомобиля, новые сверху.
  ServiceRecordsProvider._({
    required ServiceRecordsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'serviceRecordsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$serviceRecordsHash();

  @override
  String toString() {
    return r'serviceRecordsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<ServiceRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ServiceRecord>> create(Ref ref) {
    final argument = this.argument as int;
    return serviceRecords(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceRecordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serviceRecordsHash() => r'2f9205a91af2215d88de05207daf0212467a2741';

/// Записи ТО автомобиля, новые сверху.

final class ServiceRecordsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<ServiceRecord>>, int> {
  ServiceRecordsFamily._()
    : super(
        retry: null,
        name: r'serviceRecordsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Записи ТО автомобиля, новые сверху.

  ServiceRecordsProvider call(int carId) =>
      ServiceRecordsProvider._(argument: carId, from: this);

  @override
  String toString() => r'serviceRecordsProvider';
}

@ProviderFor(serviceRecord)
final serviceRecordProvider = ServiceRecordFamily._();

final class ServiceRecordProvider
    extends
        $FunctionalProvider<
          AsyncValue<ServiceRecord?>,
          ServiceRecord?,
          FutureOr<ServiceRecord?>
        >
    with $FutureModifier<ServiceRecord?>, $FutureProvider<ServiceRecord?> {
  ServiceRecordProvider._({
    required ServiceRecordFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'serviceRecordProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$serviceRecordHash();

  @override
  String toString() {
    return r'serviceRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ServiceRecord?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ServiceRecord?> create(Ref ref) {
    final argument = this.argument as int;
    return serviceRecord(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceRecordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$serviceRecordHash() => r'79f157430174e75b80d853a46222ff1afac1c7f0';

final class ServiceRecordFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ServiceRecord?>, int> {
  ServiceRecordFamily._()
    : super(
        retry: null,
        name: r'serviceRecordProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ServiceRecordProvider call(int id) =>
      ServiceRecordProvider._(argument: id, from: this);

  @override
  String toString() => r'serviceRecordProvider';
}

/// Текущий пробег автомобиля по всем записям; `null`, пока грузится.

@ProviderFor(currentMileage)
final currentMileageProvider = CurrentMileageFamily._();

/// Текущий пробег автомобиля по всем записям; `null`, пока грузится.

final class CurrentMileageProvider extends $FunctionalProvider<int?, int?, int?>
    with $Provider<int?> {
  /// Текущий пробег автомобиля по всем записям; `null`, пока грузится.
  CurrentMileageProvider._({
    required CurrentMileageFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'currentMileageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentMileageHash();

  @override
  String toString() {
    return r'currentMileageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int? create(Ref ref) {
    final argument = this.argument as int;
    return currentMileage(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentMileageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentMileageHash() => r'05bebbb6042299ba4b16af19f7a7a34f6809e9ea';

/// Текущий пробег автомобиля по всем записям; `null`, пока грузится.

final class CurrentMileageFamily extends $Family
    with $FunctionalFamilyOverride<int?, int> {
  CurrentMileageFamily._()
    : super(
        retry: null,
        name: r'currentMileageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Текущий пробег автомобиля по всем записям; `null`, пока грузится.

  CurrentMileageProvider call(int carId) =>
      CurrentMileageProvider._(argument: carId, from: this);

  @override
  String toString() => r'currentMileageProvider';
}

/// Напоминания автомобиля: сначала просроченные, затем ближайшие.

@ProviderFor(reminderStatuses)
final reminderStatusesProvider = ReminderStatusesFamily._();

/// Напоминания автомобиля: сначала просроченные, затем ближайшие.

final class ReminderStatusesProvider
    extends
        $FunctionalProvider<
          List<ReminderWithStatus>?,
          List<ReminderWithStatus>?,
          List<ReminderWithStatus>?
        >
    with $Provider<List<ReminderWithStatus>?> {
  /// Напоминания автомобиля: сначала просроченные, затем ближайшие.
  ReminderStatusesProvider._({
    required ReminderStatusesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reminderStatusesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reminderStatusesHash();

  @override
  String toString() {
    return r'reminderStatusesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ReminderWithStatus>?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ReminderWithStatus>? create(Ref ref) {
    final argument = this.argument as int;
    return reminderStatuses(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ReminderWithStatus>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ReminderWithStatus>?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReminderStatusesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reminderStatusesHash() => r'4d95eabc808d9320b22303615dad08f91c6e5290';

/// Напоминания автомобиля: сначала просроченные, затем ближайшие.

final class ReminderStatusesFamily extends $Family
    with $FunctionalFamilyOverride<List<ReminderWithStatus>?, int> {
  ReminderStatusesFamily._()
    : super(
        retry: null,
        name: r'reminderStatusesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Напоминания автомобиля: сначала просроченные, затем ближайшие.

  ReminderStatusesProvider call(int carId) =>
      ReminderStatusesProvider._(argument: carId, from: this);

  @override
  String toString() => r'reminderStatusesProvider';
}

@ProviderFor(reminderNotifications)
final reminderNotificationsProvider = ReminderNotificationsProvider._();

final class ReminderNotificationsProvider
    extends
        $FunctionalProvider<
          ReminderNotifications,
          ReminderNotifications,
          ReminderNotifications
        >
    with $Provider<ReminderNotifications> {
  ReminderNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderNotificationsHash();

  @$internal
  @override
  $ProviderElement<ReminderNotifications> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderNotifications create(Ref ref) {
    return reminderNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderNotifications value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderNotifications>(value),
    );
  }
}

String _$reminderNotificationsHash() =>
    r'3b99ec598d31f73fe858534c78a1e3e4d796649e';

@ProviderFor(notificationScheduleInput)
final notificationScheduleInputProvider = NotificationScheduleInputProvider._();

final class NotificationScheduleInputProvider
    extends
        $FunctionalProvider<
          NotificationScheduleInput?,
          NotificationScheduleInput?,
          NotificationScheduleInput?
        >
    with $Provider<NotificationScheduleInput?> {
  NotificationScheduleInputProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationScheduleInputProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationScheduleInputHash();

  @$internal
  @override
  $ProviderElement<NotificationScheduleInput?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationScheduleInput? create(Ref ref) {
    return notificationScheduleInput(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationScheduleInput? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationScheduleInput?>(value),
    );
  }
}

String _$notificationScheduleInputHash() =>
    r'86cc08618742abfb6c9441fa419db98f8067b14a';

@ProviderFor(mileageCheckInput)
final mileageCheckInputProvider = MileageCheckInputProvider._();

final class MileageCheckInputProvider
    extends
        $FunctionalProvider<
          MileageCheckInput?,
          MileageCheckInput?,
          MileageCheckInput?
        >
    with $Provider<MileageCheckInput?> {
  MileageCheckInputProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mileageCheckInputProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mileageCheckInputHash();

  @$internal
  @override
  $ProviderElement<MileageCheckInput?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MileageCheckInput? create(Ref ref) {
    return mileageCheckInput(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MileageCheckInput? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MileageCheckInput?>(value),
    );
  }
}

String _$mileageCheckInputHash() => r'98f8d1c0a45bf84f6e7e2886e4fc10d7089f768a';
