import 'package:dart_mappable/dart_mappable.dart';

part 'cart.mapper.dart';

/// Cart domain model.
///
/// Represents a shopping session/cart.
@MappableClass()
class Cart with CartMappable {
  const Cart({
    required this.id,
    required this.branchId,
    required this.status,
    this.userId,
    this.totalAmount,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Branch ID where this cart is active.
  final String branchId;

  /// Cart status (active, converted, abandoned).
  final String status;

  /// User ID owning the cart (optional).
  final String? userId;

  /// Cached total amount.
  final num? totalAmount;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
