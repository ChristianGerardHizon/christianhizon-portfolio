import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/categories/domain/category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

abstract class CategoryRepository {
  TaskResult<Category> get(String id);
  TaskResult<PageResults<Category>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    PocketbaseSortValue? sort,
  });
  TaskResult<List<Category>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<Category> update(
    Category history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<Category> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
CategoryRepository medicalRecordRepository(Ref ref) {
  return CategoryRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class CategoryRepositoryImpl extends CategoryRepository {
  final PocketBase pb;

  CategoryRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.medicalRecords);

  @override
  TaskResult<Category> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return Category.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Category> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return Category.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<Category>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    PocketbaseSortValue? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
        sort: sort?.value,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<Category>((e) {
          return Category.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Category> update(
    Category history,
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
      );
      return Category.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.medicalRecords);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<Category>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result
            .map<Category>((e) => Category.customFromMap(e.toJson()))
            .toList();
      },
      Failure.tryCatchData,
    );
  }
}
