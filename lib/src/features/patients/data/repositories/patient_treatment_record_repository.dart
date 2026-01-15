import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/patient_treatment_record.dart';
import '../dto/patient_treatment_record_dto.dart';

part 'patient_treatment_record_repository.g.dart';

/// Repository interface for patient treatment records.
abstract class PatientTreatmentRecordRepository {
  /// Fetches all treatment records for a patient.
  FutureEither<List<PatientTreatmentRecord>> fetchByPatient(String patientId);

  /// Fetches a single treatment record by ID.
  FutureEither<PatientTreatmentRecord> fetchOne(String id);

  /// Creates a new treatment record.
  FutureEither<PatientTreatmentRecord> create(PatientTreatmentRecord record);

  /// Updates an existing treatment record.
  FutureEither<PatientTreatmentRecord> update(PatientTreatmentRecord record);

  /// Deletes a treatment record (soft delete).
  FutureEither<void> delete(String id);
}

/// Provider for the patient treatment record repository.
@Riverpod(keepAlive: true)
PatientTreatmentRecordRepository patientTreatmentRecordRepository(Ref ref) {
  return PatientTreatmentRecordRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the patient treatment record repository.
class PatientTreatmentRecordRepositoryImpl
    implements PatientTreatmentRecordRepository {
  final PocketBase _pb;

  PatientTreatmentRecordRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientTreatmentRecords);

  @override
  FutureEither<List<PatientTreatmentRecord>> fetchByPatient(
    String patientId,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: PBFilters.forPatient(patientId).build(),
          expand: 'treatment',
          sort: '-date,-created',
        );
        return records
            .map((r) => PatientTreatmentRecordDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientTreatmentRecord> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id, expand: 'treatment');
        return PatientTreatmentRecordDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientTreatmentRecord> create(
    PatientTreatmentRecord record,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: PatientTreatmentRecordDto.toCreateJson(record),
          expand: 'treatment',
        );
        return PatientTreatmentRecordDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientTreatmentRecord> update(
    PatientTreatmentRecord record,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          record.id,
          body: PatientTreatmentRecordDto.toCreateJson(record),
          expand: 'treatment',
        );
        return PatientTreatmentRecordDto.fromRecord(updated).toEntity();
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
