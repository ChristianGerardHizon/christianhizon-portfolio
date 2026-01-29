// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing the main appointments list.
///
/// Provides a global, cached list of all appointments with CRUD operations.

@ProviderFor(AppointmentsController)
final appointmentsControllerProvider = AppointmentsControllerProvider._();

/// Controller for managing the main appointments list.
///
/// Provides a global, cached list of all appointments with CRUD operations.
final class AppointmentsControllerProvider extends $AsyncNotifierProvider<
    AppointmentsController, List<AppointmentSchedule>> {
  /// Controller for managing the main appointments list.
  ///
  /// Provides a global, cached list of all appointments with CRUD operations.
  AppointmentsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentsControllerHash();

  @$internal
  @override
  AppointmentsController create() => AppointmentsController();
}

String _$appointmentsControllerHash() =>
    r'df6c0e790e964b694e68e0d4a301f664e83e71b6';

/// Controller for managing the main appointments list.
///
/// Provides a global, cached list of all appointments with CRUD operations.

abstract class _$AppointmentsController
    extends $AsyncNotifier<List<AppointmentSchedule>> {
  FutureOr<List<AppointmentSchedule>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AppointmentSchedule>>,
        List<AppointmentSchedule>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<AppointmentSchedule>>,
            List<AppointmentSchedule>>,
        AsyncValue<List<AppointmentSchedule>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for fetching a single appointment by ID.

@ProviderFor(appointment)
final appointmentProvider = AppointmentFamily._();

/// Provider for fetching a single appointment by ID.

final class AppointmentProvider extends $FunctionalProvider<
        AsyncValue<AppointmentSchedule?>,
        AppointmentSchedule?,
        FutureOr<AppointmentSchedule?>>
    with
        $FutureModifier<AppointmentSchedule?>,
        $FutureProvider<AppointmentSchedule?> {
  /// Provider for fetching a single appointment by ID.
  AppointmentProvider._(
      {required AppointmentFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'appointmentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentHash();

  @override
  String toString() {
    return r'appointmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AppointmentSchedule?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppointmentSchedule?> create(Ref ref) {
    final argument = this.argument as String;
    return appointment(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentHash() => r'759146bed3a684a4d370bf6eb558c1023044aaec';

/// Provider for fetching a single appointment by ID.

final class AppointmentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AppointmentSchedule?>, String> {
  AppointmentFamily._()
      : super(
          retry: null,
          name: r'appointmentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching a single appointment by ID.

  AppointmentProvider call(
    String id,
  ) =>
      AppointmentProvider._(argument: id, from: this);

  @override
  String toString() => r'appointmentProvider';
}

/// Provider for fetching appointments by date.

@ProviderFor(appointmentsByDate)
final appointmentsByDateProvider = AppointmentsByDateFamily._();

/// Provider for fetching appointments by date.

final class AppointmentsByDateProvider extends $FunctionalProvider<
        AsyncValue<List<AppointmentSchedule>>,
        List<AppointmentSchedule>,
        FutureOr<List<AppointmentSchedule>>>
    with
        $FutureModifier<List<AppointmentSchedule>>,
        $FutureProvider<List<AppointmentSchedule>> {
  /// Provider for fetching appointments by date.
  AppointmentsByDateProvider._(
      {required AppointmentsByDateFamily super.from,
      required DateTime super.argument})
      : super(
          retry: null,
          name: r'appointmentsByDateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentsByDateHash();

  @override
  String toString() {
    return r'appointmentsByDateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AppointmentSchedule>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppointmentSchedule>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return appointmentsByDate(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentsByDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentsByDateHash() =>
    r'2200f18f508748d09435f62281e342bc7835edfc';

/// Provider for fetching appointments by date.

final class AppointmentsByDateFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<AppointmentSchedule>>,
            DateTime> {
  AppointmentsByDateFamily._()
      : super(
          retry: null,
          name: r'appointmentsByDateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching appointments by date.

  AppointmentsByDateProvider call(
    DateTime date,
  ) =>
      AppointmentsByDateProvider._(argument: date, from: this);

  @override
  String toString() => r'appointmentsByDateProvider';
}
