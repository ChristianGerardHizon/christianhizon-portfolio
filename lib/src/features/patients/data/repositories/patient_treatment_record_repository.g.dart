// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the patient treatment record repository.

@ProviderFor(patientTreatmentRecordRepository)
final patientTreatmentRecordRepositoryProvider =
    PatientTreatmentRecordRepositoryProvider._();

/// Provider for the patient treatment record repository.

final class PatientTreatmentRecordRepositoryProvider
    extends $FunctionalProvider<PatientTreatmentRecordRepository,
        PatientTreatmentRecordRepository, PatientTreatmentRecordRepository>
    with $Provider<PatientTreatmentRecordRepository> {
  /// Provider for the patient treatment record repository.
  PatientTreatmentRecordRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientTreatmentRecordRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentRecordRepositoryHash();

  @$internal
  @override
  $ProviderElement<PatientTreatmentRecordRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PatientTreatmentRecordRepository create(Ref ref) {
    return patientTreatmentRecordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatientTreatmentRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PatientTreatmentRecordRepository>(value),
    );
  }
}

String _$patientTreatmentRecordRepositoryHash() =>
    r'787984c17a72eeceb195547ac8925da9006ae35a';
