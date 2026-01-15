// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_records_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment records state.

@ProviderFor(PatientTreatmentRecordsController)
final patientTreatmentRecordsControllerProvider =
    PatientTreatmentRecordsControllerFamily._();

/// Controller for managing treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment records state.
final class PatientTreatmentRecordsControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentRecordsController,
        List<PatientTreatmentRecord>> {
  /// Controller for managing treatment records for a specific patient.
  ///
  /// This is a family provider - each patient has its own treatment records state.
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
    r'c76a5cb5b5c77e354cc07fa53d44734bca6e1b3e';

/// Controller for managing treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment records state.

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

  /// Controller for managing treatment records for a specific patient.
  ///
  /// This is a family provider - each patient has its own treatment records state.

  PatientTreatmentRecordsControllerProvider call(
    String patientId,
  ) =>
      PatientTreatmentRecordsControllerProvider._(
          argument: patientId, from: this);

  @override
  String toString() => r'patientTreatmentRecordsControllerProvider';
}

/// Controller for managing treatment records for a specific patient.
///
/// This is a family provider - each patient has its own treatment records state.

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

/// Provider for a single treatment record by ID.

@ProviderFor(patientTreatmentRecord)
final patientTreatmentRecordProvider = PatientTreatmentRecordFamily._();

/// Provider for a single treatment record by ID.

final class PatientTreatmentRecordProvider extends $FunctionalProvider<
        AsyncValue<PatientTreatmentRecord?>,
        PatientTreatmentRecord?,
        FutureOr<PatientTreatmentRecord?>>
    with
        $FutureModifier<PatientTreatmentRecord?>,
        $FutureProvider<PatientTreatmentRecord?> {
  /// Provider for a single treatment record by ID.
  PatientTreatmentRecordProvider._(
      {required PatientTreatmentRecordFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentRecordProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentRecordHash();

  @override
  String toString() {
    return r'patientTreatmentRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PatientTreatmentRecord?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PatientTreatmentRecord?> create(Ref ref) {
    final argument = this.argument as String;
    return patientTreatmentRecord(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentRecordHash() =>
    r'b2fd18fc0a7824e56ebe5fe2fd20cc97e2e23d93';

/// Provider for a single treatment record by ID.

final class PatientTreatmentRecordFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PatientTreatmentRecord?>, String> {
  PatientTreatmentRecordFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentRecordProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single treatment record by ID.

  PatientTreatmentRecordProvider call(
    String id,
  ) =>
      PatientTreatmentRecordProvider._(argument: id, from: this);

  @override
  String toString() => r'patientTreatmentRecordProvider';
}
