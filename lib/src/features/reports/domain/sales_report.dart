import 'package:dart_mappable/dart_mappable.dart';

part 'sales_report.mapper.dart';

/// Aggregated sales data for a time period.
@MappableClass()
class SalesReport with SalesReportMappable {
  const SalesReport({
    required this.totalRevenue,
    required this.transactionCount,
    required this.averageTransactionValue,
    required this.revenueByDay,
    required this.revenueByPaymentMethod,
    required this.topSellingProducts,
  });

  /// Total revenue in the period.
  final num totalRevenue;

  /// Number of transactions.
  final int transactionCount;

  /// Average transaction value.
  final num averageTransactionValue;

  /// Revenue grouped by day (for line chart).
  final List<DailyRevenue> revenueByDay;

  /// Revenue grouped by payment method (for pie chart).
  final Map<String, num> revenueByPaymentMethod;

  /// Top selling products with quantities (for bar chart).
  final List<ProductSalesSummary> topSellingProducts;

  /// Empty report for initial/error states.
  static const empty = SalesReport(
    totalRevenue: 0,
    transactionCount: 0,
    averageTransactionValue: 0,
    revenueByDay: [],
    revenueByPaymentMethod: {},
    topSellingProducts: [],
  );
}

/// Revenue for a single day.
@MappableClass()
class DailyRevenue with DailyRevenueMappable {
  const DailyRevenue({
    required this.date,
    required this.amount,
  });

  final DateTime date;
  final num amount;
}

/// Summary of product sales.
@MappableClass()
class ProductSalesSummary with ProductSalesSummaryMappable {
  const ProductSalesSummary({
    required this.productName,
    required this.quantity,
    required this.revenue,
  });

  final String productName;
  final num quantity;
  final num revenue;
}
