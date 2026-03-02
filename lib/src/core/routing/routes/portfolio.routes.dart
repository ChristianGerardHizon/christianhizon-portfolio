import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/portfolio/presentation/pages/all_projects_page.dart';
import '../../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../../features/portfolio/presentation/pages/project_detail_page.dart';
import '../../../features/portfolio/presentation/pages/tech_stack_page.dart';
import '../../../features/portfolio/presentation/pages/work_history_page.dart';

part 'portfolio.routes.g.dart';

/// Shared page transition for portfolio routes: fade + subtle slide up.
Page<void> _buildTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Public portfolio page route - shown at root `/`.
@TypedGoRoute<PortfolioRoute>(path: PortfolioRoute.path)
class PortfolioRoute extends GoRouteData with $PortfolioRoute {
  const PortfolioRoute();

  static const path = '/';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildTransitionPage(
      key: state.pageKey,
      child: const PortfolioPage(),
    );
  }
}

/// Public all projects page route.
@TypedGoRoute<AllProjectsRoute>(path: AllProjectsRoute.path)
class AllProjectsRoute extends GoRouteData with $AllProjectsRoute {
  const AllProjectsRoute();

  static const path = '/projects';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildTransitionPage(
      key: state.pageKey,
      child: const AllProjectsPage(),
    );
  }
}

/// Public tech stack page route.
@TypedGoRoute<TechStackRoute>(path: TechStackRoute.path)
class TechStackRoute extends GoRouteData with $TechStackRoute {
  const TechStackRoute();

  static const path = '/tech-stack';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildTransitionPage(
      key: state.pageKey,
      child: const TechStackPage(),
    );
  }
}

/// Public work history page route.
@TypedGoRoute<WorkHistoryRoute>(path: WorkHistoryRoute.path)
class WorkHistoryRoute extends GoRouteData with $WorkHistoryRoute {
  const WorkHistoryRoute();

  static const path = '/work-history';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildTransitionPage(
      key: state.pageKey,
      child: const WorkHistoryPage(),
    );
  }
}

/// Public project detail page route.
@TypedGoRoute<ProjectDetailRoute>(path: ProjectDetailRoute.path)
class ProjectDetailRoute extends GoRouteData with $ProjectDetailRoute {
  const ProjectDetailRoute({required this.id});

  final String id;

  static const path = '/projects/:id';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildTransitionPage(
      key: state.pageKey,
      child: ProjectDetailPage(id: id),
    );
  }
}
