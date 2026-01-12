import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/prescription_repository.dart';
import '../../domain/prescription.dart';

part 'prescription_controller.g.dart';

/// Controller for managing prescriptions for a specific patient record.
///
/// This is a family provider - each record has its own prescription list state.
@riverpod
class PrescriptionController extends _$PrescriptionController {
  PrescriptionRepository get _repository =>
      ref.read(prescriptionRepositoryProvider);

  @override
  Future<List<Prescription>> build(String recordId) async {
    final result = await _repository.fetchByRecord(recordId);

    return result.fold(
      (failure) => throw failure,
      (prescriptions) => prescriptions,
    );
  }

  /// Refreshes the prescriptions list for this record.
  Future<void> refresh() async {
    final recordId = this.recordId;
    state = const AsyncLoading();

    final result = await _repository.fetchByRecord(recordId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (prescriptions) => AsyncData(prescriptions),
    );
  }

  /// Creates a new prescription.
  Future<bool> createPrescription(Prescription prescription) async {
    final result = await _repository.create(prescription);

    return result.fold(
      (failure) => false,
      (newPrescription) {
        // Add to current list (newest first)
        final currentList = state.value ?? [];
        state = AsyncData([newPrescription, ...currentList]);
        return true;
      },
    );
  }

  /// Updates an existing prescription.
  Future<bool> updatePrescription(Prescription prescription) async {
    final result = await _repository.update(prescription);

    return result.fold(
      (failure) => false,
      (updatedPrescription) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((p) {
          return p.id == updatedPrescription.id ? updatedPrescription : p;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a prescription (soft delete).
  Future<bool> deletePrescription(String id) async {
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

/// Provider for a single prescription by ID.
@riverpod
Future<Prescription?> prescription(Ref ref, String id) async {
  final repository = ref.read(prescriptionRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (prescription) => prescription,
  );
}
