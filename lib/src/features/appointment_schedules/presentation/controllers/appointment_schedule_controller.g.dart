// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppointmentScheduleController)
final appointmentScheduleControllerProvider =
    AppointmentScheduleControllerFamily._();

final class AppointmentScheduleControllerProvider
    extends $AsyncNotifierProvider<AppointmentScheduleController,
        AppointmentSchedule> {
  AppointmentScheduleControllerProvider._(
      {required AppointmentScheduleControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'appointmentScheduleControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentScheduleControllerHash();

  @override
  String toString() {
    return r'appointmentScheduleControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AppointmentScheduleController create() => AppointmentScheduleController();

  @override
  bool operator ==(Object other) {
    return other is AppointmentScheduleControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentScheduleControllerHash() =>
    r'c96f55199bd40cf070395d32727b810952ab751d';

final class AppointmentScheduleControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            AppointmentScheduleController,
            AsyncValue<AppointmentSchedule>,
            AppointmentSchedule,
            FutureOr<AppointmentSchedule>,
            String> {
  AppointmentScheduleControllerFamily._()
      : super(
          retry: null,
          name: r'appointmentScheduleControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AppointmentScheduleControllerProvider call(
    String id,
  ) =>
      AppointmentScheduleControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'appointmentScheduleControllerProvider';
}

abstract class _$AppointmentScheduleController
    extends $AsyncNotifier<AppointmentSchedule> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<AppointmentSchedule> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AppointmentSchedule>, AppointmentSchedule>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AppointmentSchedule>, AppointmentSchedule>,
        AsyncValue<AppointmentSchedule>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
