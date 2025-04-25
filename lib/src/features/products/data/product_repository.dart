import 'package:gym_system/src/core/classes/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<Product> productRepository(Ref ref) {
  return ProductRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ProductRepositoryImpl extends PBCollectionRepository<Product> {
  final PocketBase pb;

  ProductRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.products);

  Product mapToData(Map<String, dynamic> map) {
    return Product.fromMap({...map, 'domain': pb.baseURL});
  }

  final expand = 'branch';

  @override
  TaskResult<Product> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<Product> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(
        body: payload,
        files: files,
        expand: expand,
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
  TaskResult<PageResults<Product>> list({
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
        items: result.items.map<Product>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<Product> update(
    Product product,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final productMap = product.toMap();
      final combinedMap = {...productMap, ...update};
      final result = await collection.update(
        product.id,
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
      final batchCollection = batch.collection(PocketBaseCollections.products);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<Product>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          expand: expand,
        );
        return result.map<Product>((e) => mapToData(e.toJson())).toList();
      },
      Failure.handle,
    );
  }
}
