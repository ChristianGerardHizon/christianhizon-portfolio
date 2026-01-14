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
}
