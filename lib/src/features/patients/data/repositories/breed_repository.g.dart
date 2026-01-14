// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the BreedRepository instance.

@ProviderFor(breedRepository)
final breedRepositoryProvider = BreedRepositoryProvider._();

/// Provides the BreedRepository instance.

final class BreedRepositoryProvider extends $FunctionalProvider<BreedRepository,
    BreedRepository, BreedRepository> with $Provider<BreedRepository> {
  /// Provides the BreedRepository instance.
  BreedRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'breedRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$breedRepositoryHash();

  @$internal
  @override
  $ProviderElement<BreedRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BreedRepository create(Ref ref) {
    return breedRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BreedRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BreedRepository>(value),
    );
  }
}

String _$breedRepositoryHash() => r'e146f10f693a24837f80066064d95a97c0d3f8ef';
