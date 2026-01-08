// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_item_group_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientPrescriptionItemGroupController)
final patientPrescriptionItemGroupControllerProvider =
    PatientPrescriptionItemGroupControllerFamily._();

final class PatientPrescriptionItemGroupControllerProvider
    extends $AsyncNotifierProvider<PatientPrescriptionItemGroupController,
        List<PatientPrescriptionItemGroupState>> {
  PatientPrescriptionItemGroupControllerProvider._(
      {required PatientPrescriptionItemGroupControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientPrescriptionItemGroupControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$patientPrescriptionItemGroupControllerHash();

  @override
  String toString() {
    return r'patientPrescriptionItemGroupControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientPrescriptionItemGroupController create() =>
      PatientPrescriptionItemGroupController();

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionItemGroupControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientPrescriptionItemGroupControllerHash() =>
    r'f274b1854a688f49219b1588d7cf68782cf9398e';

final class PatientPrescriptionItemGroupControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            PatientPrescriptionItemGroupController,
            AsyncValue<List<PatientPrescriptionItemGroupState>>,
            List<PatientPrescriptionItemGroupState>,
            FutureOr<List<PatientPrescriptionItemGroupState>>,
            String> {
  PatientPrescriptionItemGroupControllerFamily._()
      : super(
          retry: null,
          name: r'patientPrescriptionItemGroupControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientPrescriptionItemGroupControllerProvider call(
    String id,
  ) =>
      PatientPrescriptionItemGroupControllerProvider._(
          argument: id, from: this);

  @override
  String toString() => r'patientPrescriptionItemGroupControllerProvider';
}

abstract class _$PatientPrescriptionItemGroupController
    extends $AsyncNotifier<List<PatientPrescriptionItemGroupState>> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<List<PatientPrescriptionItemGroupState>> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<
        AsyncValue<List<PatientPrescriptionItemGroupState>>,
        List<PatientPrescriptionItemGroupState>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientPrescriptionItemGroupState>>,
            List<PatientPrescriptionItemGroupState>>,
        AsyncValue<List<PatientPrescriptionItemGroupState>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
