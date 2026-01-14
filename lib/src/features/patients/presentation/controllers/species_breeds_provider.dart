import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/breed_repository.dart';
import '../../data/repositories/species_repository.dart';
import '../../domain/patient_breed.dart';
import '../../domain/patient_species.dart';

part 'species_breeds_provider.g.dart';

/// Provider for fetching all patient species.
@riverpod
Future<List<PatientSpecies>> species(Ref ref) async {
  final result = await ref.read(speciesRepositoryProvider).fetchAll();
  return result.fold(
    (failure) => throw failure,
    (species) => species,
  );
}

/// Provider for fetching breeds filtered by species ID.
///
/// Returns an empty list if speciesId is null or empty.
@riverpod
Future<List<PatientBreed>> breedsBySpecies(
  Ref ref,
  String? speciesId,
) async {
  if (speciesId == null || speciesId.isEmpty) {
    return [];
  }

  final result = await ref.read(breedRepositoryProvider).fetchBySpecies(speciesId);
  return result.fold(
    (failure) => throw failure,
    (breeds) => breeds,
  );
}
