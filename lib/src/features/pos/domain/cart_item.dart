import 'package:dart_mappable/dart_mappable.dart';

import '../../products/domain/product.dart';

part 'cart_item.mapper.dart';

/// Cart Item domain model.
///
/// Represents a single product line item in a shopping cart.
@MappableClass()
class CartItem with CartItemMappable {
  const CartItem({
    this.id = '',
    this.cartId = '',
    this.productId = '',
    this.product,
    this.quantity = 1,
    this.customPrice,
    this.productLotId,
    this.lotNumber,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Parent Cart ID.
  final String cartId;

  /// Product ID.
  final String productId;

  /// Expanded Product (optional).
  final Product? product;

  /// Quantity.
  final num quantity;

  /// Custom price override (for variable-price products).
  final num? customPrice;

  /// Product Lot ID (for lot-tracked products).
  final String? productLotId;

  /// Lot number snapshot for display.
  final String? lotNumber;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// The effective unit price for this item.
  num get effectivePrice => customPrice ?? product?.price ?? 0;

  /// Total price of this item (quantity * effective price).
  num get total => effectivePrice * quantity;

  /// Whether this item uses a custom price.
  bool get hasCustomPrice => customPrice != null;

  /// Whether this item is from a specific lot.
  bool get hasLot => productLotId != null && productLotId!.isNotEmpty;
}
