// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing prescriptions for a specific patient record.
///
/// This is a family provider - each record has its own prescription list state.

@ProviderFor(PrescriptionController)
final prescriptionControllerProvider = PrescriptionControllerFamily._();

/// Controller for managing prescriptions for a specific patient record.
///
/// This is a family provider - each record has its own prescription list state.
final class PrescriptionControllerProvider
    extends $AsyncNotifierProvider<PrescriptionController, List<Prescription>> {
  /// Controller for managing prescriptions for a specific patient record.
  ///
  /// This is a family provider - each record has its own prescription list state.
  PrescriptionControllerProvider._(
      {required PrescriptionControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'prescriptionControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$prescriptionControllerHash();

  @override
  String toString() {
    return r'prescriptionControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PrescriptionController create() => PrescriptionController();

  @override
  bool operator ==(Object other) {
    return other is PrescriptionControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$prescriptionControllerHash() =>
    r'9241fb8b92ae1d594ba8a4dc8f1b066715574b01';

/// Controller for managing prescriptions for a specific patient record.
///
/// This is a family provider - each record has its own prescription list state.

final class PrescriptionControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PrescriptionController,
            AsyncValue<List<Prescription>>,
            List<Prescription>,
            FutureOr<List<Prescription>>,
            String> {
  PrescriptionControllerFamily._()
      : super(
          retry: null,
          name: r'prescriptionControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing prescriptions for a specific patient record.
  ///
  /// This is a family provider - each record has its own prescription list state.

  PrescriptionControllerProvider call(
    String recordId,
  ) =>
      PrescriptionControllerProvider._(argument: recordId, from: this);

  @override
  String toString() => r'prescriptionControllerProvider';
}

/// Controller for managing prescriptions for a specific patient record.
///
/// This is a family provider - each record has its own prescription list state.

abstract class _$PrescriptionController
    extends $AsyncNotifier<List<Prescription>> {
  late final _$args = ref.$arg as String;
  String get recordId => _$args;

  FutureOr<List<Prescription>> build(
    String recordId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Prescription>>, List<Prescription>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Prescription>>, List<Prescription>>,
        AsyncValue<List<Prescription>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

/// Provider for a single prescription by ID.

@ProviderFor(prescription)
final prescriptionProvider = PrescriptionFamily._();

/// Provider for a single prescription by ID.

final class PrescriptionProvider extends $FunctionalProvider<
        AsyncValue<Prescription?>, Prescription?, FutureOr<Prescription?>>
    with $FutureModifier<Prescription?>, $FutureProvider<Prescription?> {
  /// Provider for a single prescription by ID.
  PrescriptionProvider._(
      {required PrescriptionFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'prescriptionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$prescriptionHash();

  @override
  String toString() {
    return r'prescriptionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Prescription?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Prescription?> create(Ref ref) {
    final argument = this.argument as String;
    return prescription(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PrescriptionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$prescriptionHash() => r'b42b0e409f7778d2b30de3f83af33d3ad3d84569';

/// Provider for a single prescription by ID.

final class PrescriptionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Prescription?>, String> {
  PrescriptionFamily._()
      : super(
          retry: null,
          name: r'prescriptionProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single prescription by ID.

  PrescriptionProvider call(
    String id,
  ) =>
      PrescriptionProvider._(argument: id, from: this);

  @override
  String toString() => r'prescriptionProvider';
}
