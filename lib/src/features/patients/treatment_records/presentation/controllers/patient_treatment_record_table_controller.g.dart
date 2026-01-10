// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentRecordTableController)
final patientTreatmentRecordTableControllerProvider =
    PatientTreatmentRecordTableControllerFamily._();

final class PatientTreatmentRecordTableControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentRecordTableController,
        List<PatientTreatmentRecord>> {
  PatientTreatmentRecordTableControllerProvider._(
      {required PatientTreatmentRecordTableControllerFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentRecordTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientTreatmentRecordTableControllerHash();

  @override
  String toString() {
    return r'patientTreatmentRecordTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientTreatmentRecordTableController create() =>
      PatientTreatmentRecordTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentRecordTableControllerHash() =>
    r'b13d4bbf3326dadf51227619fd482b58f5dff70c';

final class PatientTreatmentRecordTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentRecordTableController,
            AsyncValue<List<PatientTreatmentRecord>>,
            List<PatientTreatmentRecord>,
            FutureOr<List<PatientTreatmentRecord>>,
            (
              String,
              String,
            )> {
  PatientTreatmentRecordTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentRecordTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTreatmentRecordTableControllerProvider call(
    String tableKey,
    String patientId,
  ) =>
      PatientTreatmentRecordTableControllerProvider._(argument: (
        tableKey,
        patientId,
      ), from: this);

  @override
  String toString() => r'patientTreatmentRecordTableControllerProvider';
}

abstract class _$PatientTreatmentRecordTableController
    extends $AsyncNotifier<List<PatientTreatmentRecord>> {
  late final _$args = ref.$arg as (
    String,
    String,
  );
  String get tableKey => _$args.$1;
  String get patientId => _$args.$2;

  FutureOr<List<PatientTreatmentRecord>> build(
    String tableKey,
    String patientId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<PatientTreatmentRecord>>,
        List<PatientTreatmentRecord>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientTreatmentRecord>>,
            List<PatientTreatmentRecord>>,
        AsyncValue<List<PatientTreatmentRecord>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              _$args.$2,
            ));
  }
}
