// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_records_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing patient treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment record list state.

@ProviderFor(PatientTreatmentRecordsController)
final patientTreatmentRecordsControllerProvider =
    PatientTreatmentRecordsControllerFamily._();

/// Controller for managing patient treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment record list state.
final class PatientTreatmentRecordsControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentRecordsController,
        List<PatientTreatmentRecord>> {
  /// Controller for managing patient treatment records for a specific patient.
  ///
  /// This is a family provider - each patient has its own treatment record list state.
  PatientTreatmentRecordsControllerProvider._(
      {required PatientTreatmentRecordsControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentRecordsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientTreatmentRecordsControllerHash();

  @override
  String toString() {
    return r'patientTreatmentRecordsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTreatmentRecordsController create() =>
      PatientTreatmentRecordsController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentRecordsControllerHash() =>
    r'a283ebc8372f12e292be26ff5872a43c65ce7574';

/// Controller for managing patient treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment record list state.

final class PatientTreatmentRecordsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentRecordsController,
            AsyncValue<List<PatientTreatmentRecord>>,
            List<PatientTreatmentRecord>,
            FutureOr<List<PatientTreatmentRecord>>,
            String> {
  PatientTreatmentRecordsControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentRecordsControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing patient treatment records for a specific patient.
  ///
  /// This is a family provider - each patient has its own treatment record list state.

  PatientTreatmentRecordsControllerProvider call(
    String patientId,
  ) =>
      PatientTreatmentRecordsControllerProvider._(
          argument: patientId, from: this);

  @override
  String toString() => r'patientTreatmentRecordsControllerProvider';
}

/// Controller for managing patient treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment record list state.

abstract class _$PatientTreatmentRecordsController
    extends $AsyncNotifier<List<PatientTreatmentRecord>> {
  late final _$args = ref.$arg as String;
  String get patientId => _$args;

  FutureOr<List<PatientTreatmentRecord>> build(
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
              _$args,
            ));
  }
}
