// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_records_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.

@ProviderFor(PatientRecordsController)
final patientRecordsControllerProvider = PatientRecordsControllerFamily._();

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.
final class PatientRecordsControllerProvider extends $AsyncNotifierProvider<
    PatientRecordsController, List<PatientRecord>> {
  /// Controller for managing patient records for a specific patient.
  ///
  /// This is a family provider - each patient has its own record list state.
  PatientRecordsControllerProvider._(
      {required PatientRecordsControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientRecordsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordsControllerHash();

  @override
  String toString() {
    return r'patientRecordsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientRecordsController create() => PatientRecordsController();

  @override
  bool operator ==(Object other) {
    return other is PatientRecordsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordsControllerHash() =>
    r'b296e9295a197089dcaa3dabc942f1188a1d6dbe';

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.

final class PatientRecordsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientRecordsController,
            AsyncValue<List<PatientRecord>>,
            List<PatientRecord>,
            FutureOr<List<PatientRecord>>,
            String> {
  PatientRecordsControllerFamily._()
      : super(
          retry: null,
          name: r'patientRecordsControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing patient records for a specific patient.
  ///
  /// This is a family provider - each patient has its own record list state.

  PatientRecordsControllerProvider call(
    String patientId,
  ) =>
      PatientRecordsControllerProvider._(argument: patientId, from: this);

  @override
  String toString() => r'patientRecordsControllerProvider';
}

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.

abstract class _$PatientRecordsController
    extends $AsyncNotifier<List<PatientRecord>> {
  late final _$args = ref.$arg as String;
  String get patientId => _$args;

  FutureOr<List<PatientRecord>> build(
    String patientId,
  );
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
              _$args,
            ));
  }
}
