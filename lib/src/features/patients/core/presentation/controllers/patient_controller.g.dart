// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientController)
final patientControllerProvider = PatientControllerFamily._();

final class PatientControllerProvider
    extends $AsyncNotifierProvider<PatientController, Patient> {
  PatientControllerProvider._(
      {required PatientControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientControllerHash();

  @override
  String toString() {
    return r'patientControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientController create() => PatientController();

  @override
  bool operator ==(Object other) {
    return other is PatientControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientControllerHash() => r'bd17935155298b4102dd46a6e10753388089c9b4';

final class PatientControllerFamily extends $Family
    with
        $ClassFamilyOverride<PatientController, AsyncValue<Patient>, Patient,
            FutureOr<Patient>, String> {
  PatientControllerFamily._()
      : super(
          retry: null,
          name: r'patientControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientControllerProvider call(
    String id,
  ) =>
      PatientControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientControllerProvider';
}

abstract class _$PatientController extends $AsyncNotifier<Patient> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<Patient> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Patient>, Patient>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Patient>, Patient>,
        AsyncValue<Patient>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
