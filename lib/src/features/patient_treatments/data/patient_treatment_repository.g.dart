// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientTreatmentRepository)
final patientTreatmentRepositoryProvider =
    PatientTreatmentRepositoryProvider._();

final class PatientTreatmentRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<PatientTreatment>,
        PBCollectionRepository<PatientTreatment>,
        PBCollectionRepository<PatientTreatment>>
    with $Provider<PBCollectionRepository<PatientTreatment>> {
  PatientTreatmentRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientTreatmentRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<PatientTreatment>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientTreatment> create(Ref ref) {
    return patientTreatmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<PatientTreatment> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientTreatment>>(value),
    );
  }
}

String _$patientTreatmentRepositoryHash() =>
    r'3f39e66c929f8ca6fd88440276971028f3a49e60';
