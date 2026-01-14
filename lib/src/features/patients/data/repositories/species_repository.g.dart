// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the SpeciesRepository instance.

@ProviderFor(speciesRepository)
final speciesRepositoryProvider = SpeciesRepositoryProvider._();

/// Provides the SpeciesRepository instance.

final class SpeciesRepositoryProvider extends $FunctionalProvider<
    SpeciesRepository,
    SpeciesRepository,
    SpeciesRepository> with $Provider<SpeciesRepository> {
  /// Provides the SpeciesRepository instance.
  SpeciesRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'speciesRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$speciesRepositoryHash();

  @$internal
  @override
  $ProviderElement<SpeciesRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpeciesRepository create(Ref ref) {
    return speciesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpeciesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpeciesRepository>(value),
    );
  }
}

String _$speciesRepositoryHash() => r'c43527ce7a7de2ba1730c0155f038a2199117fa3';
