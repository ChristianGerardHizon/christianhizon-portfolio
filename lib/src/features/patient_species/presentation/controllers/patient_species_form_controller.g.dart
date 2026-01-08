// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientSpeciesFormController)
final patientSpeciesFormControllerProvider =
    PatientSpeciesFormControllerFamily._();

final class PatientSpeciesFormControllerProvider extends $AsyncNotifierProvider<
    PatientSpeciesFormController, PatientSpeciesFormState> {
  PatientSpeciesFormControllerProvider._(
      {required PatientSpeciesFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'patientSpeciesFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSpeciesFormControllerHash();

  @override
  String toString() {
    return r'patientSpeciesFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientSpeciesFormController create() => PatientSpeciesFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientSpeciesFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientSpeciesFormControllerHash() =>
    r'fcd622d7a186d226123784645547854c2f511385';

final class PatientSpeciesFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientSpeciesFormController,
            AsyncValue<PatientSpeciesFormState>,
            PatientSpeciesFormState,
            FutureOr<PatientSpeciesFormState>,
            String?> {
  PatientSpeciesFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientSpeciesFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientSpeciesFormControllerProvider call(
    String? id,
  ) =>
      PatientSpeciesFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientSpeciesFormControllerProvider';
}

abstract class _$PatientSpeciesFormController
    extends $AsyncNotifier<PatientSpeciesFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<PatientSpeciesFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<PatientSpeciesFormState>, PatientSpeciesFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientSpeciesFormState>,
            PatientSpeciesFormState>,
        AsyncValue<PatientSpeciesFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
