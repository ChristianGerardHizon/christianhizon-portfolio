import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../patients/data/repositories/breed_repository.dart';
import '../../../patients/domain/patient_breed.dart';

part 'breeds_controller.g.dart';

/// Controller for managing breed list state.
///
/// Provides methods for fetching and CRUD operations on breeds.
@Riverpod(keepAlive: true)
class BreedsController extends _$BreedsController {
  BreedRepository get _repository => ref.read(breedRepositoryProvider);

  @override
  Future<List<PatientBreed>> build() async {
    final result = await _repository.fetchAll();
    return result.fold(
      (failure) => throw failure,
      (breeds) => breeds,
    );
  }

  /// Refreshes the breed list.
  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await _repository.fetchAll();

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (breeds) => AsyncData(breeds),
    );
  }

  /// Creates a new breed.
  Future<bool> createBreed(PatientBreed breed) async {
    final result = await _repository.create(breed);

    return result.fold(
      (failure) => false,
      (newBreed) {
        final currentList = state.value ?? [];
        state = AsyncData([newBreed, ...currentList]);
        return true;
      },
    );
  }

  /// Updates an existing breed.
  Future<bool> updateBreed(PatientBreed breed) async {
    final result = await _repository.update(breed);

    return result.fold(
      (failure) => false,
      (updatedBreed) {
        final currentList = state.value ?? [];
        final updatedList = currentList.map((b) {
          return b.id == updatedBreed.id ? updatedBreed : b;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a breed (soft delete).
  Future<bool> deleteBreed(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        final currentList = state.value ?? [];
        final updatedList = currentList.where((b) => b.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}
