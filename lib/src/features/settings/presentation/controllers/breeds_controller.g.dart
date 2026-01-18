// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing breed list state.
///
/// Provides methods for fetching and CRUD operations on breeds.

@ProviderFor(BreedsController)
final breedsControllerProvider = BreedsControllerProvider._();

/// Controller for managing breed list state.
///
/// Provides methods for fetching and CRUD operations on breeds.
final class BreedsControllerProvider
    extends $AsyncNotifierProvider<BreedsController, List<PatientBreed>> {
  /// Controller for managing breed list state.
  ///
  /// Provides methods for fetching and CRUD operations on breeds.
  BreedsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'breedsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$breedsControllerHash();

  @$internal
  @override
  BreedsController create() => BreedsController();
}

String _$breedsControllerHash() => r'd68ae45e7b98ce00104576115faeb698d53828c2';

/// Controller for managing breed list state.
///
/// Provides methods for fetching and CRUD operations on breeds.

abstract class _$BreedsController extends $AsyncNotifier<List<PatientBreed>> {
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
