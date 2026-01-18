import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/patient_breed.dart';
import '../dto/patient_breed_dto.dart';

part 'breed_repository.g.dart';

/// Repository interface for patient breed operations.
abstract class BreedRepository {
  /// Fetches all breeds.
  FutureEither<List<PatientBreed>> fetchAll();

  /// Fetches breeds filtered by species ID.
  FutureEither<List<PatientBreed>> fetchBySpecies(String speciesId);

  /// Creates a new breed.
  FutureEither<PatientBreed> create(PatientBreed breed);

  /// Updates an existing breed.
  FutureEither<PatientBreed> update(PatientBreed breed);

  /// Soft deletes a breed by ID.
  FutureEither<void> delete(String id);
}

/// Provides the BreedRepository instance.
@Riverpod(keepAlive: true)
BreedRepository breedRepository(Ref ref) {
  return BreedRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [BreedRepository] using PocketBase.
class BreedRepositoryImpl implements BreedRepository {
  final PocketBase _pb;

  BreedRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientBreeds);

  PatientBreed _toEntity(RecordModel record) {
    final dto = PatientBreedDto.fromRecord(record);
    return dto.toEntity();
  }

  @override
  FutureEither<List<PatientBreed>> fetchAll() async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilters.active.build();

        final records = await _collection.getFullList(
          filter: filter,
          sort: 'name',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<PatientBreed>> fetchBySpecies(String speciesId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter()
            .notDeleted()
            .relation('species', speciesId)
            .build();

        final records = await _collection.getFullList(
          filter: filter,
          sort: 'name',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientBreed> create(PatientBreed breed) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'name': breed.name,
          'species': breed.speciesId,
          'isDeleted': false,
        };

        final record = await _collection.create(body: body);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientBreed> update(PatientBreed breed) async {
    return TaskEither.tryCatch(
      () async {
        if (breed.id.isEmpty) {
          throw const DataFailure(
            'Breed ID cannot be empty',
            null,
            'invalid_breed_id',
          );
        }

        final body = <String, dynamic>{
          'name': breed.name,
          'species': breed.speciesId,
        };

        final record = await _collection.update(breed.id, body: body);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Breed ID cannot be empty',
            null,
            'invalid_breed_id',
          );
        }

        // Soft delete
        await _collection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }
}
