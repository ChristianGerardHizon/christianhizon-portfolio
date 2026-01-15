import 'package:dart_mappable/dart_mappable.dart';

part 'product_lot.mapper.dart';

/// ProductLot domain model.
///
/// Represents a batch/lot of a product with its own quantity and expiration.
/// Used when a product has trackByLot enabled for inventory management.
@MappableClass()
class ProductLot with ProductLotMappable {
  const ProductLot({
    required this.id,
    required this.productId,
    required this.lotNumber,
    this.quantity = 0,
    this.expiration,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Product FK ID.
  final String productId;

  /// Lot/batch number identifier.
  final String lotNumber;

  /// Quantity in this lot.
  final num quantity;

  /// Expiration date of this lot.
  final DateTime? expiration;

  /// Optional notes for this lot.
  final String? notes;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns true if this lot is expired.
  bool get isExpired {
    if (expiration == null) return false;
    return expiration!.isBefore(DateTime.now());
  }

  /// Returns true if this lot is out of stock.
  bool get isOutOfStock => quantity <= 0;

  /// Returns true if this lot has quantity available.
  bool get hasStock => quantity > 0;

  /// Formatted quantity display.
  String get quantityDisplay => quantity.toStringAsFixed(0);
}
