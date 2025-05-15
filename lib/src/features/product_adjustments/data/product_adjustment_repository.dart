import 'package:gym_system/src/core/models/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/strings/pb_expand.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/product_adjustments/domain/product_adjustment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_adjustment_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<ProductAdjustment> productAdjustmentRepository(Ref ref) {
  return ProductAdjustmentRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ProductAdjustmentRepositoryImpl
    extends PBCollectionRepository<ProductAdjustment> {
  final PocketBase pb;

  ProductAdjustmentRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.productAdjustments);

  RecordService get productCollection =>
      pb.collection(PocketBaseCollections.products);

  ProductAdjustment mapToData(Map<String, dynamic> map) {
    return ProductAdjustment.fromMap({...map, 'domain': pb.baseURL});
  }

  final expand = PBExpand.productAdjustment.toString();

  @override
  TaskResult<ProductAdjustment> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<ProductAdjustment> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    // return TaskResult.tryCatch(() async {
    //   final response = await collection.create(
    //     body: payload,
    //     files: files,
    //     expand: expand,
    //   );
    //   return mapToData(response.toJson());
    // }, Failure.handle);
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final bProductAdjustments =
          batch.collection(PocketBaseCollections.productAdjustments);
      final bProducts = batch.collection(PocketBaseCollections.products);
      final bProductStocks =
          batch.collection(PocketBaseCollections.productStocks);

      bProductAdjustments.create(
        body: payload,
        files: files,
        expand: expand,
      );

      final type = ProductAdjustmentType.values
          .firstWhere((e) => e.name == payload[ProductAdjustmentField.type]);

      if (type == ProductAdjustmentType.product) {
        bProducts.update(
          payload[ProductAdjustmentField.product],
          body: {
            ProductField.quantity: payload[ProductAdjustmentField.newValue]
          },
        );
      }

      if (type == ProductAdjustmentType.productStock) {
        bProductStocks.update(
          payload[ProductAdjustmentField.productStock],
          body: {
            ProductField.quantity: payload[ProductAdjustmentField.newValue]
          },
        );
      }

      final result = await batch.send();
      return ProductAdjustment.fromMap(result[0].body);
    }, Failure.handle);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<ProductAdjustment>> list({
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
        items: result.items.map<ProductAdjustment>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<ProductAdjustment> update(
    ProductAdjustment product,
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
      final batchCollection =
          batch.collection(PocketBaseCollections.productAdjustments);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<ProductAdjustment>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          expand: expand,
          sort: sort,
        );
        return result
            .map<ProductAdjustment>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
