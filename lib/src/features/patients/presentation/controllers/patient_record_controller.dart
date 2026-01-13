import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/patient_record_repository.dart';
import '../../domain/patient_record.dart';

part 'patient_record_controller.g.dart';

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.
@riverpod
class PatientRecordController extends _$PatientRecordController {
  PatientRecordRepository get _repository =>
      ref.read(patientRecordRepositoryProvider);

  @override
  Future<List<PatientRecord>> build(String patientId) async {
    final result = await _repository.fetchByPatient(patientId);

    return result.fold(
      (failure) => throw failure,
      (records) => records,
    );
  }

  /// Refreshes the records list for this patient.
  Future<void> refresh() async {
    final patientId = this.patientId;
    state = const AsyncLoading();

    final result = await _repository.fetchByPatient(patientId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (records) => AsyncData(records),
    );
  }

  /// Creates a new patient record.
  Future<bool> createRecord(PatientRecord record) async {
    final result = await _repository.create(record);

    return result.fold(
      (failure) => false,
      (newRecord) {
        // Add to current list (newest first)
        final currentList = state.value ?? [];
        state = AsyncData([newRecord, ...currentList]);
        return true;
      },
    );
  }

  /// Updates an existing patient record.
  Future<bool> updateRecord(PatientRecord record) async {
    final result = await _repository.update(record);

    return result.fold(
      (failure) => false,
      (updatedRecord) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((r) {
          return r.id == updatedRecord.id ? updatedRecord : r;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a patient record (soft delete).
  Future<bool> deleteRecord(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        // Remove from current list
        final currentList = state.value ?? [];
        final updatedList = currentList.where((r) => r.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}

/// Provider for a single patient record by ID.
@riverpod
Future<PatientRecord?> patientRecord(Ref ref, String id) async {
  final repository = ref.read(patientRecordRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (record) => record,
  );
}
