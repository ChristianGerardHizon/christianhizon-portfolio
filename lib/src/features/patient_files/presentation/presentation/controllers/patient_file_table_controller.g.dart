// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientFileTableController)
final patientFileTableControllerProvider = PatientFileTableControllerFamily._();

final class PatientFileTableControllerProvider extends $AsyncNotifierProvider<
    PatientFileTableController, List<PatientFile>> {
  PatientFileTableControllerProvider._(
      {required PatientFileTableControllerFamily super.from,
      required (
        String, {
        String patientId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'patientFileTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientFileTableControllerHash();

  @override
  String toString() {
    return r'patientFileTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PatientFileTableController create() => PatientFileTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientFileTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientFileTableControllerHash() =>
    r'd9d0dcde59e636b9170faef295a420175ffe9d49';

final class PatientFileTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientFileTableController,
            AsyncValue<List<PatientFile>>,
            List<PatientFile>,
            FutureOr<List<PatientFile>>,
            (
              String, {
              String patientId,
            })> {
  PatientFileTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientFileTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientFileTableControllerProvider call(
    String tableKey, {
    required String patientId,
  }) =>
      PatientFileTableControllerProvider._(argument: (
        tableKey,
        patientId: patientId,
      ), from: this);

  @override
  String toString() => r'patientFileTableControllerProvider';
}

abstract class _$PatientFileTableController
    extends $AsyncNotifier<List<PatientFile>> {
  late final _$args = ref.$arg as (
    String, {
    String patientId,
  });
  String get tableKey => _$args.$1;
  String get patientId => _$args.patientId;

  FutureOr<List<PatientFile>> build(
    String tableKey, {
    required String patientId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PatientFile>>, List<PatientFile>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientFile>>, List<PatientFile>>,
        AsyncValue<List<PatientFile>>,
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
