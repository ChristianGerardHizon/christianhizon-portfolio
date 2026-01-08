// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_item_all_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientPrescriptionItemAllController)
final patientPrescriptionItemAllControllerProvider =
    PatientPrescriptionItemAllControllerProvider._();

final class PatientPrescriptionItemAllControllerProvider
    extends $AsyncNotifierProvider<PatientPrescriptionItemAllController,
        List<PatientPrescriptionItem>> {
  PatientPrescriptionItemAllControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientPrescriptionItemAllControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientPrescriptionItemAllControllerHash();

  @$internal
  @override
  PatientPrescriptionItemAllController create() =>
      PatientPrescriptionItemAllController();
}

String _$patientPrescriptionItemAllControllerHash() =>
    r'398fcb844ca35d16e863222199ba7443a01390ea';

abstract class _$PatientPrescriptionItemAllController
    extends $AsyncNotifier<List<PatientPrescriptionItem>> {
  FutureOr<List<PatientPrescriptionItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<PatientPrescriptionItem>>,
        List<PatientPrescriptionItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientPrescriptionItem>>,
            List<PatientPrescriptionItem>>,
        AsyncValue<List<PatientPrescriptionItem>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
