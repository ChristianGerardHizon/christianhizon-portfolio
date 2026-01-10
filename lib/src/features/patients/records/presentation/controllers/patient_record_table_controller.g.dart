// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientRecordTableController)
final patientRecordTableControllerProvider =
    PatientRecordTableControllerFamily._();

final class PatientRecordTableControllerProvider extends $AsyncNotifierProvider<
    PatientRecordTableController, List<PatientRecord>> {
  PatientRecordTableControllerProvider._(
      {required PatientRecordTableControllerFamily super.from,
      required (
        String, {
        String? patientId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientRecordTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordTableControllerHash();

  @override
  String toString() {
    return r'patientRecordTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientRecordTableController create() => PatientRecordTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientRecordTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordTableControllerHash() =>
    r'919cca69bf79e8d79c69c406eb433204efe6c0d1';

final class PatientRecordTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientRecordTableController,
            AsyncValue<List<PatientRecord>>,
            List<PatientRecord>,
            FutureOr<List<PatientRecord>>,
            (
              String, {
              String? patientId,
            })> {
  PatientRecordTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientRecordTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientRecordTableControllerProvider call(
    String tableKey, {
    String? patientId,
  }) =>
      PatientRecordTableControllerProvider._(argument: (
        tableKey,
        patientId: patientId,
      ), from: this);

  @override
  String toString() => r'patientRecordTableControllerProvider';
}

abstract class _$PatientRecordTableController
    extends $AsyncNotifier<List<PatientRecord>> {
  late final _$args = ref.$arg as (
    String, {
    String? patientId,
  });
  String get tableKey => _$args.$1;
  String? get patientId => _$args.patientId;

  FutureOr<List<PatientRecord>> build(
    String tableKey, {
    String? patientId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PatientRecord>>, List<PatientRecord>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientRecord>>, List<PatientRecord>>,
        AsyncValue<List<PatientRecord>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              patientId: _$args.patientId,
            ));
  }
}
