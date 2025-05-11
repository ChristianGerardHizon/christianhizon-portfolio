import 'package:gym_system/src/core/models/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/strings/pb_expand.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/product_stock_adjustment/domain/product_stock_adjustment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_adjustment_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<ProductStockAdjustment> productStockAdjustmentRepository(
    Ref ref) {
  return ProductStockAdjustmentRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ProductStockAdjustmentRepositoryImpl
    extends PBCollectionRepository<ProductStockAdjustment> {
  final PocketBase pb;

  ProductStockAdjustmentRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.productStockAdjustments);

  ProductStockAdjustment mapToData(Map<String, dynamic> map) {
    return ProductStockAdjustment.fromMap({...map, 'domain': pb.baseURL});
  }

  final expand = PBExpand.productStockAdjustment.toString();

  @override
  TaskResult<ProductStockAdjustment> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<ProductStockAdjustment> create(
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
  TaskResult<PageResults<ProductStockAdjustment>> list({
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
        items: result.items.map<ProductStockAdjustment>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<ProductStockAdjustment> update(
    ProductStockAdjustment product,
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
  TaskResult<List<ProductStockAdjustment>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          expand: expand,
        );
        return result
            .map<ProductStockAdjustment>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
