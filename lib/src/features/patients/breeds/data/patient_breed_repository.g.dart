// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breed_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientBreedRepository)
final patientBreedRepositoryProvider = PatientBreedRepositoryProvider._();

final class PatientBreedRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<PatientBreed>,
        PBCollectionRepository<PatientBreed>,
        PBCollectionRepository<PatientBreed>>
    with $Provider<PBCollectionRepository<PatientBreed>> {
  PatientBreedRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientBreedRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientBreedRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<PatientBreed>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientBreed> create(Ref ref) {
    return patientBreedRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<PatientBreed> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientBreed>>(value),
    );
  }
}

String _$patientBreedRepositoryHash() =>
    r'935988c7f5f33b7cd0b7c4966ddb007f2e9a2f86';
