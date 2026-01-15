// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the patient treatment repository.

@ProviderFor(patientTreatmentRepository)
final patientTreatmentRepositoryProvider =
    PatientTreatmentRepositoryProvider._();

/// Provider for the patient treatment repository.

final class PatientTreatmentRepositoryProvider extends $FunctionalProvider<
    PatientTreatmentRepository,
    PatientTreatmentRepository,
    PatientTreatmentRepository> with $Provider<PatientTreatmentRepository> {
  /// Provider for the patient treatment repository.
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
  $ProviderElement<PatientTreatmentRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PatientTreatmentRepository create(Ref ref) {
    return patientTreatmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatientTreatmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PatientTreatmentRepository>(value),
    );
  }
}

String _$patientTreatmentRepositoryHash() =>
    r'd735c185d2c1d471b32f80bc0c46713e5c388e1e';
