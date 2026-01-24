import 'package:dart_mappable/dart_mappable.dart';

part 'inventory_report.mapper.dart';

/// Aggregated product/inventory data for reporting.
@MappableClass()
class InventoryReport with InventoryReportMappable {
  const InventoryReport({
    required this.totalProducts,
    required this.inStockCount,
    required this.lowStockCount,
    required this.outOfStockCount,
    required this.expiredCount,
    required this.nearExpirationCount,
    required this.totalInventoryValue,
    required this.productsByCategory,
    required this.stockStatusBreakdown,
    required this.lowStockItems,
  });

  final int totalProducts;
  final int inStockCount;
  final int lowStockCount;
  final int outOfStockCount;
  final int expiredCount;
  final int nearExpirationCount;

  /// Total value of inventory (quantity * price).
  final num totalInventoryValue;

  /// Product count by category (for pie/bar chart).
  final Map<String, int> productsByCategory;

  /// Stock status breakdown (for pie chart).
  final Map<String, int> stockStatusBreakdown;

  /// List of low stock items for the table.
  final List<LowStockItem> lowStockItems;

  /// Empty report for initial/error states.
  static const empty = InventoryReport(
    totalProducts: 0,
    inStockCount: 0,
    lowStockCount: 0,
    outOfStockCount: 0,
    expiredCount: 0,
    nearExpirationCount: 0,
    totalInventoryValue: 0,
    productsByCategory: {},
    stockStatusBreakdown: {},
    lowStockItems: [],
  );
}

/// Low stock item for display in table.
@MappableClass()
class LowStockItem with LowStockItemMappable {
  const LowStockItem({
    required this.productName,
    required this.categoryName,
    required this.currentStock,
    required this.threshold,
    required this.expirationDate,
  });

  final String productName;
  final String categoryName;
  final num currentStock;
  final num threshold;
  final DateTime? expirationDate;
}
