// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientTreatmentRecordRepository)
final patientTreatmentRecordRepositoryProvider =
    PatientTreatmentRecordRepositoryProvider._();

final class PatientTreatmentRecordRepositoryProvider
    extends $FunctionalProvider<
        PBCollectionRepository<PatientTreatmentRecord>,
        PBCollectionRepository<PatientTreatmentRecord>,
        PBCollectionRepository<PatientTreatmentRecord>>
    with $Provider<PBCollectionRepository<PatientTreatmentRecord>> {
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
  $ProviderElement<PBCollectionRepository<PatientTreatmentRecord>>
      $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientTreatmentRecord> create(Ref ref) {
    return patientTreatmentRecordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
      PBCollectionRepository<PatientTreatmentRecord> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientTreatmentRecord>>(
              value),
    );
  }
}

String _$patientTreatmentRecordRepositoryHash() =>
    r'41fa5d32aca67019c941eb70d724307f6ae2b3d1';
