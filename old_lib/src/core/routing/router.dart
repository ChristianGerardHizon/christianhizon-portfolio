import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';
import 'package:sannjosevet/src/core/utils/router_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'main.routes.dart';

part 'router.g.dart';

typedef TypeRouteData = TypedRoute<RouteData>;

typedef RootRoute = DashboardPageRoute;

final rootKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: RootRoute.path,
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    redirect: (context, state) => RouterUtils.redirect(context, state, ref),
    routes: $appRoutes,
    errorBuilder: RouterUtils.errorBuilder,
  );
}
