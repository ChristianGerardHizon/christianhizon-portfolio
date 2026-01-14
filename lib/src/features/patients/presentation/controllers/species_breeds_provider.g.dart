// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_breeds_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for fetching all patient species.

@ProviderFor(species)
final speciesProvider = SpeciesProvider._();

/// Provider for fetching all patient species.

final class SpeciesProvider extends $FunctionalProvider<
        AsyncValue<List<PatientSpecies>>,
        List<PatientSpecies>,
        FutureOr<List<PatientSpecies>>>
    with
        $FutureModifier<List<PatientSpecies>>,
        $FutureProvider<List<PatientSpecies>> {
  /// Provider for fetching all patient species.
  SpeciesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'speciesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$speciesHash();

  @$internal
  @override
  $FutureProviderElement<List<PatientSpecies>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientSpecies>> create(Ref ref) {
    return species(ref);
  }
}

String _$speciesHash() => r'bca81884810abd5a19fa60b2200863bf1094dd1a';

/// Provider for fetching breeds filtered by species ID.
///
/// Returns an empty list if speciesId is null or empty.

@ProviderFor(breedsBySpecies)
final breedsBySpeciesProvider = BreedsBySpeciesFamily._();

/// Provider for fetching breeds filtered by species ID.
///
/// Returns an empty list if speciesId is null or empty.

final class BreedsBySpeciesProvider extends $FunctionalProvider<
        AsyncValue<List<PatientBreed>>,
        List<PatientBreed>,
        FutureOr<List<PatientBreed>>>
    with
        $FutureModifier<List<PatientBreed>>,
        $FutureProvider<List<PatientBreed>> {
  /// Provider for fetching breeds filtered by species ID.
  ///
  /// Returns an empty list if speciesId is null or empty.
  BreedsBySpeciesProvider._(
      {required BreedsBySpeciesFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'breedsBySpeciesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$breedsBySpeciesHash();

  @override
  String toString() {
    return r'breedsBySpeciesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PatientBreed>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientBreed>> create(Ref ref) {
    final argument = this.argument as String?;
    return breedsBySpecies(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BreedsBySpeciesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$breedsBySpeciesHash() => r'7e8b55f34fc9fa9418e6b52ee263062152ccd1e3';

/// Provider for fetching breeds filtered by species ID.
///
/// Returns an empty list if speciesId is null or empty.

final class BreedsBySpeciesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<PatientBreed>>, String?> {
  BreedsBySpeciesFamily._()
      : super(
          retry: null,
          name: r'breedsBySpeciesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching breeds filtered by species ID.
  ///
  /// Returns an empty list if speciesId is null or empty.

  BreedsBySpeciesProvider call(
    String? speciesId,
  ) =>
      BreedsBySpeciesProvider._(argument: speciesId, from: this);

  @override
  String toString() => r'breedsBySpeciesProvider';
}
