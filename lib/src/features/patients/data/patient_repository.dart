import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../../core/foundation/type_defs.dart';
import '../../../core/packages/pocketbase/pb_filter.dart';
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

  /// Searches patients by the specified fields.
  FutureEither<List<Patient>> search(String query, {List<String>? fields});

  /// Invalidates the patient list cache.
  void invalidateCache();
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

  // Cache for patient list
  List<Patient>? _cachedPatients;
  DateTime? _cacheTimestamp;
  String? _cachedFilter;
  String? _cachedSort;

  // Cache TTL (5 minutes)
  static const _cacheTtl = Duration(minutes: 5);

  /// Checks if the cache is valid.
  bool _isCacheValid(String? filter, String? sort) {
    if (_cachedPatients == null || _cacheTimestamp == null) return false;
    if (_cachedFilter != filter || _cachedSort != sort) return false;
    return DateTime.now().difference(_cacheTimestamp!) < _cacheTtl;
  }

  /// Invalidates the cache.
  @override
  void invalidateCache() {
    _cachedPatients = null;
    _cacheTimestamp = null;
    _cachedFilter = null;
    _cachedSort = null;
  }

  Patient _toEntity(RecordModel record) {
    final dto = PatientDto.fromRecord(record);
    return dto.toEntity(baseUrl: _pb.baseURL);
  }

  @override
  FutureEither<List<Patient>> fetchAll({String? filter, String? sort}) async {
    // Return cached data if valid
    if (_isCacheValid(filter, sort)) {
      return Right(_cachedPatients!);
    }

    return TaskEither.tryCatch(
      () async {
        final baseFilter = PBFilters.active.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filterString,
          sort: sort ?? '-created',
        );

        final patients = records.map(_toEntity).toList();

        // Update cache
        _cachedPatients = patients;
        _cacheTimestamp = DateTime.now();
        _cachedFilter = filter;
        _cachedSort = sort;

        return patients;
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
        invalidateCache(); // Invalidate cache on create
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
        invalidateCache(); // Invalidate cache on update
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
        invalidateCache(); // Invalidate cache on delete
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<Patient>> search(
    String query, {
    List<String>? fields,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final searchFields = fields ?? ['name'];
        final filter = PBFilter()
            .notDeleted()
            .searchFields(query, searchFields)
            .build();

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filter,
          sort: 'name',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }
}
