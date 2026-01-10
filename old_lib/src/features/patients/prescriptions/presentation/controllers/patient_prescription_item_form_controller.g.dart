// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_item_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientPrescriptionItemFormController)
final patientPrescriptionItemFormControllerProvider =
    PatientPrescriptionItemFormControllerFamily._();

final class PatientPrescriptionItemFormControllerProvider
    extends $AsyncNotifierProvider<PatientPrescriptionItemFormController,
        PatientPrescriptionItemFormState> {
  PatientPrescriptionItemFormControllerProvider._(
      {required PatientPrescriptionItemFormControllerFamily super.from,
      required ({
        String parentId,
        String? id,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientPrescriptionItemFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientPrescriptionItemFormControllerHash();

  @override
  String toString() {
    return r'patientPrescriptionItemFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientPrescriptionItemFormController create() =>
      PatientPrescriptionItemFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionItemFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientPrescriptionItemFormControllerHash() =>
    r'b69dd3501a8278ac56e2b962ab5a037bf2661704';

final class PatientPrescriptionItemFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientPrescriptionItemFormController,
            AsyncValue<PatientPrescriptionItemFormState>,
            PatientPrescriptionItemFormState,
            FutureOr<PatientPrescriptionItemFormState>,
            ({
              String parentId,
              String? id,
            })> {
  PatientPrescriptionItemFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientPrescriptionItemFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientPrescriptionItemFormControllerProvider call({
    required String parentId,
    String? id,
  }) =>
      PatientPrescriptionItemFormControllerProvider._(argument: (
        parentId: parentId,
        id: id,
      ), from: this);

  @override
  String toString() => r'patientPrescriptionItemFormControllerProvider';
}

abstract class _$PatientPrescriptionItemFormController
    extends $AsyncNotifier<PatientPrescriptionItemFormState> {
  late final _$args = ref.$arg as ({
    String parentId,
    String? id,
  });
  String get parentId => _$args.parentId;
  String? get id => _$args.id;

  FutureOr<PatientPrescriptionItemFormState> build({
    required String parentId,
    String? id,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientPrescriptionItemFormState>,
        PatientPrescriptionItemFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientPrescriptionItemFormState>,
            PatientPrescriptionItemFormState>,
        AsyncValue<PatientPrescriptionItemFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              parentId: _$args.parentId,
              id: _$args.id,
            ));
  }
}
