import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/domain/patient_species.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_species_repository.g.dart';

abstract class PatientSpeciesRepository {
  TaskResult<PatientSpecies> get(String id);
  TaskResult<PageResults<PatientSpecies>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<PatientSpecies> update(
    PatientSpecies patientSpecies,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<PatientSpecies> create(Map<String, dynamic> payload);

  TaskResult<List<PatientSpecies>> listAll({
    int batch = 500,
    String? filter,
  });
}

@Riverpod(keepAlive: true)
PatientSpeciesRepository patientSpeciesRepository(Ref ref) {
  return PatientSpeciesRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PatientSpeciesRepositoryImpl extends PatientSpeciesRepository {
  final PocketBase pb;

  PatientSpeciesRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.patientSpecies);

  @override
  TaskResult<PatientSpecies> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return PatientSpecies.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PatientSpecies> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return PatientSpecies.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<PatientSpecies>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<PatientSpecies>((e) {
          return PatientSpecies.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PatientSpecies> update(
    PatientSpecies patientSpecies,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final patientSpeciesMap = patientSpecies.toMap();
      final combinedMap = {...patientSpeciesMap, ...update};
      final result = await collection.update(
        patientSpecies.id,
        body: combinedMap,
        files: files,
      );
      return PatientSpecies.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.patientSpecies);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<PatientSpecies>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result
            .map<PatientSpecies>(
                (e) => PatientSpecies.customFromMap(e.toJson()))
            .toList();
      },
      Failure.tryCatchData,
    );
  }
}
