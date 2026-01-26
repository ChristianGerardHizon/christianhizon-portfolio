import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/patient_record_repository.dart';
import '../../domain/patient_record.dart';

part 'patient_records_controller.g.dart';

/// Controller for managing patient records for a specific patient.
///
/// This is a family provider - each patient has its own record list state.
@riverpod
class PatientRecordsController extends _$PatientRecordsController {
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

    if (!ref.mounted) return;

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (records) => AsyncData(records),
    );
  }

  /// Creates a new patient record.
  Future<bool> createRecord(PatientRecord record) async {
    final result = await _repository.create(record);

    if (!ref.mounted) return false;

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

  /// Creates a new patient record and returns it.
  ///
  /// Returns the created record on success, or null on failure.
  /// This is useful when the caller needs the created record's ID.
  Future<PatientRecord?> createRecordAndReturn(PatientRecord record) async {
    final result = await _repository.create(record);

    if (!ref.mounted) return null;

    return result.fold(
      (failure) => null,
      (newRecord) {
        // Add to current list (newest first)
        final currentList = state.value ?? [];
        state = AsyncData([newRecord, ...currentList]);
        return newRecord;
      },
    );
  }

  /// Updates an existing patient record.
  Future<bool> updateRecord(PatientRecord record) async {
    final result = await _repository.update(record);

    if (!ref.mounted) return false;

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

    if (!ref.mounted) return false;

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
