// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentFormController)
final patientTreatmentFormControllerProvider =
    PatientTreatmentFormControllerFamily._();

final class PatientTreatmentFormControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentFormController,
        PatientTreatmentFormState> {
  PatientTreatmentFormControllerProvider._(
      {required PatientTreatmentFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentFormControllerHash();

  @override
  String toString() {
    return r'patientTreatmentFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTreatmentFormController create() => PatientTreatmentFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentFormControllerHash() =>
    r'ec1e21ca3583113a2a67ed705125e9ba06f9f80a';

final class PatientTreatmentFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentFormController,
            AsyncValue<PatientTreatmentFormState>,
            PatientTreatmentFormState,
            FutureOr<PatientTreatmentFormState>,
            String?> {
  PatientTreatmentFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTreatmentFormControllerProvider call(
    String? id,
  ) =>
      PatientTreatmentFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientTreatmentFormControllerProvider';
}

abstract class _$PatientTreatmentFormController
    extends $AsyncNotifier<PatientTreatmentFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<PatientTreatmentFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientTreatmentFormState>,
        PatientTreatmentFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientTreatmentFormState>,
            PatientTreatmentFormState>,
        AsyncValue<PatientTreatmentFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
