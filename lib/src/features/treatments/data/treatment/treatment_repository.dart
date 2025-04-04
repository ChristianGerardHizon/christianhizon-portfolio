import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatment_repository.g.dart';

abstract class TreatmentRepository {
  TaskResult<Treatment> get(String id);
  TaskResult<PageResults<Treatment>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<List<Treatment>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<Treatment> update(
    Treatment historyType,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<Treatment> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
TreatmentRepository treatmentRepository(Ref ref) {
  return TreatmentRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class TreatmentRepositoryImpl extends TreatmentRepository {
  final PocketBase pb;

  TreatmentRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.treatments);

  Treatment mapToData(Map<String, dynamic> map) {
    return Treatment.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<Treatment> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(
        id,
      );
      return mapToData(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Treatment> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return mapToData(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<Treatment>> list({
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
        items: result.items.map<Treatment>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Treatment> update(
    Treatment historyType,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final historyTypeMap = historyType.toMap();
      final combinedMap = {...historyTypeMap, ...update};
      final result = await collection.update(
        historyType.id,
        body: combinedMap,
        files: files,
      );
      return mapToData(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.treatments);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<Treatment>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getFullList(
        filter: filter,
      );
      return result
          .map<Treatment>(
            (e) => mapToData(e.toJson()),
          )
          .toList();
    }, Failure.tryCatchData);
  }
}
