// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentRecordController)
final patientTreatmentRecordControllerProvider =
    PatientTreatmentRecordControllerFamily._();

final class PatientTreatmentRecordControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentRecordController,
        PatientTreatmentRecordState> {
  PatientTreatmentRecordControllerProvider._(
      {required PatientTreatmentRecordControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentRecordControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentRecordControllerHash();

  @override
  String toString() {
    return r'patientTreatmentRecordControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTreatmentRecordController create() =>
      PatientTreatmentRecordController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentRecordControllerHash() =>
    r'cc1e571cd57f153a5e92d1453d5673be445fe0ea';

final class PatientTreatmentRecordControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentRecordController,
            AsyncValue<PatientTreatmentRecordState>,
            PatientTreatmentRecordState,
            FutureOr<PatientTreatmentRecordState>,
            String> {
  PatientTreatmentRecordControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentRecordControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTreatmentRecordControllerProvider call(
    String id,
  ) =>
      PatientTreatmentRecordControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientTreatmentRecordControllerProvider';
}

abstract class _$PatientTreatmentRecordController
    extends $AsyncNotifier<PatientTreatmentRecordState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<PatientTreatmentRecordState> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientTreatmentRecordState>,
        PatientTreatmentRecordState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientTreatmentRecordState>,
            PatientTreatmentRecordState>,
        AsyncValue<PatientTreatmentRecordState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
