// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_appointments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing paginated appointments for a specific patient.
///
/// Uses a family provider pattern to maintain separate state per patient.

@ProviderFor(PatientAppointmentsController)
final patientAppointmentsControllerProvider =
    PatientAppointmentsControllerFamily._();

/// Controller for managing paginated appointments for a specific patient.
///
/// Uses a family provider pattern to maintain separate state per patient.
final class PatientAppointmentsControllerProvider
    extends $AsyncNotifierProvider<PatientAppointmentsController,
        PaginatedState<AppointmentSchedule>> {
  /// Controller for managing paginated appointments for a specific patient.
  ///
  /// Uses a family provider pattern to maintain separate state per patient.
  PatientAppointmentsControllerProvider._(
      {required PatientAppointmentsControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientAppointmentsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientAppointmentsControllerHash();

  @override
  String toString() {
    return r'patientAppointmentsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientAppointmentsController create() => PatientAppointmentsController();

  @override
  bool operator ==(Object other) {
    return other is PatientAppointmentsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientAppointmentsControllerHash() =>
    r'e4864068b2c2c0f21b6eb40650fcd30376fa803d';

/// Controller for managing paginated appointments for a specific patient.
///
/// Uses a family provider pattern to maintain separate state per patient.

final class PatientAppointmentsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientAppointmentsController,
            AsyncValue<PaginatedState<AppointmentSchedule>>,
            PaginatedState<AppointmentSchedule>,
            FutureOr<PaginatedState<AppointmentSchedule>>,
            String> {
  PatientAppointmentsControllerFamily._()
      : super(
          retry: null,
          name: r'patientAppointmentsControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing paginated appointments for a specific patient.
  ///
  /// Uses a family provider pattern to maintain separate state per patient.

  PatientAppointmentsControllerProvider call(
    String patientId,
  ) =>
      PatientAppointmentsControllerProvider._(argument: patientId, from: this);

  @override
  String toString() => r'patientAppointmentsControllerProvider';
}

/// Controller for managing paginated appointments for a specific patient.
///
/// Uses a family provider pattern to maintain separate state per patient.

abstract class _$PatientAppointmentsController
    extends $AsyncNotifier<PaginatedState<AppointmentSchedule>> {
  late final _$args = ref.$arg as String;
  String get patientId => _$args;

  FutureOr<PaginatedState<AppointmentSchedule>> build(
    String patientId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<
        AsyncValue<PaginatedState<AppointmentSchedule>>,
        PaginatedState<AppointmentSchedule>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PaginatedState<AppointmentSchedule>>,
            PaginatedState<AppointmentSchedule>>,
        AsyncValue<PaginatedState<AppointmentSchedule>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
