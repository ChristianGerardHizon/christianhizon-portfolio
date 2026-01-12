import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/patient_repository.dart';
import '../../domain/patient.dart';

part 'patient_controller.g.dart';

/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.
@Riverpod(keepAlive: true)
class PatientController extends _$PatientController {
  PatientRepository get _repository => ref.read(patientRepositoryProvider);

  @override
  Future<List<Patient>> build() async {
    final result = await _repository.fetchAll();

    return result.fold(
      (failure) => throw failure,
      (patients) => patients,
    );
  }

  /// Refreshes the patient list.
  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await _repository.fetchAll();

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (patients) => AsyncData(patients),
    );
  }

  /// Searches patients by name or owner.
  Future<void> search(String query) async {
    if (query.isEmpty) {
      return refresh();
    }

    state = const AsyncLoading();

    final result = await _repository.search(query);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (patients) => AsyncData(patients),
    );
  }

  /// Creates a new patient.
  Future<bool> createPatient(Patient patient) async {
    final result = await _repository.create(patient);

    return result.fold(
      (failure) => false,
      (newPatient) {
        // Add to current list
        final currentList = state.value ?? [];
        state = AsyncData([newPatient, ...currentList]);
        return true;
      },
    );
  }

  /// Updates an existing patient.
  Future<bool> updatePatient(Patient patient) async {
    final result = await _repository.update(patient);

    return result.fold(
      (failure) => false,
      (updatedPatient) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((p) {
          return p.id == updatedPatient.id ? updatedPatient : p;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a patient (soft delete).
  Future<bool> deletePatient(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        // Remove from current list
        final currentList = state.value ?? [];
        final updatedList = currentList.where((p) => p.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}

/// Provider for a single patient by ID.
@riverpod
Future<Patient?> patient(Ref ref, String id) async {
  final repository = ref.read(patientRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (patient) => patient,
  );
}

/// Provider for patient search query state.
@riverpod
class PatientSearchQuery extends _$PatientSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}
