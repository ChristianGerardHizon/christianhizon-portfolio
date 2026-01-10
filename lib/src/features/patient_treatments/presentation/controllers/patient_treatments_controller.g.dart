// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentsController)
final patientTreatmentsControllerProvider =
    PatientTreatmentsControllerProvider._();

final class PatientTreatmentsControllerProvider extends $AsyncNotifierProvider<
    PatientTreatmentsController, List<PatientTreatment>> {
  PatientTreatmentsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientTreatmentsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentsControllerHash();

  @$internal
  @override
  PatientTreatmentsController create() => PatientTreatmentsController();
}

String _$patientTreatmentsControllerHash() =>
    r'8350793ee02ac6bb7454a06f4367d2475216d385';

abstract class _$PatientTreatmentsController
    extends $AsyncNotifier<List<PatientTreatment>> {
  FutureOr<List<PatientTreatment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<PatientTreatment>>, List<PatientTreatment>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientTreatment>>, List<PatientTreatment>>,
        AsyncValue<List<PatientTreatment>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
