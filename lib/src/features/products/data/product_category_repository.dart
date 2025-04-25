import 'package:gym_system/src/core/classes/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/domain/product_category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_category_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<ProductCategory> productCategoryRepository(Ref ref) {
  return ProductCategoryRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ProductCategoryRepositoryImpl
    extends PBCollectionRepository<ProductCategory> {
  final PocketBase pb;

  ProductCategoryRepositoryImpl({required this.pb});

  ProductCategory mapToData(Map<String, dynamic> map) {
    return ProductCategory.fromMap({...map, 'domain': pb.baseURL});
  }

  RecordService get collection =>
      pb.collection(PocketBaseCollections.productCategories);

  @override
  TaskResult<ProductCategory> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<ProductCategory> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(
        body: payload,
        files: files,
      );
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
  TaskResult<PageResults<ProductCategory>> list({
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
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<ProductCategory>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<ProductCategory> update(
    ProductCategory history,
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
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.productCategories);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<ProductCategory>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result
            .map<ProductCategory>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
