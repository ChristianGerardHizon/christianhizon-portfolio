import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../../core/foundation/type_defs.dart';
import '../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../domain/patient.dart';
import 'patient_dto.dart';

part 'patient_repository.g.dart';

/// Repository interface for patient operations.
abstract class PatientRepository {
  /// Fetches all patients.
  FutureEither<List<Patient>> fetchAll({String? filter, String? sort});

  /// Fetches a single patient by ID.
  FutureEither<Patient> fetchOne(String id);

  /// Creates a new patient.
  FutureEither<Patient> create(Patient patient);

  /// Updates an existing patient.
  FutureEither<Patient> update(Patient patient);

  /// Soft deletes a patient (sets isDeleted = true).
  FutureEither<void> delete(String id);

  /// Searches patients by name or owner.
  FutureEither<List<Patient>> search(String query);
}

/// Provides the PatientRepository instance.
@Riverpod(keepAlive: true)
PatientRepository patientRepository(Ref ref) {
  return PatientRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [PatientRepository] using PocketBase.
class PatientRepositoryImpl implements PatientRepository {
  final PocketBase _pb;

  PatientRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patients);
  String get _expand => 'species,breed';
  String get _baseFilter => 'isDeleted = false';

  Patient _toEntity(RecordModel record) {
    final dto = PatientDto.fromRecord(record);
    return dto.toEntity(baseUrl: _pb.baseURL);
  }

  @override
  FutureEither<List<Patient>> fetchAll({String? filter, String? sort}) async {
    return TaskEither.tryCatch(
      () async {
        final combinedFilter =
            filter != null ? '$_baseFilter && $filter' : _baseFilter;

        final records = await _collection.getFullList(
          expand: _expand,
          filter: combinedFilter,
          sort: sort ?? '-created',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Patient> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Patient ID cannot be empty',
            null,
            'invalid_patient_id',
          );
        }

        final record = await _collection.getOne(id, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Patient> create(Patient patient) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'name': patient.name,
          'species': patient.speciesId,
          'breed': patient.breedId,
          'owner': patient.owner,
          'contactNumber': patient.contactNumber,
          'email': patient.email,
          'address': patient.address,
          'color': patient.color,
          'sex': patient.sex?.name,
          'branch': patient.branch,
          'dateOfBirth': patient.dateOfBirth?.toIso8601String(),
          'isDeleted': false,
        };

        final record = await _collection.create(body: body, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Patient> update(Patient patient) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'name': patient.name,
          'species': patient.speciesId,
          'breed': patient.breedId,
          'owner': patient.owner,
          'contactNumber': patient.contactNumber,
          'email': patient.email,
          'address': patient.address,
          'color': patient.color,
          'sex': patient.sex?.name,
          'branch': patient.branch,
          'dateOfBirth': patient.dateOfBirth?.toIso8601String(),
        };

        final record =
            await _collection.update(patient.id, body: body, expand: _expand);
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

  @override
  FutureEither<List<Patient>> search(String query) async {
    return TaskEither.tryCatch(
      () async {
        final searchFilter = '(name ~ "$query" || owner ~ "$query")';
        final combinedFilter = '$_baseFilter && $searchFilter';

        final records = await _collection.getFullList(
          expand: _expand,
          filter: combinedFilter,
          sort: 'name',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }
}
