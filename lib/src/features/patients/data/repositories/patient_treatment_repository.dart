import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/patient_treatment.dart';
import '../dto/patient_treatment_dto.dart';

part 'patient_treatment_repository.g.dart';

/// Repository interface for patient treatments (catalog).
abstract class PatientTreatmentRepository {
  /// Fetches all treatments from the catalog.
  FutureEither<List<PatientTreatment>> fetchAll();

  /// Fetches a single treatment by ID.
  FutureEither<PatientTreatment> fetchOne(String id);

  /// Creates a new treatment in the catalog.
  FutureEither<PatientTreatment> create(PatientTreatment treatment);

  /// Updates an existing treatment.
  FutureEither<PatientTreatment> update(PatientTreatment treatment);

  /// Deletes a treatment (soft delete).
  FutureEither<void> delete(String id);
}

/// Provider for the patient treatment repository.
@Riverpod(keepAlive: true)
PatientTreatmentRepository patientTreatmentRepository(Ref ref) {
  return PatientTreatmentRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the patient treatment repository.
class PatientTreatmentRepositoryImpl implements PatientTreatmentRepository {
  final PocketBase _pb;

  PatientTreatmentRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientTreatments);

  @override
  FutureEither<List<PatientTreatment>> fetchAll() async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: PBFilters.active.build(),
          sort: 'name',
        );
        return records
            .map((r) => PatientTreatmentDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientTreatment> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id);
        return PatientTreatmentDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientTreatment> create(PatientTreatment treatment) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: PatientTreatmentDto.toCreateJson(treatment),
        );
        return PatientTreatmentDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientTreatment> update(PatientTreatment treatment) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          treatment.id,
          body: PatientTreatmentDto.toCreateJson(treatment),
        );
        return PatientTreatmentDto.fromRecord(updated).toEntity();
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
