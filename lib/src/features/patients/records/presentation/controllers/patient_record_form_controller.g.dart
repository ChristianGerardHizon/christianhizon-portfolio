// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientRecordFormController)
final patientRecordFormControllerProvider =
    PatientRecordFormControllerFamily._();

final class PatientRecordFormControllerProvider extends $AsyncNotifierProvider<
    PatientRecordFormController, PatientRecordFormState> {
  PatientRecordFormControllerProvider._(
      {required PatientRecordFormControllerFamily super.from,
      required ({
        String? id,
        String patientId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientRecordFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordFormControllerHash();

  @override
  String toString() {
    return r'patientRecordFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientRecordFormController create() => PatientRecordFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientRecordFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordFormControllerHash() =>
    r'd9e02a2d439df381bfc7d655c12326c8281cf063';

final class PatientRecordFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientRecordFormController,
            AsyncValue<PatientRecordFormState>,
            PatientRecordFormState,
            FutureOr<PatientRecordFormState>,
            ({
              String? id,
              String patientId,
            })> {
  PatientRecordFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientRecordFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientRecordFormControllerProvider call({
    String? id,
    required String patientId,
  }) =>
      PatientRecordFormControllerProvider._(argument: (
        id: id,
        patientId: patientId,
      ), from: this);

  @override
  String toString() => r'patientRecordFormControllerProvider';
}

abstract class _$PatientRecordFormController
    extends $AsyncNotifier<PatientRecordFormState> {
  late final _$args = ref.$arg as ({
    String? id,
    String patientId,
  });
  String? get id => _$args.id;
  String get patientId => _$args.patientId;

  FutureOr<PatientRecordFormState> build({
    String? id,
    required String patientId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<PatientRecordFormState>, PatientRecordFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientRecordFormState>, PatientRecordFormState>,
        AsyncValue<PatientRecordFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              id: _$args.id,
              patientId: _$args.patientId,
            ));
  }
}
