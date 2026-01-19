import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/settings/presentation/pages/branches_page.dart';
import '../../../features/settings/presentation/pages/message_templates_page.dart';
import '../../../features/settings/presentation/pages/product_categories_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/settings/presentation/pages/species_page.dart';
import '../../../features/settings/presentation/pages/system_shell.dart';
import '../../../features/settings/presentation/widgets/branch_detail_panel.dart';
import '../../../features/settings/presentation/widgets/message_template_detail_panel.dart';
import '../../../features/settings/presentation/widgets/product_category_detail_panel.dart';
import '../../../features/settings/presentation/widgets/species_detail_panel.dart';
import '../../utils/breakpoints.dart';

part 'system.routes.g.dart';

/// System shell route for master-detail layout.
///
/// On tablet: Shows list and detail side-by-side for reference data
/// On mobile: Shows list, then navigates to detail via bottom sheet
@TypedShellRoute<SystemShellRoute>(
  routes: [
    TypedGoRoute<SystemRoute>(
      path: SystemRoute.path,
      routes: [
        // Branches with detail
        TypedGoRoute<BranchesRoute>(
          path: 'branches',
          routes: [
            TypedGoRoute<BranchDetailRoute>(path: ':id'),
          ],
        ),
        // Species with detail (breeds managed within species detail)
        TypedGoRoute<SpeciesRoute>(
          path: 'species',
          routes: [
            TypedGoRoute<SpeciesDetailRoute>(path: ':id'),
          ],
        ),
        // Product categories with detail
        TypedGoRoute<ProductCategoriesRoute>(
          path: 'product-categories',
          routes: [
            TypedGoRoute<ProductCategoryDetailRoute>(path: ':id'),
          ],
        ),
        // Message templates with detail
        TypedGoRoute<MessageTemplatesRoute>(
          path: 'message-templates',
          routes: [
            TypedGoRoute<MessageTemplateDetailRoute>(path: ':id'),
          ],
        ),
      ],
    ),
  ],
)
class SystemShellRoute extends ShellRouteData {
  const SystemShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return SystemShell(child: navigator);
  }
}

/// System settings page route.
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
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const BranchesPage();
  }
}

/// Branch detail route.
class BranchDetailRoute extends GoRouteData with $BranchDetailRoute {
  const BranchDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchDetailPanel(branchId: id);
  }
}

/// Species management route.
class SpeciesRoute extends GoRouteData with $SpeciesRoute {
  const SpeciesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const SpeciesPage();
  }
}

/// Species detail route.
class SpeciesDetailRoute extends GoRouteData with $SpeciesDetailRoute {
  const SpeciesDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SpeciesDetailPanel(speciesId: id);
  }
}

/// Product categories management route.
class ProductCategoriesRoute extends GoRouteData with $ProductCategoriesRoute {
  const ProductCategoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const ProductCategoriesPage();
  }
}

/// Product category detail route.
class ProductCategoryDetailRoute extends GoRouteData
    with $ProductCategoryDetailRoute {
  const ProductCategoryDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoryDetailPanel(categoryId: id);
  }
}

/// Message templates management route.
class MessageTemplatesRoute extends GoRouteData with $MessageTemplatesRoute {
  const MessageTemplatesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const MessageTemplatesPage();
  }
}

/// Message template detail route.
class MessageTemplateDetailRoute extends GoRouteData
    with $MessageTemplateDetailRoute {
  const MessageTemplateDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MessageTemplateDetailPanel(templateId: id);
  }
}
