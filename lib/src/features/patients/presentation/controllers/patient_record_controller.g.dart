// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.

@ProviderFor(PatientRecordController)
final patientRecordControllerProvider = PatientRecordControllerFamily._();

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.
final class PatientRecordControllerProvider extends $AsyncNotifierProvider<
    PatientRecordController, List<PatientRecord>> {
  /// Controller for managing patient records for a specific patient.
  ///
  /// This is a family provider - each patient has its own record list state.
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
    r'e0e9b94609f09b81422e827e8843301c3d7e5e9b';

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.

final class PatientRecordControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientRecordController,
            AsyncValue<List<PatientRecord>>,
            List<PatientRecord>,
            FutureOr<List<PatientRecord>>,
            String> {
  PatientRecordControllerFamily._()
      : super(
          retry: null,
          name: r'patientRecordControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing patient records for a specific patient.
  ///
  /// This is a family provider - each patient has its own record list state.

  PatientRecordControllerProvider call(
    String patientId,
  ) =>
      PatientRecordControllerProvider._(argument: patientId, from: this);

  @override
  String toString() => r'patientRecordControllerProvider';
}

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.

abstract class _$PatientRecordController
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

/// Provider for a single patient record by ID.

@ProviderFor(patientRecord)
final patientRecordProvider = PatientRecordFamily._();

/// Provider for a single patient record by ID.

final class PatientRecordProvider extends $FunctionalProvider<
        AsyncValue<PatientRecord?>, PatientRecord?, FutureOr<PatientRecord?>>
    with $FutureModifier<PatientRecord?>, $FutureProvider<PatientRecord?> {
  /// Provider for a single patient record by ID.
  PatientRecordProvider._(
      {required PatientRecordFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'patientRecordProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordHash();

  @override
  String toString() {
    return r'patientRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PatientRecord?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PatientRecord?> create(Ref ref) {
    final argument = this.argument as String;
    return patientRecord(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordHash() => r'66a25c6baf4f8624038ac7c9747505b26363efae';

/// Provider for a single patient record by ID.

final class PatientRecordFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PatientRecord?>, String> {
  PatientRecordFamily._()
      : super(
          retry: null,
          name: r'patientRecordProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single patient record by ID.

  PatientRecordProvider call(
    String id,
  ) =>
      PatientRecordProvider._(argument: id, from: this);

  @override
  String toString() => r'patientRecordProvider';
}
