// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_appointments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing appointments for a specific date.
///
/// Fetches only appointments for the selected date and current branch,
/// making it more efficient than loading all appointments.

@ProviderFor(DailyAppointmentsController)
final dailyAppointmentsControllerProvider =
    DailyAppointmentsControllerFamily._();

/// Controller for managing appointments for a specific date.
///
/// Fetches only appointments for the selected date and current branch,
/// making it more efficient than loading all appointments.
final class DailyAppointmentsControllerProvider extends $AsyncNotifierProvider<
    DailyAppointmentsController, List<AppointmentSchedule>> {
  /// Controller for managing appointments for a specific date.
  ///
  /// Fetches only appointments for the selected date and current branch,
  /// making it more efficient than loading all appointments.
  DailyAppointmentsControllerProvider._(
      {required DailyAppointmentsControllerFamily super.from,
      required DateTime super.argument})
      : super(
          retry: null,
          name: r'dailyAppointmentsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dailyAppointmentsControllerHash();

  @override
  String toString() {
    return r'dailyAppointmentsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DailyAppointmentsController create() => DailyAppointmentsController();

  @override
  bool operator ==(Object other) {
    return other is DailyAppointmentsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dailyAppointmentsControllerHash() =>
    r'5475cad7906f3d276ca8c6cdedcdc916366ab7e8';

/// Controller for managing appointments for a specific date.
///
/// Fetches only appointments for the selected date and current branch,
/// making it more efficient than loading all appointments.

final class DailyAppointmentsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            DailyAppointmentsController,
            AsyncValue<List<AppointmentSchedule>>,
            List<AppointmentSchedule>,
            FutureOr<List<AppointmentSchedule>>,
            DateTime> {
  DailyAppointmentsControllerFamily._()
      : super(
          retry: null,
          name: r'dailyAppointmentsControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing appointments for a specific date.
  ///
  /// Fetches only appointments for the selected date and current branch,
  /// making it more efficient than loading all appointments.

  DailyAppointmentsControllerProvider call(
    DateTime date,
  ) =>
      DailyAppointmentsControllerProvider._(argument: date, from: this);

  @override
  String toString() => r'dailyAppointmentsControllerProvider';
}

/// Controller for managing appointments for a specific date.
///
/// Fetches only appointments for the selected date and current branch,
/// making it more efficient than loading all appointments.

abstract class _$DailyAppointmentsController
    extends $AsyncNotifier<List<AppointmentSchedule>> {
  late final _$args = ref.$arg as DateTime;
  DateTime get date => _$args;

  FutureOr<List<AppointmentSchedule>> build(
    DateTime date,
  );
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
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
