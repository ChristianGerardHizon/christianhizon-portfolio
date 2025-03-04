import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/history/domain/history_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_type_repository.g.dart';

abstract class HistoryTypeRepository {
  TaskResult<HistoryType> get(String id);
  TaskResult<PageResults<HistoryType>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<List<HistoryType>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<HistoryType> update(
    HistoryType historyType,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<HistoryType> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
HistoryTypeRepository historyTypeRepository(Ref ref) {
  return HistoryTypeRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class HistoryTypeRepositoryImpl extends HistoryTypeRepository {
  final PocketBase pb;

  HistoryTypeRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.historyTypes);

  @override
  TaskResult<HistoryType> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return HistoryType.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<HistoryType> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return HistoryType.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<HistoryType>> list({
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
        items: result.items.map<HistoryType>((e) {
          return HistoryType.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<HistoryType> update(
    HistoryType historyType,
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
      return HistoryType.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.historyTypes);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<HistoryType>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getFullList(
        filter: filter,
      );
      return result
          .map<HistoryType>(
            (e) => HistoryType.customFromMap(e.toJson()),
          )
          .toList();
    }, Failure.tryCatchData);
  }
}
