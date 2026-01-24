import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/reports/presentation/pages/reports_page.dart';

part 'reports.routes.g.dart';

/// Reports page route.
@TypedGoRoute<ReportsRoute>(path: ReportsRoute.path)
class ReportsRoute extends GoRouteData with $ReportsRoute {
  const ReportsRoute();

  static const path = '/reports';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ReportsPage();
  }
}
