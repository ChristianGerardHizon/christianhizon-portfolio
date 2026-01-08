// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientFormController)
final patientFormControllerProvider = PatientFormControllerFamily._();

final class PatientFormControllerProvider
    extends $AsyncNotifierProvider<PatientFormController, PatientFormState> {
  PatientFormControllerProvider._(
      {required PatientFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'patientFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientFormControllerHash();

  @override
  String toString() {
    return r'patientFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientFormController create() => PatientFormController();

  @override
  bool operator ==(Object other) {
    return other is PatientFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientFormControllerHash() =>
    r'd582433169d45bb0620269bf27fb1b6f4e2f01ca';

final class PatientFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientFormController,
            AsyncValue<PatientFormState>,
            PatientFormState,
            FutureOr<PatientFormState>,
            String?> {
  PatientFormControllerFamily._()
      : super(
          retry: null,
          name: r'patientFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientFormControllerProvider call(
    String? id,
  ) =>
      PatientFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientFormControllerProvider';
}

abstract class _$PatientFormController
    extends $AsyncNotifier<PatientFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<PatientFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PatientFormState>, PatientFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientFormState>, PatientFormState>,
        AsyncValue<PatientFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
