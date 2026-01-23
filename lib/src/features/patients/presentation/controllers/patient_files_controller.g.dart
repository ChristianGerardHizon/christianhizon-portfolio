// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_files_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing patient files for a specific patient.
///
/// This is a family provider - each patient has its own files list state.

@ProviderFor(PatientFilesController)
final patientFilesControllerProvider = PatientFilesControllerFamily._();

/// Controller for managing patient files for a specific patient.
///
/// This is a family provider - each patient has its own files list state.
final class PatientFilesControllerProvider
    extends $AsyncNotifierProvider<PatientFilesController, List<PatientFile>> {
  /// Controller for managing patient files for a specific patient.
  ///
  /// This is a family provider - each patient has its own files list state.
  PatientFilesControllerProvider._(
      {required PatientFilesControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientFilesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientFilesControllerHash();

  @override
  String toString() {
    return r'patientFilesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientFilesController create() => PatientFilesController();

  @override
  bool operator ==(Object other) {
    return other is PatientFilesControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientFilesControllerHash() =>
    r'2e31327464baa4fc7de8f859d7a74ee25ee0bf8f';

/// Controller for managing patient files for a specific patient.
///
/// This is a family provider - each patient has its own files list state.

final class PatientFilesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientFilesController,
            AsyncValue<List<PatientFile>>,
            List<PatientFile>,
            FutureOr<List<PatientFile>>,
            String> {
  PatientFilesControllerFamily._()
      : super(
          retry: null,
          name: r'patientFilesControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing patient files for a specific patient.
  ///
  /// This is a family provider - each patient has its own files list state.

  PatientFilesControllerProvider call(
    String patientId,
  ) =>
      PatientFilesControllerProvider._(argument: patientId, from: this);

  @override
  String toString() => r'patientFilesControllerProvider';
}

/// Controller for managing patient files for a specific patient.
///
/// This is a family provider - each patient has its own files list state.

abstract class _$PatientFilesController
    extends $AsyncNotifier<List<PatientFile>> {
  late final _$args = ref.$arg as String;
  String get patientId => _$args;

  FutureOr<List<PatientFile>> build(
    String patientId,
  );
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
              _$args,
            ));
  }
}
