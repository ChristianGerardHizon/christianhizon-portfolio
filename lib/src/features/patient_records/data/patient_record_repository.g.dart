// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientRecordRepository)
final patientRecordRepositoryProvider = PatientRecordRepositoryProvider._();

final class PatientRecordRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<PatientRecord>,
        PBCollectionRepository<PatientRecord>,
        PBCollectionRepository<PatientRecord>>
    with $Provider<PBCollectionRepository<PatientRecord>> {
  PatientRecordRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientRecordRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<PatientRecord>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientRecord> create(Ref ref) {
    return patientRecordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<PatientRecord> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientRecord>>(value),
    );
  }
}

String _$patientRecordRepositoryHash() =>
    r'8da54c2b04938deca4cfc62223bed15b81e93e90';
