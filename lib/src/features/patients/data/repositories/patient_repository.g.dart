// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the PatientRepository instance.

@ProviderFor(patientRepository)
final patientRepositoryProvider = PatientRepositoryProvider._();

/// Provides the PatientRepository instance.

final class PatientRepositoryProvider extends $FunctionalProvider<
    PatientRepository,
    PatientRepository,
    PatientRepository> with $Provider<PatientRepository> {
  /// Provides the PatientRepository instance.
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
  $ProviderElement<PatientRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PatientRepository create(Ref ref) {
    return patientRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatientRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PatientRepository>(value),
    );
  }
}

String _$patientRepositoryHash() => r'6e7ce9ccda4dfc3c02a52519e62c55ef4da1ee33';
