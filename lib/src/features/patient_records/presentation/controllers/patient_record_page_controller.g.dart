// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientRecordPageController)
final patientRecordPageControllerProvider =
    PatientRecordPageControllerFamily._();

final class PatientRecordPageControllerProvider extends $AsyncNotifierProvider<
    PatientRecordPageController, PatientRecordPageState> {
  PatientRecordPageControllerProvider._(
      {required PatientRecordPageControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientRecordPageControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordPageControllerHash();

  @override
  String toString() {
    return r'patientRecordPageControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientRecordPageController create() => PatientRecordPageController();

  @override
  bool operator ==(Object other) {
    return other is PatientRecordPageControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordPageControllerHash() =>
    r'02594c8f27239285b8fa89244b1c0d0d04c20247';

final class PatientRecordPageControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientRecordPageController,
            AsyncValue<PatientRecordPageState>,
            PatientRecordPageState,
            FutureOr<PatientRecordPageState>,
            String> {
  PatientRecordPageControllerFamily._()
      : super(
          retry: null,
          name: r'patientRecordPageControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientRecordPageControllerProvider call(
    String id,
  ) =>
      PatientRecordPageControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientRecordPageControllerProvider';
}

abstract class _$PatientRecordPageController
    extends $AsyncNotifier<PatientRecordPageState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<PatientRecordPageState> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<PatientRecordPageState>, PatientRecordPageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientRecordPageState>, PatientRecordPageState>,
        AsyncValue<PatientRecordPageState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
