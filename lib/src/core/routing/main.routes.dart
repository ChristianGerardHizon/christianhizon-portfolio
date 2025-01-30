import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/pages/more_page.dart';
import 'package:gym_system/src/core/pages/not_found_page.dart';
import 'package:gym_system/src/core/pages/splash_page.dart';
import 'package:gym_system/src/core/pages/app_root.dart';
import 'package:gym_system/src/features/admins/presentation/pages/admins_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_recovery_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/admin_login_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/staff_login_page.dart';
import 'package:gym_system/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_create_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_update_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patients_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/products_page.dart';
import 'package:gym_system/src/features/sales/presentation/pages/sales_page.dart';
import 'package:gym_system/src/features/settings/presentation/pages/domain_page.dart';
import 'package:gym_system/src/features/settings/presentation/pages/settings_page.dart';
import 'package:gym_system/src/features/staff/presentation/pages/staff_create_page.dart';
import 'package:gym_system/src/features/staff/presentation/pages/staff_page.dart';
import 'package:gym_system/src/features/staff/presentation/pages/staff_update_page.dart';
import 'package:gym_system/src/features/staff/presentation/pages/staffs_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/user_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/user_update_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/users_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/your_user_page.dart';

part 'main.routes.g.dart';
part 'routes/admins.routes.dart';
part 'routes/authentication.routes.dart';
part 'routes/users.routes.dart';
part 'routes/settings.routes.dart';
part 'routes/patients.routes.dart';
part 'routes/dashboard.routes.dart';
part 'routes/staff.routes.dart';
part 'routes/others.routes.dart';
part 'routes/sales.routes.dart';
part 'routes/products.routes.dart';

typedef TypeRouteData = TypedRoute<RouteData>;

typedef RootRoute = DashboardPageRoute;

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

// @TypedGoRoute<HomePageRoute>(path: HomePageRoute.path)
// class HomePageRoute extends GoRouteData {
//   const HomePageRoute();
//   static const path = '/';

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const HomePage();
//   }

//   @override
//   String? redirect(BuildContext context, GoRouterState state) {
//     return UsersPageRoute.path;
//   }
// }

@TypedStatefulShellRoute<RootRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    ///
    /// dashboard
    ///
    TypedStatefulShellBranch<DashboardBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<DashboardPageRoute>(path: DashboardPageRoute.path),
      ],
    ),

    ///
    /// patients
    ///
    TypedStatefulShellBranch<PatientsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path),
        TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path),
        TypedGoRoute<PatientUpdatePageRoute>(path: PatientUpdatePageRoute.path),
        TypedGoRoute<PatientCreatePageRoute>(path: PatientCreatePageRoute.path),
      ],
    ),

    ///
    /// Products
    ///
    TypedStatefulShellBranch<ProductsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path),
      ],
    ),

    ///
    /// Sales
    ///
    TypedStatefulShellBranch<SalesBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<SalesPageRoute>(path: SalesPageRoute.path),
      ],
    ),

    ///
    /// Staffs
    ///
    TypedStatefulShellBranch<StaffBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<StaffsPageRoute>(path: StaffsPageRoute.path),
        TypedGoRoute<StaffsPageRoute>(path: StaffsPageRoute.path),
        TypedGoRoute<StaffUpdatePageRoute>(path: StaffUpdatePageRoute.path),
        TypedGoRoute<StaffCreatePageRoute>(path: StaffCreatePageRoute.path),
      ],
    ),

    ///
    /// Settings
    ///
    TypedStatefulShellBranch<SettingsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<SettingsPageRoute>(path: SettingsPageRoute.path),
      ],
    ),

    ///
    /// Users
    ///
    TypedStatefulShellBranch<UsersBranchData>(
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
  ) =>
      AppRoot(shell: navigationShell, state: state);
}
