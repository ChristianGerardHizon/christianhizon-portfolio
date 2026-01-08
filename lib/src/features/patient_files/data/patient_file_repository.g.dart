// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientFileRepository)
final patientFileRepositoryProvider = PatientFileRepositoryProvider._();

final class PatientFileRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<PatientFile>,
        PBCollectionRepository<PatientFile>,
        PBCollectionRepository<PatientFile>>
    with $Provider<PBCollectionRepository<PatientFile>> {
  PatientFileRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientFileRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientFileRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<PatientFile>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientFile> create(Ref ref) {
    return patientFileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<PatientFile> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientFile>>(value),
    );
  }
}

String _$patientFileRepositoryHash() =>
    r'9102cb830cc3a46e3bee231164ec8f4ff24e43d4';
