part of '../main.routes.dart';

/// Products Category
class ProductCategoryBranchData extends StatefulShellBranchData {
  const ProductCategoryBranchData();
}

@TypedGoRoute<ProductCategoriesPageRoute>(path: ProductCategoriesPageRoute.path)
class ProductCategoriesPageRoute extends GoRouteData {
  const ProductCategoriesPageRoute();
  static const path = '/product-categories';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoriesPage();
  }
}

@TypedGoRoute<ProductCategoryPageRoute>(path: ProductCategoryPageRoute.path)
class ProductCategoryPageRoute extends GoRouteData {
  const ProductCategoryPageRoute(this.id);
  static const path = '/product-category/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoryPage(id);
  }
}

@TypedGoRoute<ProductCategoryFormPageRoute>(
    path: ProductCategoryFormPageRoute.path)
class ProductCategoryFormPageRoute extends GoRouteData {
  const ProductCategoryFormPageRoute({this.id});
  static const path = '/form/product-category';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoryFormPage(id: id);
  }
}
