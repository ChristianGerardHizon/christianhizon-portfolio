// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientRecordController)
final patientRecordControllerProvider = PatientRecordControllerFamily._();

final class PatientRecordControllerProvider
    extends $AsyncNotifierProvider<PatientRecordController, PatientRecord> {
  PatientRecordControllerProvider._(
      {required PatientRecordControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientRecordControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordControllerHash();

  @override
  String toString() {
    return r'patientRecordControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientRecordController create() => PatientRecordController();

  @override
  bool operator ==(Object other) {
    return other is PatientRecordControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordControllerHash() =>
    r'af769bc294bdeed07d037f64005ff93184510da0';

final class PatientRecordControllerFamily extends $Family
    with
        $ClassFamilyOverride<PatientRecordController, AsyncValue<PatientRecord>,
            PatientRecord, FutureOr<PatientRecord>, String> {
  PatientRecordControllerFamily._()
      : super(
          retry: null,
          name: r'patientRecordControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientRecordControllerProvider call(
    String id,
  ) =>
      PatientRecordControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientRecordControllerProvider';
}

abstract class _$PatientRecordController extends $AsyncNotifier<PatientRecord> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<PatientRecord> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientRecord>, PatientRecord>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientRecord>, PatientRecord>,
        AsyncValue<PatientRecord>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
