import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../../core/foundation/type_defs.dart';
import '../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../domain/prescription.dart';
import 'prescription_dto.dart';

part 'prescription_repository.g.dart';

/// Repository interface for prescriptions.
abstract class PrescriptionRepository {
  /// Fetches all prescriptions for a patient record.
  FutureEither<List<Prescription>> fetchByRecord(String recordId);

  /// Fetches a single prescription by ID.
  FutureEither<Prescription> fetchOne(String id);

  /// Creates a new prescription.
  FutureEither<Prescription> create(Prescription prescription);

  /// Updates an existing prescription.
  FutureEither<Prescription> update(Prescription prescription);

  /// Deletes a prescription (soft delete).
  FutureEither<void> delete(String id);
}

/// Provider for the prescription repository.
@Riverpod(keepAlive: true)
PrescriptionRepository prescriptionRepository(Ref ref) {
  return PrescriptionRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the prescription repository.
class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final PocketBase _pb;

  PrescriptionRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientPrescriptionItems);

  @override
  FutureEither<List<Prescription>> fetchByRecord(String recordId) async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: 'patientRecord = "$recordId" && isDeleted = false',
          sort: '-created',
        );
        return records
            .map((r) => PrescriptionDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Prescription> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id);
        return PrescriptionDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Prescription> create(Prescription prescription) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: PrescriptionDto.toCreateJson(prescription),
        );
        return PrescriptionDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Prescription> update(Prescription prescription) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          prescription.id,
          body: PrescriptionDto.toCreateJson(prescription),
        );
        return PrescriptionDto.fromRecord(updated).toEntity();
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
