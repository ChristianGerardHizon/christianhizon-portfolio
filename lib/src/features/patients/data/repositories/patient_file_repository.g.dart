// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the PatientFileRepository instance.

@ProviderFor(patientFileRepository)
final patientFileRepositoryProvider = PatientFileRepositoryProvider._();

/// Provides the PatientFileRepository instance.

final class PatientFileRepositoryProvider extends $FunctionalProvider<
    PatientFileRepository,
    PatientFileRepository,
    PatientFileRepository> with $Provider<PatientFileRepository> {
  /// Provides the PatientFileRepository instance.
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
  $ProviderElement<PatientFileRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PatientFileRepository create(Ref ref) {
    return patientFileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatientFileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PatientFileRepository>(value),
    );
  }
}

String _$patientFileRepositoryHash() =>
    r'79ba1d5e9c91346a54026b44b4e7bec055cc3aed';
