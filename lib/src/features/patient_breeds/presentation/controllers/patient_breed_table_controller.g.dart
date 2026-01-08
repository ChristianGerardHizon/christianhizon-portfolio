// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breed_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientBreedTableController)
final patientBreedTableControllerProvider =
    PatientBreedTableControllerFamily._();

final class PatientBreedTableControllerProvider extends $AsyncNotifierProvider<
    PatientBreedTableController, List<PatientBreed>> {
  PatientBreedTableControllerProvider._(
      {required PatientBreedTableControllerFamily super.from,
      required (
        String, {
        String? patientSpeciesId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientBreedTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientBreedTableControllerHash();

  @override
  String toString() {
    return r'patientBreedTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientBreedTableController create() => PatientBreedTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientBreedTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientBreedTableControllerHash() =>
    r'2cd6670b1483f5ce79ee2e4a174c61046791b658';

final class PatientBreedTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientBreedTableController,
            AsyncValue<List<PatientBreed>>,
            List<PatientBreed>,
            FutureOr<List<PatientBreed>>,
            (
              String, {
              String? patientSpeciesId,
            })> {
  PatientBreedTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientBreedTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientBreedTableControllerProvider call(
    String tableKey, {
    String? patientSpeciesId,
  }) =>
      PatientBreedTableControllerProvider._(argument: (
        tableKey,
        patientSpeciesId: patientSpeciesId,
      ), from: this);

  @override
  String toString() => r'patientBreedTableControllerProvider';
}

abstract class _$PatientBreedTableController
    extends $AsyncNotifier<List<PatientBreed>> {
  late final _$args = ref.$arg as (
    String, {
    String? patientSpeciesId,
  });
  String get tableKey => _$args.$1;
  String? get patientSpeciesId => _$args.patientSpeciesId;

  FutureOr<List<PatientBreed>> build(
    String tableKey, {
    String? patientSpeciesId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PatientBreed>>, List<PatientBreed>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientBreed>>, List<PatientBreed>>,
        AsyncValue<List<PatientBreed>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              patientSpeciesId: _$args.patientSpeciesId,
            ));
  }
}
