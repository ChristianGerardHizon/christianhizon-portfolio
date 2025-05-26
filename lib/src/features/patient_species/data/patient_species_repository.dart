import 'package:sannjosevet/src/core/models/pb_repository.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/patient_species/domain/patient_species.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_species_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<PatientSpecies> patientSpeciesRepository(Ref ref) {
  return PatientSpeciesRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PatientSpeciesRepositoryImpl
    extends PBCollectionRepository<PatientSpecies> {
  final PocketBase pb;

  PatientSpeciesRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.patientSpecies);

  PatientSpecies mapToData(Map<String, dynamic> map) {
    return mapToData({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<PatientSpecies> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return PatientSpecies.fromMap(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<PatientSpecies> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return PatientSpecies.fromMap(response.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<PatientSpecies>> list({
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
        items: result.items.map<PatientSpecies>((e) {
          return PatientSpecies.fromMap(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
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
      return PatientSpecies.fromMap(result.toJson());
    }, Failure.handle);
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
    }, Failure.handle);
  }

  @override
  TaskResult<List<PatientSpecies>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          sort: sort,
        );
        return result
            .map<PatientSpecies>((e) => PatientSpecies.fromMap(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
