// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppointmentScheduleTableController)
final appointmentScheduleTableControllerProvider =
    AppointmentScheduleTableControllerFamily._();

final class AppointmentScheduleTableControllerProvider
    extends $AsyncNotifierProvider<AppointmentScheduleTableController,
        List<AppointmentSchedule>> {
  AppointmentScheduleTableControllerProvider._(
      {required AppointmentScheduleTableControllerFamily super.from,
      required (
        String, {
        String? patientId,
        DateTime? date,
        AppointmentScheduleStatus? status,
      })
          super.argument})
      : super(
          retry: null,
          name: r'appointmentScheduleTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$appointmentScheduleTableControllerHash();

  @override
  String toString() {
    return r'appointmentScheduleTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  AppointmentScheduleTableController create() =>
      AppointmentScheduleTableController();

  @override
  bool operator ==(Object other) {
    return other is AppointmentScheduleTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentScheduleTableControllerHash() =>
    r'50b6b9d84ddd87ef9c6898bebbef83b7f65e2ebd';

final class AppointmentScheduleTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            AppointmentScheduleTableController,
            AsyncValue<List<AppointmentSchedule>>,
            List<AppointmentSchedule>,
            FutureOr<List<AppointmentSchedule>>,
            (
              String, {
              String? patientId,
              DateTime? date,
              AppointmentScheduleStatus? status,
            })> {
  AppointmentScheduleTableControllerFamily._()
      : super(
          retry: null,
          name: r'appointmentScheduleTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AppointmentScheduleTableControllerProvider call(
    String tableKey, {
    String? patientId,
    DateTime? date,
    AppointmentScheduleStatus? status,
  }) =>
      AppointmentScheduleTableControllerProvider._(argument: (
        tableKey,
        patientId: patientId,
        date: date,
        status: status,
      ), from: this);

  @override
  String toString() => r'appointmentScheduleTableControllerProvider';
}

abstract class _$AppointmentScheduleTableController
    extends $AsyncNotifier<List<AppointmentSchedule>> {
  late final _$args = ref.$arg as (
    String, {
    String? patientId,
    DateTime? date,
    AppointmentScheduleStatus? status,
  });
  String get tableKey => _$args.$1;
  String? get patientId => _$args.patientId;
  DateTime? get date => _$args.date;
  AppointmentScheduleStatus? get status => _$args.status;

  FutureOr<List<AppointmentSchedule>> build(
    String tableKey, {
    String? patientId,
    DateTime? date,
    AppointmentScheduleStatus? status,
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
              _$args.$1,
              patientId: _$args.patientId,
              date: _$args.date,
              status: _$args.status,
            ));
  }
}
