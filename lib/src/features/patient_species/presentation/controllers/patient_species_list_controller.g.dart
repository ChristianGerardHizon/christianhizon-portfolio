// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientSpeciesListController)
final patientSpeciesListControllerProvider =
    PatientSpeciesListControllerProvider._();

final class PatientSpeciesListControllerProvider extends $AsyncNotifierProvider<
    PatientSpeciesListController, List<PatientSpecies>> {
  PatientSpeciesListControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientSpeciesListControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSpeciesListControllerHash();

  @$internal
  @override
  PatientSpeciesListController create() => PatientSpeciesListController();
}

String _$patientSpeciesListControllerHash() =>
    r'8e08c6e4c923b77c0ca0b66d6123ddfe5541131c';

abstract class _$PatientSpeciesListController
    extends $AsyncNotifier<List<PatientSpecies>> {
  FutureOr<List<PatientSpecies>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<PatientSpecies>>, List<PatientSpecies>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientSpecies>>, List<PatientSpecies>>,
        AsyncValue<List<PatientSpecies>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
