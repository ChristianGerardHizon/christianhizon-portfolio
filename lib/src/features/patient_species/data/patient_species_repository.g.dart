// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientSpeciesRepository)
final patientSpeciesRepositoryProvider = PatientSpeciesRepositoryProvider._();

final class PatientSpeciesRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<PatientSpecies>,
        PBCollectionRepository<PatientSpecies>,
        PBCollectionRepository<PatientSpecies>>
    with $Provider<PBCollectionRepository<PatientSpecies>> {
  PatientSpeciesRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientSpeciesRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSpeciesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<PatientSpecies>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientSpecies> create(Ref ref) {
    return patientSpeciesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<PatientSpecies> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientSpecies>>(value),
    );
  }
}

String _$patientSpeciesRepositoryHash() =>
    r'944b57a2f50eaa77b7ccf18e6031c776ec9c053d';
