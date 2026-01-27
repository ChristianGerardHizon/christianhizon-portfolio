// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing the treatment catalog (list of all treatments).
///
/// This manages the list of treatment types available in the current branch.

@ProviderFor(PatientTreatmentsController)
final patientTreatmentsControllerProvider =
    PatientTreatmentsControllerProvider._();

/// Controller for managing the treatment catalog (list of all treatments).
///
/// This manages the list of treatment types available in the current branch.
final class PatientTreatmentsControllerProvider extends $AsyncNotifierProvider<
    PatientTreatmentsController, List<PatientTreatment>> {
  /// Controller for managing the treatment catalog (list of all treatments).
  ///
  /// This manages the list of treatment types available in the current branch.
  PatientTreatmentsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientTreatmentsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentsControllerHash();

  @$internal
  @override
  PatientTreatmentsController create() => PatientTreatmentsController();
}

String _$patientTreatmentsControllerHash() =>
    r'0e4490fa039dee747753c0bcc3407367ea17dac4';

/// Controller for managing the treatment catalog (list of all treatments).
///
/// This manages the list of treatment types available in the current branch.

abstract class _$PatientTreatmentsController
    extends $AsyncNotifier<List<PatientTreatment>> {
  FutureOr<List<PatientTreatment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<PatientTreatment>>, List<PatientTreatment>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientTreatment>>, List<PatientTreatment>>,
        AsyncValue<List<PatientTreatment>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for a single treatment by ID.

@ProviderFor(patientTreatment)
final patientTreatmentProvider = PatientTreatmentFamily._();

/// Provider for a single treatment by ID.

final class PatientTreatmentProvider extends $FunctionalProvider<
        AsyncValue<PatientTreatment?>,
        PatientTreatment?,
        FutureOr<PatientTreatment?>>
    with
        $FutureModifier<PatientTreatment?>,
        $FutureProvider<PatientTreatment?> {
  /// Provider for a single treatment by ID.
  PatientTreatmentProvider._(
      {required PatientTreatmentFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentHash();

  @override
  String toString() {
    return r'patientTreatmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PatientTreatment?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PatientTreatment?> create(Ref ref) {
    final argument = this.argument as String;
    return patientTreatment(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentHash() => r'c8b5a3a1b5a84e533b1dd6f1a2aa0d1ebcb44732';

/// Provider for a single treatment by ID.

final class PatientTreatmentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PatientTreatment?>, String> {
  PatientTreatmentFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single treatment by ID.

  PatientTreatmentProvider call(
    String id,
  ) =>
      PatientTreatmentProvider._(argument: id, from: this);

  @override
  String toString() => r'patientTreatmentProvider';
}
