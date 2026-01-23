import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/patient_file.dart';
import '../dto/patient_file_dto.dart';

part 'patient_file_repository.g.dart';

/// Repository interface for patient file operations.
abstract class PatientFileRepository {
  /// Fetches all files for a patient.
  FutureEither<List<PatientFile>> fetchByPatient(String patientId);

  /// Fetches a single file by ID.
  FutureEither<PatientFile> fetchOne(String id);

  /// Uploads a new file for a patient.
  FutureEither<PatientFile> upload({
    required String patientId,
    required http.MultipartFile file,
    String? notes,
  });

  /// Updates file notes.
  FutureEither<PatientFile> updateNotes(String id, String? notes);

  /// Soft deletes a file (sets isDeleted = true).
  FutureEither<void> delete(String id);
}

/// Provides the PatientFileRepository instance.
@Riverpod(keepAlive: true)
PatientFileRepository patientFileRepository(Ref ref) {
  return PatientFileRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [PatientFileRepository] using PocketBase.
class PatientFileRepositoryImpl implements PatientFileRepository {
  final PocketBase _pb;

  PatientFileRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientFiles);

  PatientFile _toEntity(RecordModel record) {
    final dto = PatientFileDto.fromRecord(record);
    return dto.toEntity(baseUrl: _pb.baseURL);
  }

  @override
  FutureEither<List<PatientFile>> fetchByPatient(String patientId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilters.forPatient(patientId).build();

        final records = await _collection.getFullList(
          filter: filter,
          sort: '-created',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientFile> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'File ID cannot be empty',
            null,
            'invalid_file_id',
          );
        }

        final record = await _collection.getOne(id);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientFile> upload({
    required String patientId,
    required http.MultipartFile file,
    String? notes,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'patient': patientId,
          'notes': notes,
          'isDeleted': false,
        };

        final record = await _collection.create(
          body: body,
          files: [file],
        );

        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientFile> updateNotes(String id, String? notes) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.update(
          id,
          body: {'notes': notes},
        );
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        await _collection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }
}
