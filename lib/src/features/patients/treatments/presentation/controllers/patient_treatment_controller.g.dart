// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentController)
final patientTreatmentControllerProvider = PatientTreatmentControllerFamily._();

final class PatientTreatmentControllerProvider extends $AsyncNotifierProvider<
    PatientTreatmentController, PatientTreatment> {
  PatientTreatmentControllerProvider._(
      {required PatientTreatmentControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentControllerHash();

  @override
  String toString() {
    return r'patientTreatmentControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTreatmentController create() => PatientTreatmentController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentControllerHash() =>
    r'4ae3e68a14dab6e041ee08186a8b9099748878a3';

final class PatientTreatmentControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentController,
            AsyncValue<PatientTreatment>,
            PatientTreatment,
            FutureOr<PatientTreatment>,
            String> {
  PatientTreatmentControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTreatmentControllerProvider call(
    String id,
  ) =>
      PatientTreatmentControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientTreatmentControllerProvider';
}

abstract class _$PatientTreatmentController
    extends $AsyncNotifier<PatientTreatment> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<PatientTreatment> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PatientTreatment>, PatientTreatment>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientTreatment>, PatientTreatment>,
        AsyncValue<PatientTreatment>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
