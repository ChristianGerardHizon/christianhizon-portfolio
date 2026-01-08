// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breed_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientBreedFormController)
final patientBreedFormControllerProvider = PatientBreedFormControllerFamily._();

final class PatientBreedFormControllerProvider extends $AsyncNotifierProvider<
    PatientBreedFormController, PatientBreedFormState> {
  PatientBreedFormControllerProvider._(
      {required PatientBreedFormControllerFamily super.from,
      required (
        String?, {
        String? patientSpeciesId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientBreedFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientBreedFormControllerHash();

  @override
  String toString() {
    return r'patientBreedFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientBreedFormController create() => PatientBreedFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientBreedFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientBreedFormControllerHash() =>
    r'1dd8d4f2e389a1039346bb99a3d993fd1e41707e';

final class PatientBreedFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientBreedFormController,
            AsyncValue<PatientBreedFormState>,
            PatientBreedFormState,
            FutureOr<PatientBreedFormState>,
            (
              String?, {
              String? patientSpeciesId,
            })> {
  PatientBreedFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientBreedFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientBreedFormControllerProvider call(
    String? id, {
    String? patientSpeciesId,
  }) =>
      PatientBreedFormControllerProvider._(argument: (
        id,
        patientSpeciesId: patientSpeciesId,
      ), from: this);

  @override
  String toString() => r'patientBreedFormControllerProvider';
}

abstract class _$PatientBreedFormController
    extends $AsyncNotifier<PatientBreedFormState> {
  late final _$args = ref.$arg as (
    String?, {
    String? patientSpeciesId,
  });
  String? get id => _$args.$1;
  String? get patientSpeciesId => _$args.patientSpeciesId;

  FutureOr<PatientBreedFormState> build(
    String? id, {
    String? patientSpeciesId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<PatientBreedFormState>, PatientBreedFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientBreedFormState>, PatientBreedFormState>,
        AsyncValue<PatientBreedFormState>,
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
