// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientSpeciesTableController)
final patientSpeciesTableControllerProvider =
    PatientSpeciesTableControllerFamily._();

final class PatientSpeciesTableControllerProvider
    extends $AsyncNotifierProvider<PatientSpeciesTableController,
        List<PatientSpecies>> {
  PatientSpeciesTableControllerProvider._(
      {required PatientSpeciesTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientSpeciesTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSpeciesTableControllerHash();

  @override
  String toString() {
    return r'patientSpeciesTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientSpeciesTableController create() => PatientSpeciesTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientSpeciesTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientSpeciesTableControllerHash() =>
    r'36b60f4acec8243e5be23f0c0f8fcc36116a382a';

final class PatientSpeciesTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientSpeciesTableController,
            AsyncValue<List<PatientSpecies>>,
            List<PatientSpecies>,
            FutureOr<List<PatientSpecies>>,
            String> {
  PatientSpeciesTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientSpeciesTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientSpeciesTableControllerProvider call(
    String tableKey,
  ) =>
      PatientSpeciesTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'patientSpeciesTableControllerProvider';
}

abstract class _$PatientSpeciesTableController
    extends $AsyncNotifier<List<PatientSpecies>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<PatientSpecies>> build(
    String tableKey,
  );
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
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
