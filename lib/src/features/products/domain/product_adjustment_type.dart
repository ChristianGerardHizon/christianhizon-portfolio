import 'package:dart_mappable/dart_mappable.dart';

part 'product_adjustment_type.mapper.dart';

/// Type of stock adjustment.
///
/// Determines whether the adjustment is for a product directly
/// or for a specific product lot/stock.
@MappableEnum()
enum ProductAdjustmentType {
  /// Adjustment to Product.quantity directly.
  product,

  /// Adjustment to ProductLot/ProductStock.quantity.
  productStock;

  /// Display name for the adjustment type.
  String get displayName {
    switch (this) {
      case ProductAdjustmentType.product:
        return 'Product';
      case ProductAdjustmentType.productStock:
        return 'Lot';
    }
  }
}
