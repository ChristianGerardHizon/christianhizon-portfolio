// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing species list state.
///
/// Provides methods for fetching and CRUD operations on species.

@ProviderFor(SpeciesController)
final speciesControllerProvider = SpeciesControllerProvider._();

/// Controller for managing species list state.
///
/// Provides methods for fetching and CRUD operations on species.
final class SpeciesControllerProvider
    extends $AsyncNotifierProvider<SpeciesController, List<PatientSpecies>> {
  /// Controller for managing species list state.
  ///
  /// Provides methods for fetching and CRUD operations on species.
  SpeciesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'speciesControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$speciesControllerHash();

  @$internal
  @override
  SpeciesController create() => SpeciesController();
}

String _$speciesControllerHash() => r'042d7c3163904fb840f74b2969e5560eac43d360';

/// Controller for managing species list state.
///
/// Provides methods for fetching and CRUD operations on species.

abstract class _$SpeciesController
    extends $AsyncNotifier<List<PatientSpecies>> {
  FutureOr<List<PatientSpecies>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<PatientSpecies>>, List<PatientSpecies>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PatientSpecies>>, List<PatientSpecies>>,
        AsyncValue<List<PatientSpecies>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
