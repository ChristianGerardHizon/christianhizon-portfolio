import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/product_lot.dart';

part 'product_lot_dto.mapper.dart';

/// Data Transfer Object for ProductLot from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain ProductLot.
@MappableClass()
class ProductLotDto with ProductLotDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String product;
  final String lotNumber;
  final num quantity;
  final String? expiration;
  final String? notes;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const ProductLotDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.product,
    required this.lotNumber,
    this.quantity = 0,
    this.expiration,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory ProductLotDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return ProductLotDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      product: json['product'] as String? ?? '',
      lotNumber: json['lotNumber'] as String? ?? '',
      quantity: json['quantity'] as num? ?? 0,
      expiration: json['expiration'] as String?,
      notes: json['notes'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain ProductLot entity.
  ProductLot toEntity() {
    return ProductLot(
      id: id,
      productId: product,
      lotNumber: lotNumber,
      quantity: quantity,
      expiration: parseToLocal(expiration),
      notes: notes,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }
}
