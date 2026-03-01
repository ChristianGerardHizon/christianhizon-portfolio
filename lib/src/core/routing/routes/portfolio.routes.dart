import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/portfolio/presentation/pages/all_projects_page.dart';
import '../../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../../features/portfolio/presentation/pages/project_detail_page.dart';

part 'portfolio.routes.g.dart';

/// Public portfolio page route - shown at root `/`.
@TypedGoRoute<PortfolioRoute>(path: PortfolioRoute.path)
class PortfolioRoute extends GoRouteData with $PortfolioRoute {
  const PortfolioRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PortfolioPage();
  }
}

/// Public all projects page route.
@TypedGoRoute<AllProjectsRoute>(path: AllProjectsRoute.path)
class AllProjectsRoute extends GoRouteData with $AllProjectsRoute {
  const AllProjectsRoute();

  static const path = '/projects';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AllProjectsPage();
  }
}

/// Public project detail page route.
@TypedGoRoute<ProjectDetailRoute>(path: ProjectDetailRoute.path)
class ProjectDetailRoute extends GoRouteData with $ProjectDetailRoute {
  const ProjectDetailRoute({required this.id});

  final String id;

  static const path = '/projects/:id';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProjectDetailPage(id: id);
  }
}
