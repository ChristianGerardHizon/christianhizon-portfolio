import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../patients/data/repositories/species_repository.dart';
import '../../../patients/domain/patient_species.dart';

part 'species_controller.g.dart';

/// Controller for managing species list state.
///
/// Provides methods for fetching and CRUD operations on species.
@Riverpod(keepAlive: true)
class SpeciesController extends _$SpeciesController {
  SpeciesRepository get _repository => ref.read(speciesRepositoryProvider);

  @override
  Future<List<PatientSpecies>> build() async {
    final result = await _repository.fetchAll();
    return result.fold(
      (failure) => throw failure,
      (species) => species,
    );
  }

  /// Refreshes the species list.
  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await _repository.fetchAll();

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (species) => AsyncData(species),
    );
  }

  /// Creates a new species.
  Future<bool> createSpecies(PatientSpecies species) async {
    final result = await _repository.create(species);

    return result.fold(
      (failure) => false,
      (newSpecies) {
        final currentList = state.value ?? [];
        state = AsyncData([newSpecies, ...currentList]);
        return true;
      },
    );
  }

  /// Updates an existing species.
  Future<bool> updateSpecies(PatientSpecies species) async {
    final result = await _repository.update(species);

    return result.fold(
      (failure) => false,
      (updatedSpecies) {
        final currentList = state.value ?? [];
        final updatedList = currentList.map((s) {
          return s.id == updatedSpecies.id ? updatedSpecies : s;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a species (soft delete).
  Future<bool> deleteSpecies(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        final currentList = state.value ?? [];
        final updatedList = currentList.where((s) => s.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}
