import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/product_lot.dart';
import '../dto/product_lot_dto.dart';

part 'product_lot_repository.g.dart';

/// Repository interface for product lot operations.
abstract class ProductLotRepository {
  /// Fetches all lots for a product.
  FutureEither<List<ProductLot>> fetchByProduct(String productId);

  /// Fetches a single lot by ID.
  FutureEither<ProductLot> fetchOne(String id);

  /// Creates a new lot.
  FutureEither<ProductLot> create(ProductLot lot);

  /// Updates an existing lot.
  FutureEither<ProductLot> update(ProductLot lot);

  /// Soft deletes a lot (sets isDeleted = true).
  FutureEither<void> delete(String id);

  /// Updates quantity for a lot.
  FutureEither<ProductLot> updateQuantity(String id, num quantity);

  /// Calculates total quantity across all lots for a product.
  FutureEither<num> calculateTotalQuantity(String productId);
}

/// Provides the ProductLotRepository instance.
@Riverpod(keepAlive: true)
ProductLotRepository productLotRepository(Ref ref) {
  return ProductLotRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [ProductLotRepository] using PocketBase.
class ProductLotRepositoryImpl implements ProductLotRepository {
  final PocketBase _pb;

  ProductLotRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.productLots);

  ProductLot _toEntity(RecordModel record) {
    final dto = ProductLotDto.fromRecord(record);
    return dto.toEntity();
  }

  @override
  FutureEither<List<ProductLot>> fetchByProduct(String productId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter()
            .notDeleted()
            .equals('product', productId)
            .build();

        final records = await _collection.getFullList(
          filter: filter,
          sort: '-created',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductLot> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Lot ID cannot be empty',
            null,
            'invalid_lot_id',
          );
        }

        final record = await _collection.getOne(id);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductLot> create(ProductLot lot) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'product': lot.productId,
          'lotNumber': lot.lotNumber,
          'quantity': lot.quantity,
          'expiration': lot.expiration.toUtcIso8601OrNull(),
          'notes': lot.notes,
          'isDeleted': false,
        };

        final record = await _collection.create(body: body);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductLot> update(ProductLot lot) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'product': lot.productId,
          'lotNumber': lot.lotNumber,
          'quantity': lot.quantity,
          'expiration': lot.expiration.toUtcIso8601OrNull(),
          'notes': lot.notes,
        };

        final record = await _collection.update(lot.id, body: body);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        await _collection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductLot> updateQuantity(String id, num quantity) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.update(
          id,
          body: {'quantity': quantity},
        );
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<num> calculateTotalQuantity(String productId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter()
            .notDeleted()
            .equals('product', productId)
            .build();

        final records = await _collection.getFullList(filter: filter);
        final lots = records.map(_toEntity).toList();

        return lots.fold<num>(0, (sum, lot) => sum + lot.quantity);
      },
      Failure.handle,
    ).run();
  }
}
