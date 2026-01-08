// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_item_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientPrescriptionItemRepository)
final patientPrescriptionItemRepositoryProvider =
    PatientPrescriptionItemRepositoryProvider._();

final class PatientPrescriptionItemRepositoryProvider
    extends $FunctionalProvider<
        PBCollectionRepository<PatientPrescriptionItem>,
        PBCollectionRepository<PatientPrescriptionItem>,
        PBCollectionRepository<PatientPrescriptionItem>>
    with $Provider<PBCollectionRepository<PatientPrescriptionItem>> {
  PatientPrescriptionItemRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientPrescriptionItemRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientPrescriptionItemRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<PatientPrescriptionItem>>
      $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  PBCollectionRepository<PatientPrescriptionItem> create(Ref ref) {
    return patientPrescriptionItemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
      PBCollectionRepository<PatientPrescriptionItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<PatientPrescriptionItem>>(
              value),
    );
  }
}

String _$patientPrescriptionItemRepositoryHash() =>
    r'baf36fc602add187321f1e456e37cd3d2fcee5d4';
