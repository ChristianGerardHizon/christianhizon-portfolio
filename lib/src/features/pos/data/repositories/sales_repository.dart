import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/sale.dart';
import '../../domain/sale_item.dart';
import '../dto/sale_dto.dart';
import '../dto/sale_item_dto.dart';

part 'sales_repository.g.dart';

abstract class SalesRepository {
  FutureEither<Sale> createSale(Sale sale, List<SaleItem> items);
  FutureEither<Sale> getSale(String id);
  FutureEither<List<Sale>> getSales({String? branchId, DateTime? date});
  FutureEither<List<SaleItem>> getSaleItems(String saleId);

  /// Fetches sales with pagination.
  FutureEitherPaginated<Sale> fetchPaginated({
    int page = 1,
    int perPage = Pagination.defaultPageSize,
    String? filter,
    String? sort,
  });

  /// Searches sales with pagination.
  FutureEitherPaginated<Sale> searchPaginated(
    String query, {
    List<String>? fields,
    int page = 1,
    int perPage = Pagination.defaultPageSize,
  });
}

@Riverpod(keepAlive: true)
SalesRepository salesRepository(Ref ref) {
  return SalesRepositoryImpl(ref.watch(pocketbaseProvider));
}

class SalesRepositoryImpl implements SalesRepository {
  final PocketBase _pb;

  SalesRepositoryImpl(this._pb);

  RecordService get _sales => _pb.collection(PocketBaseCollections.sales);
  RecordService get _saleItems =>
      _pb.collection(PocketBaseCollections.saleItems);

  Sale _toSaleEntity(RecordModel record) {
    return SaleDto.fromRecord(record).toEntity();
  }

  SaleItem _toSaleItemEntity(RecordModel record) {
    final productExpanded = record.get<RecordModel?>('expand.product');
    return SaleItemDto.fromRecord(record)
        .toEntity(productExpanded: productExpanded);
  }

  @override
  FutureEither<Sale> createSale(Sale sale, List<SaleItem> items) async {
    return TaskEither.tryCatch(
      () async {
        // 1. Create Sale Record
        final saleBody = {
          'receiptNumber': sale.receiptNumber,
          'branch': sale.branchId,
          'cashier': sale.cashierId,
          'totalAmount': sale.totalAmount,
          'paymentMethod': sale.paymentMethod,
          'status': sale.status,
          'customer': sale.patient,
          'customerName': sale.customerName,
          'paymentRef': sale.paymentRef,
          'notes': sale.notes,
        };
        final saleRecord = await _sales.create(body: saleBody);

        // 2. Create Sale Items
        // Ideally we should do this in batch or have backend logic, but for now loop
        for (final item in items) {
          final itemBody = <String, dynamic>{
            'sale': saleRecord.id, // Link to created sale
            'product': item.productId,
            'productName': item.productName,
            'quantity': item.quantity,
            'unitPrice': item.unitPrice,
            'subtotal': item.subtotal,
          };
          // Add lot fields if present (for lot-tracked products)
          if (item.productLotId != null && item.productLotId!.isNotEmpty) {
            itemBody['productLot'] = item.productLotId;
            itemBody['lotNumber'] = item.lotNumber;
          }
          await _saleItems.create(body: itemBody);
        }

        return _toSaleEntity(saleRecord);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Sale> getSale(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _sales.getOne(id);
        return _toSaleEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<Sale>> getSales({String? branchId, DateTime? date}) async {
    return TaskEither.tryCatch(
      () async {
        var filter = '';
        if (branchId != null) {
          filter = 'branch = "$branchId"';
        }

        if (date != null) {
          // Assuming we want sales for that specific day
          final start = DateTime(date.year, date.month, date.day);
          final end = start.add(const Duration(days: 1));
          final dateFilter =
              'created >= "${start.toUtcIso8601()}" && created < "${end.toUtcIso8601()}"';

          if (filter.isNotEmpty) {
            filter = '$filter && $dateFilter';
          } else {
            filter = dateFilter;
          }
        }

        final records = await _sales.getFullList(
          filter: filter.isEmpty ? null : filter,
          sort: '-created',
        );
        return records.map(_toSaleEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<SaleItem>> getSaleItems(String saleId) async {
    return TaskEither.tryCatch(
      () async {
        final records = await _saleItems.getFullList(
          filter: 'sale = "$saleId"',
          expand: 'product',
        );
        return records.map(_toSaleItemEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEitherPaginated<Sale> fetchPaginated({
    int page = 1,
    int perPage = Pagination.defaultPageSize,
    String? filter,
    String? sort,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final result = await _sales.getList(
          page: page,
          perPage: perPage,
          filter: filter,
          sort: sort ?? '-created',
        );

        return PaginatedResult<Sale>(
          items: result.items.map(_toSaleEntity).toList(),
          page: result.page,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEitherPaginated<Sale> searchPaginated(
    String query, {
    List<String>? fields,
    int page = 1,
    int perPage = Pagination.defaultPageSize,
  }) async {
    return TaskEither.tryCatch(
      () async {
        // Use PBFilter for multi-field OR search
        final searchFields = fields ?? ['receiptNumber'];
        final filter = PBFilter().searchFields(query, searchFields).build();

        final result = await _sales.getList(
          page: page,
          perPage: perPage,
          filter: filter,
          sort: '-created',
        );

        return PaginatedResult<Sale>(
          items: result.items.map(_toSaleEntity).toList(),
          page: result.page,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.handle,
    ).run();
  }
}
