import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/patient_species.dart';
import '../dto/patient_species_dto.dart';

part 'species_repository.g.dart';

/// Repository interface for patient species operations.
abstract class SpeciesRepository {
  /// Fetches all species.
  FutureEither<List<PatientSpecies>> fetchAll();

  /// Creates a new species.
  FutureEither<PatientSpecies> create(PatientSpecies species);

  /// Updates an existing species.
  FutureEither<PatientSpecies> update(PatientSpecies species);

  /// Soft deletes a species by ID.
  FutureEither<void> delete(String id);
}

/// Provides the SpeciesRepository instance.
@Riverpod(keepAlive: true)
SpeciesRepository speciesRepository(Ref ref) {
  return SpeciesRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [SpeciesRepository] using PocketBase.
class SpeciesRepositoryImpl implements SpeciesRepository {
  final PocketBase _pb;

  SpeciesRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.patientSpecies);

  PatientSpecies _toEntity(RecordModel record) {
    final dto = PatientSpeciesDto.fromRecord(record);
    return dto.toEntity();
  }

  @override
  FutureEither<List<PatientSpecies>> fetchAll() async {
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
  FutureEither<PatientSpecies> create(PatientSpecies species) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'name': species.name,
          'isDeleted': false,
        };

        final record = await _collection.create(body: body);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<PatientSpecies> update(PatientSpecies species) async {
    return TaskEither.tryCatch(
      () async {
        if (species.id.isEmpty) {
          throw const DataFailure(
            'Species ID cannot be empty',
            null,
            'invalid_species_id',
          );
        }

        final body = <String, dynamic>{
          'name': species.name,
        };

        final record = await _collection.update(species.id, body: body);
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
            'Species ID cannot be empty',
            null,
            'invalid_species_id',
          );
        }

        // Soft delete
        await _collection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }
}
