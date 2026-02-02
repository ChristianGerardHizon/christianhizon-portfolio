/// PocketBase collection names used throughout the application.
///
/// Centralizes collection name constants to avoid typos and
/// make refactoring easier.
abstract class PocketBaseCollections {
  // Authentication
  static const String users = 'users';
  static const String userRoles = 'userRoles';

  // Organization
  static const String branches = 'branches';
  static const String printerConfigs = 'printerConfigs';

  // Products
  static const String products = 'products';
  static const String productCategories = 'productCategories';
  static const String productStocks = 'productStocks';
  static const String productLots = 'productLots';
  static const String productAdjustments = 'productAdjustments';

  // Services
  static const String services = 'services';
  static const String serviceCategories = 'serviceCategories';

  // Carts
  static const String carts = 'carts';
  static const String cartItems = 'cartItems';
  static const String cartServiceItems = 'cartServiceItems';

  // Sales
  static const String sales = 'sales';
  static const String saleItems = 'saleItems';
  static const String saleServiceItems = 'saleServiceItems';

  // View Collections (SQL Views for optimized queries)
  static const String vwInventoryStatus = 'vw_inventory_status';
  static const String vwSalesDailySummary = 'vw_sales_daily_summary';
  static const String vwTopSellingProducts = 'vw_top_selling_products';
  static const String vwTodaysSales = 'vw_todays_sales';
  static const String vwLotQuantityTotals = 'vw_lot_quantity_totals';
  static const String vwLowStockProducts = 'vw_low_stock_products';
  static const String vwLowStockLotProducts = 'vw_low_stock_lot_products';
  static const String vwExpiredLots = 'vw_expired_lots';
  static const String vwNearExpirationLots = 'vw_near_expiration_lots';
}
