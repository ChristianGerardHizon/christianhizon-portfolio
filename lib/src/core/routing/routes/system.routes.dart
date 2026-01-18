import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/settings/presentation/pages/branches_page.dart';
import '../../../features/settings/presentation/pages/breeds_page.dart';
import '../../../features/settings/presentation/pages/product_categories_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/settings/presentation/pages/species_page.dart';

part 'system.routes.g.dart';

/// System settings page route.
@TypedGoRoute<SystemRoute>(
  path: SystemRoute.path,
  routes: [
    TypedGoRoute<BranchesRoute>(path: 'branches'),
    TypedGoRoute<SpeciesRoute>(path: 'species'),
    TypedGoRoute<BreedsRoute>(path: 'breeds'),
    TypedGoRoute<ProductCategoriesRoute>(path: 'product-categories'),
  ],
)
class SystemRoute extends GoRouteData with $SystemRoute {
  const SystemRoute();

  static const path = '/system';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

/// Branches management route.
class BranchesRoute extends GoRouteData with $BranchesRoute {
  const BranchesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BranchesPage();
  }
}

/// Species management route.
class SpeciesRoute extends GoRouteData with $SpeciesRoute {
  const SpeciesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SpeciesPage();
  }
}

/// Breeds management route.
class BreedsRoute extends GoRouteData with $BreedsRoute {
  const BreedsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BreedsPage();
  }
}

/// Product categories management route.
class ProductCategoriesRoute extends GoRouteData with $ProductCategoriesRoute {
  const ProductCategoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductCategoriesPage();
  }
}
