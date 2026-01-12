import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../../core/foundation/type_defs.dart';
import '../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../domain/patient_record.dart';
import 'patient_record_dto.dart';

part 'patient_record_repository.g.dart';

/// Repository interface for patient records.
abstract class PatientRecordRepository {
  /// Fetches all records for a patient.
  FutureEither<List<PatientRecord>> fetchByPatient(String patientId);

  /// Fetches a single record by ID.
  FutureEither<PatientRecord> fetchOne(String id);

  /// Creates a new patient record.
  FutureEither<PatientRecord> create(PatientRecord record);

  /// Updates an existing patient record.
  FutureEither<PatientRecord> update(PatientRecord record);

  /// Deletes a patient record (soft delete).
  FutureEither<void> delete(String id);
}

/// Provider for the patient record repository.
@Riverpod(keepAlive: true)
PatientRecordRepository patientRecordRepository(Ref ref) {
  return PatientRecordRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the patient record repository.
class PatientRecordRepositoryImpl implements PatientRecordRepository {
  final PocketBase _pb;

  PatientRecordRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientRecords);

  @override
  FutureEither<List<PatientRecord>> fetchByPatient(String patientId) async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: 'patient = "$patientId" && isDeleted = false',
          sort: '-visitDate',
        );
        return records
            .map((r) => PatientRecordDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientRecord> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id);
        return PatientRecordDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientRecord> create(PatientRecord record) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: PatientRecordDto.toCreateJson(record),
        );
        return PatientRecordDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientRecord> update(PatientRecord record) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          record.id,
          body: PatientRecordDto.toCreateJson(record),
        );
        return PatientRecordDto.fromRecord(updated).toEntity();
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
