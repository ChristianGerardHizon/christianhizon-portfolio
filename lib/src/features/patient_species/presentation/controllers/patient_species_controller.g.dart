// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientSpeciesController)
final patientSpeciesControllerProvider = PatientSpeciesControllerFamily._();

final class PatientSpeciesControllerProvider
    extends $AsyncNotifierProvider<PatientSpeciesController, PatientSpecies> {
  PatientSpeciesControllerProvider._(
      {required PatientSpeciesControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientSpeciesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSpeciesControllerHash();

  @override
  String toString() {
    return r'patientSpeciesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientSpeciesController create() => PatientSpeciesController();

  @override
  bool operator ==(Object other) {
    return other is PatientSpeciesControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientSpeciesControllerHash() =>
    r'fba4aec1076ab21aeb2eb574899398266befd463';

final class PatientSpeciesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientSpeciesController,
            AsyncValue<PatientSpecies>,
            PatientSpecies,
            FutureOr<PatientSpecies>,
            String> {
  PatientSpeciesControllerFamily._()
      : super(
          retry: null,
          name: r'patientSpeciesControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientSpeciesControllerProvider call(
    String id,
  ) =>
      PatientSpeciesControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientSpeciesControllerProvider';
}

abstract class _$PatientSpeciesController
    extends $AsyncNotifier<PatientSpecies> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<PatientSpecies> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientSpecies>, PatientSpecies>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientSpecies>, PatientSpecies>,
        AsyncValue<PatientSpecies>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
