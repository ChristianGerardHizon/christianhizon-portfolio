// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientFileFormController)
final patientFileFormControllerProvider = PatientFileFormControllerFamily._();

final class PatientFileFormControllerProvider extends $AsyncNotifierProvider<
    PatientFileFormController, PatientFileFormState> {
  PatientFileFormControllerProvider._(
      {required PatientFileFormControllerFamily super.from,
      required ({
        String parentId,
        String? id,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientFileFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientFileFormControllerHash();

  @override
  String toString() {
    return r'patientFileFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientFileFormController create() => PatientFileFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientFileFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientFileFormControllerHash() =>
    r'689f65839eaf5a040240be93959633cbd80ffe1d';

final class PatientFileFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientFileFormController,
            AsyncValue<PatientFileFormState>,
            PatientFileFormState,
            FutureOr<PatientFileFormState>,
            ({
              String parentId,
              String? id,
            })> {
  PatientFileFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientFileFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientFileFormControllerProvider call({
    required String parentId,
    String? id,
  }) =>
      PatientFileFormControllerProvider._(argument: (
        parentId: parentId,
        id: id,
      ), from: this);

  @override
  String toString() => r'patientFileFormControllerProvider';
}

abstract class _$PatientFileFormController
    extends $AsyncNotifier<PatientFileFormState> {
  late final _$args = ref.$arg as ({
    String parentId,
    String? id,
  });
  String get parentId => _$args.parentId;
  String? get id => _$args.id;

  FutureOr<PatientFileFormState> build({
    required String parentId,
    String? id,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<PatientFileFormState>, PatientFileFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientFileFormState>, PatientFileFormState>,
        AsyncValue<PatientFileFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              parentId: _$args.parentId,
              id: _$args.id,
            ));
  }
}
