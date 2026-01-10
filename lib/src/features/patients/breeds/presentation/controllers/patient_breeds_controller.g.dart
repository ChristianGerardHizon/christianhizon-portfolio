// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breeds_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientBreedsController)
final patientBreedsControllerProvider = PatientBreedsControllerProvider._();

final class PatientBreedsControllerProvider extends $AsyncNotifierProvider<
    PatientBreedsController, List<PatientBreed>> {
  PatientBreedsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientBreedsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientBreedsControllerHash();

  @$internal
  @override
  PatientBreedsController create() => PatientBreedsController();
}

String _$patientBreedsControllerHash() =>
    r'aa23a73a3986a878504b73606085b713b5711e7f';

abstract class _$PatientBreedsController
    extends $AsyncNotifier<List<PatientBreed>> {
  FutureOr<List<PatientBreed>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PatientBreed>>, List<PatientBreed>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientBreed>>, List<PatientBreed>>,
        AsyncValue<List<PatientBreed>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
