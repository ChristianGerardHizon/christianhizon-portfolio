// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.

@ProviderFor(PatientsController)
final patientsControllerProvider = PatientsControllerProvider._();

/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.
final class PatientsControllerProvider
    extends $AsyncNotifierProvider<PatientsController, List<Patient>> {
  /// Controller for managing patient list state.
  ///
  /// Provides methods for fetching, searching, and CRUD operations on patients.
  PatientsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientsControllerHash();

  @$internal
  @override
  PatientsController create() => PatientsController();
}

String _$patientsControllerHash() =>
    r'7bc840f94971ebe6d53cdce08cc6c226ded40d5d';

/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.

abstract class _$PatientsController extends $AsyncNotifier<List<Patient>> {
  FutureOr<List<Patient>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Patient>>, List<Patient>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Patient>>, List<Patient>>,
        AsyncValue<List<Patient>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
