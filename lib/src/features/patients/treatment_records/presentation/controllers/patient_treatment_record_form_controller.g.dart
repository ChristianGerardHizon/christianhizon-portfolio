// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentRecordFormController)
final patientTreatmentRecordFormControllerProvider =
    PatientTreatmentRecordFormControllerFamily._();

final class PatientTreatmentRecordFormControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentRecordFormController,
        PatientTreatmentRecordFormState> {
  PatientTreatmentRecordFormControllerProvider._(
      {required PatientTreatmentRecordFormControllerFamily super.from,
      required ({
        String? id,
        String patientId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentRecordFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientTreatmentRecordFormControllerHash();

  @override
  String toString() {
    return r'patientTreatmentRecordFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientTreatmentRecordFormController create() =>
      PatientTreatmentRecordFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentRecordFormControllerHash() =>
    r'20aee0932966a112df73babd07d4c1002aec9027';

final class PatientTreatmentRecordFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentRecordFormController,
            AsyncValue<PatientTreatmentRecordFormState>,
            PatientTreatmentRecordFormState,
            FutureOr<PatientTreatmentRecordFormState>,
            ({
              String? id,
              String patientId,
            })> {
  PatientTreatmentRecordFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentRecordFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTreatmentRecordFormControllerProvider call({
    String? id,
    required String patientId,
  }) =>
      PatientTreatmentRecordFormControllerProvider._(argument: (
        id: id,
        patientId: patientId,
      ), from: this);

  @override
  String toString() => r'patientTreatmentRecordFormControllerProvider';
}

abstract class _$PatientTreatmentRecordFormController
    extends $AsyncNotifier<PatientTreatmentRecordFormState> {
  late final _$args = ref.$arg as ({
    String? id,
    String patientId,
  });
  String? get id => _$args.id;
  String get patientId => _$args.patientId;

  FutureOr<PatientTreatmentRecordFormState> build({
    String? id,
    required String patientId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientTreatmentRecordFormState>,
        PatientTreatmentRecordFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientTreatmentRecordFormState>,
            PatientTreatmentRecordFormState>,
        AsyncValue<PatientTreatmentRecordFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              id: _$args.id,
              patientId: _$args.patientId,
            ));
  }
}
