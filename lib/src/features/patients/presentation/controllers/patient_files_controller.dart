import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/file_validation.dart';
import '../../data/repositories/patient_file_repository.dart';
import '../../domain/patient_file.dart';

part 'patient_files_controller.g.dart';

/// Controller for managing patient files for a specific patient.
///
/// This is a family provider - each patient has its own files list state.
@riverpod
class PatientFilesController extends _$PatientFilesController {
  PatientFileRepository get _repository =>
      ref.read(patientFileRepositoryProvider);

  @override
  Future<List<PatientFile>> build(String patientId) async {
    final result = await _repository.fetchByPatient(patientId);

    return result.fold(
      (failure) => throw failure,
      (files) => files,
    );
  }

  /// Refreshes the files list for this patient.
  Future<void> refresh() async {
    final patientId = this.patientId;
    state = const AsyncLoading();

    final result = await _repository.fetchByPatient(patientId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (files) => AsyncData(files),
    );
  }

  /// Uploads a new file for this patient.
  ///
  /// Returns a tuple of (success, errorMessage).
  /// On success, errorMessage is null.
  /// On failure, errorMessage contains the reason.
  Future<(bool, String?)> uploadFile({
    required String fileName,
    required List<int> bytes,
    String? notes,
  }) async {
    // Validate before upload
    final validationError = FileValidation.validate(fileName, bytes.length);
    if (validationError != null) {
      return (false, validationError);
    }

    // Get MIME type for proper web support
    final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
    final mediaParts = mimeType.split('/');

    final file = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: fileName,
      contentType: MediaType(mediaParts[0], mediaParts[1]),
    );

    final result = await _repository.upload(
      patientId: patientId,
      file: file,
      notes: notes,
    );

    return result.fold(
      (failure) => (false, failure.messageString),
      (newFile) {
        // Add to current list (newest first)
        final currentList = state.value ?? [];
        state = AsyncData([newFile, ...currentList]);
        return (true, null);
      },
    );
  }

  /// Updates the notes for a file.
  ///
  /// Returns a tuple of (success, errorMessage).
  Future<(bool, String?)> updateNotes(String fileId, String? notes) async {
    final result = await _repository.updateNotes(fileId, notes);

    return result.fold(
      (failure) => (false, failure.messageString),
      (updatedFile) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((f) {
          return f.id == updatedFile.id ? updatedFile : f;
        }).toList();
        state = AsyncData(updatedList);
        return (true, null);
      },
    );
  }

  /// Deletes a file (soft delete).
  ///
  /// Returns a tuple of (success, errorMessage).
  Future<(bool, String?)> deleteFile(String fileId) async {
    final result = await _repository.delete(fileId);

    return result.fold(
      (failure) => (false, failure.messageString),
      (_) {
        // Remove from current list
        final currentList = state.value ?? [];
        final updatedList = currentList.where((f) => f.id != fileId).toList();
        state = AsyncData(updatedList);
        return (true, null);
      },
    );
  }
}
