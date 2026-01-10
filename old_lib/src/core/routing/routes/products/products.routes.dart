part of '../../main.routes.dart';

/// Products Branch - core products, inventories, stocks, categories, and adjustments
class ProductsBranchData extends StatefulShellBranchData {
  const ProductsBranchData();

  static const routes = <TypeRouteData>[
    // Products Core
    TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path),
    TypedGoRoute<ProductPageRoute>(path: ProductPageRoute.path),
    TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path),
    // Inventories
    TypedGoRoute<ProductInventoriesPageRoute>(
        path: ProductInventoriesPageRoute.path),
    // Stocks
    TypedGoRoute<ProductStockPageRoute>(path: ProductStockPageRoute.path),
    TypedGoRoute<ProductStockFormPageRoute>(
        path: ProductStockFormPageRoute.path),
    // Categories
    TypedGoRoute<ProductCategoriesPageRoute>(
        path: ProductCategoriesPageRoute.path),
    TypedGoRoute<ProductCategoryPageRoute>(path: ProductCategoryPageRoute.path),
    TypedGoRoute<ProductCategoryFormPageRoute>(
        path: ProductCategoryFormPageRoute.path),
    // Adjustments
    TypedGoRoute<ProductAdjustmentsPageRoute>(
        path: ProductAdjustmentsPageRoute.path),
    TypedGoRoute<ProductAdjustmentFormPageRoute>(
        path: ProductAdjustmentFormPageRoute.path),
  ];
}

// =============================================================================
// Products Core Routes
// =============================================================================

@TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path)
class ProductsPageRoute extends GoRouteData with $ProductsPageRoute {
  const ProductsPageRoute();
  static const path = '/products';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductsPage();
  }
}

@TypedGoRoute<ProductPageRoute>(path: ProductPageRoute.path)
class ProductPageRoute extends GoRouteData with $ProductPageRoute {
  const ProductPageRoute(this.id);
  static const path = '/products/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductPage(id);
  }
}

@TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path)
class ProductFormPageRoute extends GoRouteData with $ProductFormPageRoute {
  const ProductFormPageRoute({this.id});
  static const path = '/products/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductFormPage(id: id);
  }
}

// =============================================================================
// Inventories Routes
// =============================================================================

@TypedGoRoute<ProductInventoriesPageRoute>(
    path: ProductInventoriesPageRoute.path)
class ProductInventoriesPageRoute extends GoRouteData
    with $ProductInventoriesPageRoute {
  const ProductInventoriesPageRoute();
  static const path = '/products/inventories';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductInventoriesPage();
  }
}

// =============================================================================
// Stocks Routes
// =============================================================================

@TypedGoRoute<ProductStockPageRoute>(path: ProductStockPageRoute.path)
class ProductStockPageRoute extends GoRouteData with $ProductStockPageRoute {
  const ProductStockPageRoute(this.id);
  static const path = '/products/stocks/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductStockPage(id);
  }
}

@TypedGoRoute<ProductStockFormPageRoute>(path: ProductStockFormPageRoute.path)
class ProductStockFormPageRoute extends GoRouteData
    with $ProductStockFormPageRoute {
  const ProductStockFormPageRoute({this.id, required this.productId});
  static const path = '/products/stocks/form';

  final String? id;
  final String productId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductStockFormPage(
      id: id,
      productId: productId,
    );
  }
}

// =============================================================================
// Categories Routes
// =============================================================================

@TypedGoRoute<ProductCategoriesPageRoute>(path: ProductCategoriesPageRoute.path)
class ProductCategoriesPageRoute extends GoRouteData
    with $ProductCategoriesPageRoute {
  const ProductCategoriesPageRoute();
  static const path = '/products/categories';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoriesPage();
  }
}

@TypedGoRoute<ProductCategoryPageRoute>(path: ProductCategoryPageRoute.path)
class ProductCategoryPageRoute extends GoRouteData
    with $ProductCategoryPageRoute {
  const ProductCategoryPageRoute(this.id);
  static const path = '/products/categories/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoryPage(id);
  }
}

@TypedGoRoute<ProductCategoryFormPageRoute>(
    path: ProductCategoryFormPageRoute.path)
class ProductCategoryFormPageRoute extends GoRouteData
    with $ProductCategoryFormPageRoute {
  const ProductCategoryFormPageRoute({this.id});
  static const path = '/products/categories/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoryFormPage(id: id);
  }
}

// =============================================================================
// Adjustments Routes
// =============================================================================

@TypedGoRoute<ProductAdjustmentsPageRoute>(
    path: ProductAdjustmentsPageRoute.path)
class ProductAdjustmentsPageRoute extends GoRouteData
    with $ProductAdjustmentsPageRoute {
  const ProductAdjustmentsPageRoute({this.productId, this.productStockId});
  static const path = '/products/adjustments';

  final String? productId;
  final String? productStockId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductAdjustmentsPage(
      productId: productId,
      productStockId: productStockId,
    );
  }
}

@TypedGoRoute<ProductAdjustmentFormPageRoute>(
    path: ProductAdjustmentFormPageRoute.path)
class ProductAdjustmentFormPageRoute extends GoRouteData
    with $ProductAdjustmentFormPageRoute {
  const ProductAdjustmentFormPageRoute(
      {this.id, this.productId, this.productStockId});
  static const path = '/products/adjustments/form';

  final String? id;
  final String? productId;
  final String? productStockId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductAdjustmentFormPage(
        id: id, productId: productId, productStockId: productStockId);
  }
}
