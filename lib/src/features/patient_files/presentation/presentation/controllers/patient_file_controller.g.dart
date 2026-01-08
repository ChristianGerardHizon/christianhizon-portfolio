// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientFileController)
final patientFileControllerProvider = PatientFileControllerFamily._();

final class PatientFileControllerProvider
    extends $AsyncNotifierProvider<PatientFileController, PatientFile> {
  PatientFileControllerProvider._(
      {required PatientFileControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'patientFileControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientFileControllerHash();

  @override
  String toString() {
    return r'patientFileControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PatientFileController create() => PatientFileController();

  @override
  bool operator ==(Object other) {
    return other is PatientFileControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientFileControllerHash() =>
    r'9f15dddf8246c6c4b616a9a0a0edd0f0cabd1e9e';

final class PatientFileControllerFamily extends $Family
    with
        $ClassFamilyOverride<PatientFileController, AsyncValue<PatientFile>,
            PatientFile, FutureOr<PatientFile>, String> {
  PatientFileControllerFamily._()
      : super(
          retry: null,
          name: r'patientFileControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PatientFileControllerProvider call(
    String id,
  ) =>
      PatientFileControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'patientFileControllerProvider';
}

abstract class _$PatientFileController extends $AsyncNotifier<PatientFile> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<PatientFile> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PatientFile>, PatientFile>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PatientFile>, PatientFile>,
        AsyncValue<PatientFile>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
