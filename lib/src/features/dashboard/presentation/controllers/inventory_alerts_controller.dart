import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../products/data/repositories/product_lot_repository.dart';
import '../../../products/data/repositories/product_repository.dart';
import '../../../products/domain/product.dart';
import '../../../products/domain/product_lot.dart';
import '../../domain/inventory_alert.dart';

part 'inventory_alerts_controller.g.dart';

/// Provides comprehensive inventory alerts considering both
/// lot-tracked and non-lot-tracked products.
///
/// This provider:
/// 1. Fetches all products and all lots in parallel (2 queries total)
/// 2. Groups lots by product ID for efficient lookup
/// 3. Computes alerts for each product type correctly
@riverpod
Future<InventoryAlertsSummary> inventoryAlertsSummary(Ref ref) async {
  // Fetch products and lots
  final productsResult = await ref.read(productRepositoryProvider).fetchAll();
  final lotsResult = await ref.read(productLotRepositoryProvider).fetchAll();

  // Handle errors gracefully
  final products = productsResult.fold(
    (failure) => <Product>[],
    (data) => data,
  );
  final allLots = lotsResult.fold(
    (failure) => <ProductLot>[],
    (data) => data,
  );

  // Group lots by product ID for O(1) lookup
  final lotsByProductId = <String, List<ProductLot>>{};
  for (final lot in allLots) {
    lotsByProductId.putIfAbsent(lot.productId, () => []).add(lot);
  }

  final lowStockAlerts = <InventoryAlert>[];
  final nearExpirationAlerts = <InventoryAlert>[];
  final expiredAlerts = <InventoryAlert>[];

  final now = DateTime.now();

  for (final product in products) {
    if (product.trackByLot) {
      // Handle lot-tracked products
      final productLots = lotsByProductId[product.id] ?? [];

      // Low stock: sum all lot quantities
      final totalQuantity = productLots.fold<num>(
        0,
        (sum, lot) => sum + lot.quantity,
      );

      if (product.stockThreshold != null &&
          totalQuantity <= product.stockThreshold!) {
        lowStockAlerts.add(InventoryAlert(
          productId: product.id,
          productName: product.name,
          alertType: InventoryAlertType.lowStock,
          isLotTracked: true,
          currentQuantity: totalQuantity,
          threshold: product.stockThreshold,
        ));
      }

      // Expiration: check each lot individually
      for (final lot in productLots) {
        if (lot.expiration == null) continue;

        final daysUntil = lot.expiration!.difference(now).inDays;

        if (lot.isExpired) {
          expiredAlerts.add(InventoryAlert(
            productId: product.id,
            productName: product.name,
            alertType: InventoryAlertType.expired,
            isLotTracked: true,
            lotId: lot.id,
            lotNumber: lot.lotNumber,
            currentQuantity: lot.quantity,
            expirationDate: lot.expiration,
            daysUntilExpiration: daysUntil,
          ));
        } else if (lot.isNearExpiration) {
          nearExpirationAlerts.add(InventoryAlert(
            productId: product.id,
            productName: product.name,
            alertType: InventoryAlertType.nearExpiration,
            isLotTracked: true,
            lotId: lot.id,
            lotNumber: lot.lotNumber,
            currentQuantity: lot.quantity,
            expirationDate: lot.expiration,
            daysUntilExpiration: daysUntil,
          ));
        }
      }
    } else {
      // Handle non-lot-tracked products (existing logic)

      // Low stock
      if (product.isLowStock) {
        lowStockAlerts.add(InventoryAlert(
          productId: product.id,
          productName: product.name,
          alertType: InventoryAlertType.lowStock,
          isLotTracked: false,
          currentQuantity: product.quantity,
          threshold: product.stockThreshold,
        ));
      }

      // Near expiration
      if (product.isNearExpiration) {
        nearExpirationAlerts.add(InventoryAlert(
          productId: product.id,
          productName: product.name,
          alertType: InventoryAlertType.nearExpiration,
          isLotTracked: false,
          expirationDate: product.expiration,
          daysUntilExpiration: product.daysUntilExpiration,
        ));
      }

      // Expired
      if (product.isExpired) {
        expiredAlerts.add(InventoryAlert(
          productId: product.id,
          productName: product.name,
          alertType: InventoryAlertType.expired,
          isLotTracked: false,
          expirationDate: product.expiration,
          daysUntilExpiration: product.daysUntilExpiration,
        ));
      }
    }
  }

  // Sort alerts by severity/urgency
  lowStockAlerts.sort(
      (a, b) => (a.currentQuantity ?? 0).compareTo(b.currentQuantity ?? 0));
  nearExpirationAlerts.sort((a, b) =>
      (a.daysUntilExpiration ?? 999).compareTo(b.daysUntilExpiration ?? 999));
  expiredAlerts.sort((a, b) =>
      (a.daysUntilExpiration ?? 0).compareTo(b.daysUntilExpiration ?? 0));

  return InventoryAlertsSummary(
    lowStockAlerts: lowStockAlerts,
    nearExpirationAlerts: nearExpirationAlerts,
    expiredAlerts: expiredAlerts,
  );
}

/// Count of low stock products (including lot-tracked).
@riverpod
Future<int> lowStockAlertsCount(Ref ref) async {
  final summary = await ref.watch(inventoryAlertsSummaryProvider.future);
  return summary.lowStockCount;
}

/// Count of products/lots near expiration.
@riverpod
Future<int> nearExpirationAlertsCount(Ref ref) async {
  final summary = await ref.watch(inventoryAlertsSummaryProvider.future);
  return summary.nearExpirationCount;
}

/// Count of expired products/lots.
@riverpod
Future<int> expiredAlertsCount(Ref ref) async {
  final summary = await ref.watch(inventoryAlertsSummaryProvider.future);
  return summary.expiredCount;
}

/// List of low stock alerts for display.
@riverpod
Future<List<InventoryAlert>> lowStockAlerts(Ref ref) async {
  final summary = await ref.watch(inventoryAlertsSummaryProvider.future);
  return summary.lowStockAlerts;
}

/// List of near expiration alerts for display.
@riverpod
Future<List<InventoryAlert>> nearExpirationAlerts(Ref ref) async {
  final summary = await ref.watch(inventoryAlertsSummaryProvider.future);
  return summary.nearExpirationAlerts;
}

/// List of expired alerts for display.
@riverpod
Future<List<InventoryAlert>> expiredAlerts(Ref ref) async {
  final summary = await ref.watch(inventoryAlertsSummaryProvider.future);
  return summary.expiredAlerts;
}
