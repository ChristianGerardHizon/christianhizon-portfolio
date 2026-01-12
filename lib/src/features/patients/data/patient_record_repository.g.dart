// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the patient record repository.

@ProviderFor(patientRecordRepository)
final patientRecordRepositoryProvider = PatientRecordRepositoryProvider._();

/// Provider for the patient record repository.

final class PatientRecordRepositoryProvider extends $FunctionalProvider<
    PatientRecordRepository,
    PatientRecordRepository,
    PatientRecordRepository> with $Provider<PatientRecordRepository> {
  /// Provider for the patient record repository.
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
  $ProviderElement<PatientRecordRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PatientRecordRepository create(Ref ref) {
    return patientRecordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatientRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PatientRecordRepository>(value),
    );
  }
}

String _$patientRecordRepositoryHash() =>
    r'556428196793078dd7f2d8c8a2158d66ebc0326a';
