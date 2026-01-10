// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedules_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppointmentSchedulesController)
final appointmentSchedulesControllerProvider =
    AppointmentSchedulesControllerFamily._();

final class AppointmentSchedulesControllerProvider
    extends $AsyncNotifierProvider<AppointmentSchedulesController,
        List<AppointmentSchedule>> {
  AppointmentSchedulesControllerProvider._(
      {required AppointmentSchedulesControllerFamily super.from,
      required ({
        String patientId,
        String? patientRecordId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'appointmentSchedulesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentSchedulesControllerHash();

  @override
  String toString() {
    return r'appointmentSchedulesControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  AppointmentSchedulesController create() => AppointmentSchedulesController();

  @override
  bool operator ==(Object other) {
    return other is AppointmentSchedulesControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentSchedulesControllerHash() =>
    r'd128b68533625c885a9fcb8eedcf39bce99d230d';

final class AppointmentSchedulesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            AppointmentSchedulesController,
            AsyncValue<List<AppointmentSchedule>>,
            List<AppointmentSchedule>,
            FutureOr<List<AppointmentSchedule>>,
            ({
              String patientId,
              String? patientRecordId,
            })> {
  AppointmentSchedulesControllerFamily._()
      : super(
          retry: null,
          name: r'appointmentSchedulesControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AppointmentSchedulesControllerProvider call({
    required String patientId,
    String? patientRecordId,
  }) =>
      AppointmentSchedulesControllerProvider._(argument: (
        patientId: patientId,
        patientRecordId: patientRecordId,
      ), from: this);

  @override
  String toString() => r'appointmentSchedulesControllerProvider';
}

abstract class _$AppointmentSchedulesController
    extends $AsyncNotifier<List<AppointmentSchedule>> {
  late final _$args = ref.$arg as ({
    String patientId,
    String? patientRecordId,
  });
  String get patientId => _$args.patientId;
  String? get patientRecordId => _$args.patientRecordId;

  FutureOr<List<AppointmentSchedule>> build({
    required String patientId,
    String? patientRecordId,
  });
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
              patientId: _$args.patientId,
              patientRecordId: _$args.patientRecordId,
            ));
  }
}
