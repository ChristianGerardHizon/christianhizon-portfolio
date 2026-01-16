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

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Total price of this item (quantity * product price).
  num get total => (product?.price ?? 0) * quantity;
}
