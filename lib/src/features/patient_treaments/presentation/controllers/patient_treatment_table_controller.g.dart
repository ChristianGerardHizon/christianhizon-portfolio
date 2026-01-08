// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTreatmentTableController)
final patientTreatmentTableControllerProvider =
    PatientTreatmentTableControllerFamily._();

final class PatientTreatmentTableControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentTableController,
        List<PatientTreatment>> {
  PatientTreatmentTableControllerProvider._(
      {required PatientTreatmentTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentTableControllerHash();

  @override
  String toString() {
    return r'patientTreatmentTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTreatmentTableController create() => PatientTreatmentTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentTableControllerHash() =>
    r'77075e38b0dc4ff059114717ed68c16cf755042f';

final class PatientTreatmentTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentTableController,
            AsyncValue<List<PatientTreatment>>,
            List<PatientTreatment>,
            FutureOr<List<PatientTreatment>>,
            String> {
  PatientTreatmentTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTreatmentTableControllerProvider call(
    String tableKey,
  ) =>
      PatientTreatmentTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'patientTreatmentTableControllerProvider';
}

abstract class _$PatientTreatmentTableController
    extends $AsyncNotifier<List<PatientTreatment>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<PatientTreatment>> build(
    String tableKey,
  );
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
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
