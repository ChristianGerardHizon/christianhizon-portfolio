import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/pages/home_page.dart';
import 'package:gym_system/src/core/pages/not_found_page.dart';
import 'package:gym_system/src/core/pages/splash_page.dart';
import 'package:gym_system/src/core/pages/app_root.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_recovery_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/login_page.dart';
import 'package:gym_system/src/features/settings/presentation/domain_page.dart';
import 'package:gym_system/src/features/settings/presentation/settings_page.dart';
import 'package:gym_system/src/features/user/presentation/pages/user_page.dart';
import 'package:gym_system/src/features/user/presentation/pages/user_update_page.dart';

part 'main.routes.g.dart';
part 'routes/authentication.routes.dart';
part 'routes/user.routes.dart';
part 'routes/settings.routes.dart';

typedef TypeRouteData = TypedRoute<RouteData>;

typedef RootRoute = HomePageRoute;

final rootKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@TypedGoRoute<NotFoundRoute>(path: NotFoundRoute.path)
class NotFoundRoute extends GoRouteData {
  const NotFoundRoute();
  static const path = '/not-found';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotFoundPage();
  }
}

@TypedGoRoute<SplashPageRoute>(path: SplashPageRoute.path)
class SplashPageRoute extends GoRouteData {
  const SplashPageRoute();
  static const path = '/splash';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

@TypedGoRoute<HomePageRoute>(path: HomePageRoute.path)
class HomePageRoute extends GoRouteData {
  const HomePageRoute();
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return YourUserPageRoute.path;
  }
}

@TypedStatefulShellRoute<RootRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    ///
    ///
    ///
    TypedStatefulShellBranch<UserBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<YourUserPageRoute>(path: YourUserPageRoute.path),
      ],
    ),
  ],
)
class RootRouteData extends StatefulShellRouteData {
  const RootRouteData();

  static const String $restorationScopeId = 'restorationScopeId';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => AppRoot(shell: navigationShell, state: state);
}
