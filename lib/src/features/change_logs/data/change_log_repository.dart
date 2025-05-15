import 'package:gym_system/src/core/models/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/strings/pb_expand.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/change_logs/domain/change_log.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_log_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<ChangeLog> changeLogRepository(Ref ref) {
  return ChangeLogRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ChangeLogRepositoryImpl extends PBCollectionRepository<ChangeLog> {
  final PocketBase pb;

  ChangeLogRepositoryImpl({required this.pb});

  final String expand = PBExpand.changeLogs.toString();

  RecordService get collection =>
      pb.collection(PocketBaseCollections.changeLogs);

  ChangeLog mapToData(Map<String, dynamic> map) {
    return ChangeLog.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<ChangeLog> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<ChangeLog> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response =
          await collection.create(body: payload, files: files, expand: expand);
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
  TaskResult<PageResults<ChangeLog>> list({
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
        sort: sort,
        expand: expand,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<ChangeLog>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<ChangeLog> update(
    ChangeLog history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final historyMap = history.toMap();
      final combinedMap = {...historyMap, ...update};
      final result = await collection.update(
        history.id,
        body: combinedMap,
        files: files,
        expand: expand,
      );
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.changeLogs);
      for (final id in ids) {
        batchCollection.update(id, body: {ChangeLogField.isDeleted: true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<ChangeLog>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          sort: sort,
          expand: expand,
        );
        return result.map<ChangeLog>((e) => mapToData(e.toJson())).toList();
      },
      Failure.handle,
    );
  }
}
