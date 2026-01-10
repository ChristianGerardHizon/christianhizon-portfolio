// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientRepository)
final patientRepositoryProvider = PatientRepositoryProvider._();

final class PatientRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<Patient>,
        PBCollectionRepository<Patient>,
        PBCollectionRepository<Patient>>
    with $Provider<PBCollectionRepository<Patient>> {
  PatientRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<Patient>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<Patient> create(Ref ref) {
    return patientRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<Patient> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<Patient>>(value),
    );
  }
}

String _$patientRepositoryHash() => r'be6b36b76053c33c261bc41b4ae7232d78eef69b';
