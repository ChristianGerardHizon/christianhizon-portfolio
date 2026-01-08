// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppointmentScheduleFormController)
final appointmentScheduleFormControllerProvider =
    AppointmentScheduleFormControllerFamily._();

final class AppointmentScheduleFormControllerProvider
    extends $AsyncNotifierProvider<AppointmentScheduleFormController,
        AppointmentScheduleState> {
  AppointmentScheduleFormControllerProvider._(
      {required AppointmentScheduleFormControllerFamily super.from,
      required (
        String?, {
        String? patientId,
        String? patientRecordId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'appointmentScheduleFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$appointmentScheduleFormControllerHash();

  @override
  String toString() {
    return r'appointmentScheduleFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  AppointmentScheduleFormController create() =>
      AppointmentScheduleFormController();

  @override
  bool operator ==(Object other) {
    return other is AppointmentScheduleFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentScheduleFormControllerHash() =>
    r'dd4b545c1e9ce4d2804cec9d6584cf0fbf242a7b';

final class AppointmentScheduleFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            AppointmentScheduleFormController,
            AsyncValue<AppointmentScheduleState>,
            AppointmentScheduleState,
            FutureOr<AppointmentScheduleState>,
            (
              String?, {
              String? patientId,
              String? patientRecordId,
            })> {
  AppointmentScheduleFormControllerFamily._()
      : super(
          retry: null,
          name: r'appointmentScheduleFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AppointmentScheduleFormControllerProvider call(
    String? id, {
    String? patientId,
    String? patientRecordId,
  }) =>
      AppointmentScheduleFormControllerProvider._(argument: (
        id,
        patientId: patientId,
        patientRecordId: patientRecordId,
      ), from: this);

  @override
  String toString() => r'appointmentScheduleFormControllerProvider';
}

abstract class _$AppointmentScheduleFormController
    extends $AsyncNotifier<AppointmentScheduleState> {
  late final _$args = ref.$arg as (
    String?, {
    String? patientId,
    String? patientRecordId,
  });
  String? get id => _$args.$1;
  String? get patientId => _$args.patientId;
  String? get patientRecordId => _$args.patientRecordId;

  FutureOr<AppointmentScheduleState> build(
    String? id, {
    String? patientId,
    String? patientRecordId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<AppointmentScheduleState>, AppointmentScheduleState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AppointmentScheduleState>,
            AppointmentScheduleState>,
        AsyncValue<AppointmentScheduleState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              patientId: _$args.patientId,
              patientRecordId: _$args.patientRecordId,
            ));
  }
}
