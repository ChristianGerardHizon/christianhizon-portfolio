import 'package:gym_system/src/core/models/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_breeds/domain/patient_breed.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_breed_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<PatientBreed> patientBreedRepository(Ref ref) {
  return PatientBreedRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PatientBreedRepositoryImpl extends PBCollectionRepository<PatientBreed> {
  final PocketBase pb;

  PatientBreedRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.patientBreeds);

  PatientBreed mapToData(Map<String, dynamic> map) {
    return PatientBreed.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<PatientBreed> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<PatientBreed> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload, files: files);
      return mapToData(response.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<PatientBreed>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
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
        items: result.items.map<PatientBreed>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<PatientBreed> update(
    PatientBreed patientBreed,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final patientBreedMap = patientBreed.toMap();
      final combinedMap = {...patientBreedMap, ...update};
      final result = await collection.update(
        patientBreed.id,
        body: combinedMap,
        files: files,
      );
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.patientBreeds);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<PatientBreed>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result.map<PatientBreed>((e) => mapToData(e.toJson())).toList();
      },
      Failure.handle,
    );
  }
}
