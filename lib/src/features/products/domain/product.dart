import 'package:dart_mappable/dart_mappable.dart';

import 'product_status.dart';

part 'product.mapper.dart';

/// Product domain model.
///
/// Represents a product/inventory item in the system.
@MappableClass()
class Product with ProductMappable {
  const Product({
    required this.id,
    required this.name,
    this.description,
    this.categoryId,
    this.categoryName,
    this.image,
    this.branch,
    this.stockThreshold,
    this.price = 0,
    this.forSale = true,
    this.requireStock = false,
    this.quantity,
    this.expiration,
    this.trackByLot = false,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Product name.
  final String name;

  /// Product description.
  final String? description;

  /// Category FK ID.
  final String? categoryId;

  /// Category name (expanded from FK).
  final String? categoryName;

  /// Product image URL (full path).
  final String? image;

  /// Branch FK ID.
  final String? branch;

  /// Low stock warning threshold.
  final num? stockThreshold;

  /// Product price.
  final num price;

  /// Whether product is for sale.
  final bool forSale;

  /// Whether stock is required to add to cart.
  /// If true and product is out of stock, it cannot be added to cart.
  final bool requireStock;

  /// Current quantity (for non-lot tracking).
  final num? quantity;

  /// Expiration date (for non-lot tracking).
  final DateTime? expiration;

  /// Whether to track inventory by lot numbers.
  final bool trackByLot;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns true if product has an image.
  bool get hasImage => image != null && image!.isNotEmpty;

  /// Returns true if product has a category.
  bool get hasCategory => categoryId != null && categoryId!.isNotEmpty;

  /// Returns true if stock is low based on threshold.
  bool get isLowStock {
    if (stockThreshold == null || quantity == null) return false;
    return quantity! <= stockThreshold!;
  }

  /// Returns true if product is expired.
  bool get isExpired {
    if (expiration == null) return false;
    return expiration!.isBefore(DateTime.now());
  }

  /// Default threshold for near expiration warning (30 days).
  static const nearExpirationDays = 30;

  /// Returns true if product is near expiration (within 30 days).
  bool get isNearExpiration {
    if (expiration == null) return false;
    if (isExpired) return false; // Already expired, not "near"
    final daysUntilExpiration = expiration!.difference(DateTime.now()).inDays;
    return daysUntilExpiration <= nearExpirationDays;
  }

  /// Returns the number of days until expiration (negative if expired).
  int? get daysUntilExpiration {
    if (expiration == null) return null;
    return expiration!.difference(DateTime.now()).inDays;
  }

  /// Returns true if product is out of stock.
  bool get isOutOfStock => quantity != null && quantity! <= 0;

  /// Calculates the stock status.
  ProductStatus get stockStatus {
    if (quantity == null) return ProductStatus.noThreshold;
    if (quantity! <= 0) return ProductStatus.outOfStock;
    if (stockThreshold != null && quantity! <= stockThreshold!) {
      return ProductStatus.lowStock;
    }
    return ProductStatus.inStock;
  }

  /// Formatted price display.
  String get priceDisplay => '₱${price.toStringAsFixed(2)}';

  /// Formatted quantity display.
  String get quantityDisplay {
    if (quantity == null) return 'N/A';
    return quantity!.toStringAsFixed(0);
  }
}
