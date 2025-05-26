import 'package:sannjosevet/src/core/models/pb_repository.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/product_stocks/domain/product_stock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<ProductStock> productStockRepository(Ref ref) {
  return ProductStockRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ProductStockRepositoryImpl extends PBCollectionRepository<ProductStock> {
  final PocketBase pb;

  ProductStockRepositoryImpl({required this.pb});

  ProductStock mapToData(Map<String, dynamic> map) {
    return ProductStock.fromMap({...map, 'domain': pb.baseURL});
  }

  RecordService get collection =>
      pb.collection(PocketBaseCollections.productStocks);

  @override
  TaskResult<ProductStock> get(String id) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getOne(id);
        return mapToData(result.toJson());
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<ProductStock> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(
      () async {
        final response = await collection.create(body: payload, files: files);
        return mapToData(response.toJson());
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(
      () async {
        await collection.delete(id);
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<PageResults<ProductStock>> list({
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
        items: result.items.map<ProductStock>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<ProductStock> update(
    ProductStock history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(
      () async {
        final historyMap = history.toMap();
        final combinedMap = {...historyMap, ...update};
        final result = await collection.update(
          history.id,
          body: combinedMap,
          files: files,
        );
        return mapToData(result.toJson());
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(
      () async {
        final batch = pb.createBatch();
        final batchCollection =
            batch.collection(PocketBaseCollections.productStocks);
        for (final id in ids) {
          batchCollection.update(id, body: {ProductStockField.isDeleted: true});
        }

        await batch.send();
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<List<ProductStock>> listAll({
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
        return result.map<ProductStock>((e) => mapToData(e.toJson())).toList();
      },
      Failure.handle,
    );
  }
}
