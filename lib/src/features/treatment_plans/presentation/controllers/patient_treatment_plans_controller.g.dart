// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_plans_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing treatment plans for a specific patient.
///
/// This is a family provider - each patient has its own treatment plans state.

@ProviderFor(PatientTreatmentPlansController)
final patientTreatmentPlansControllerProvider =
    PatientTreatmentPlansControllerFamily._();

/// Controller for managing treatment plans for a specific patient.
///
/// This is a family provider - each patient has its own treatment plans state.
final class PatientTreatmentPlansControllerProvider
    extends $AsyncNotifierProvider<PatientTreatmentPlansController,
        List<TreatmentPlan>> {
  /// Controller for managing treatment plans for a specific patient.
  ///
  /// This is a family provider - each patient has its own treatment plans state.
  PatientTreatmentPlansControllerProvider._(
      {required PatientTreatmentPlansControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTreatmentPlansControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTreatmentPlansControllerHash();

  @override
  String toString() {
    return r'patientTreatmentPlansControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTreatmentPlansController create() => PatientTreatmentPlansController();

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentPlansControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTreatmentPlansControllerHash() =>
    r'40d957f2abbabe275c0797d3d27b39bba8583761';

/// Controller for managing treatment plans for a specific patient.
///
/// This is a family provider - each patient has its own treatment plans state.

final class PatientTreatmentPlansControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientTreatmentPlansController,
            AsyncValue<List<TreatmentPlan>>,
            List<TreatmentPlan>,
            FutureOr<List<TreatmentPlan>>,
            String> {
  PatientTreatmentPlansControllerFamily._()
      : super(
          retry: null,
          name: r'patientTreatmentPlansControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing treatment plans for a specific patient.
  ///
  /// This is a family provider - each patient has its own treatment plans state.

  PatientTreatmentPlansControllerProvider call(
    String patientId,
  ) =>
      PatientTreatmentPlansControllerProvider._(
          argument: patientId, from: this);

  @override
  String toString() => r'patientTreatmentPlansControllerProvider';
}

/// Controller for managing treatment plans for a specific patient.
///
/// This is a family provider - each patient has its own treatment plans state.

abstract class _$PatientTreatmentPlansController
    extends $AsyncNotifier<List<TreatmentPlan>> {
  late final _$args = ref.$arg as String;
  String get patientId => _$args;

  FutureOr<List<TreatmentPlan>> build(
    String patientId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TreatmentPlan>>, List<TreatmentPlan>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TreatmentPlan>>, List<TreatmentPlan>>,
        AsyncValue<List<TreatmentPlan>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

/// Provider for fetching only active treatment plans for a patient.

@ProviderFor(activePatientTreatmentPlans)
final activePatientTreatmentPlansProvider =
    ActivePatientTreatmentPlansFamily._();

/// Provider for fetching only active treatment plans for a patient.

final class ActivePatientTreatmentPlansProvider extends $FunctionalProvider<
        AsyncValue<List<TreatmentPlan>>,
        List<TreatmentPlan>,
        FutureOr<List<TreatmentPlan>>>
    with
        $FutureModifier<List<TreatmentPlan>>,
        $FutureProvider<List<TreatmentPlan>> {
  /// Provider for fetching only active treatment plans for a patient.
  ActivePatientTreatmentPlansProvider._(
      {required ActivePatientTreatmentPlansFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'activePatientTreatmentPlansProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activePatientTreatmentPlansHash();

  @override
  String toString() {
    return r'activePatientTreatmentPlansProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TreatmentPlan>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<TreatmentPlan>> create(Ref ref) {
    final argument = this.argument as String;
    return activePatientTreatmentPlans(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivePatientTreatmentPlansProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activePatientTreatmentPlansHash() =>
    r'0f90a2021eade9f47ca27a0ee841c66d0534a09b';

/// Provider for fetching only active treatment plans for a patient.

final class ActivePatientTreatmentPlansFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TreatmentPlan>>, String> {
  ActivePatientTreatmentPlansFamily._()
      : super(
          retry: null,
          name: r'activePatientTreatmentPlansProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching only active treatment plans for a patient.

  ActivePatientTreatmentPlansProvider call(
    String patientId,
  ) =>
      ActivePatientTreatmentPlansProvider._(argument: patientId, from: this);

  @override
  String toString() => r'activePatientTreatmentPlansProvider';
}
