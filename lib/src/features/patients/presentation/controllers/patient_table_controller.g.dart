// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientTableController)
final patientTableControllerProvider = PatientTableControllerFamily._();

final class PatientTableControllerProvider
    extends $AsyncNotifierProvider<PatientTableController, List<Patient>> {
  PatientTableControllerProvider._(
      {required PatientTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientTableControllerHash();

  @override
  String toString() {
    return r'patientTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientTableController create() => PatientTableController();

  @override
  bool operator ==(Object other) {
    return other is PatientTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientTableControllerHash() =>
    r'bb44c74706a1791ce1bec76baba940a2ee40039d';

final class PatientTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<PatientTableController, AsyncValue<List<Patient>>,
            List<Patient>, FutureOr<List<Patient>>, String> {
  PatientTableControllerFamily._()
      : super(
          retry: null,
          name: r'patientTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientTableControllerProvider call(
    String tableKey,
  ) =>
      PatientTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'patientTableControllerProvider';
}

abstract class _$PatientTableController extends $AsyncNotifier<List<Patient>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<Patient>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Patient>>, List<Patient>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Patient>>, List<Patient>>,
        AsyncValue<List<Patient>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
