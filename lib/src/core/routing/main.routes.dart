import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/pages/more_page.dart';
import 'package:gym_system/src/core/pages/not_found_page.dart';
import 'package:gym_system/src/core/pages/splash_page.dart';
import 'package:gym_system/src/core/pages/app_root.dart';
import 'package:gym_system/src/core/pages/work_in_progress_page.dart';
import 'package:gym_system/src/features/admins/presentation/pages/admin_page.dart';
import 'package:gym_system/src/features/admins/presentation/pages/admin_form_page.dart';
import 'package:gym_system/src/features/admins/presentation/pages/admins_page.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_recovery_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/admin_login_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/email_validation_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/user_login_page.dart';
import 'package:gym_system/src/features/branches/presentation/pages/branch_form_page.dart';
import 'package:gym_system/src/features/branches/presentation/pages/branch_page.dart';
import 'package:gym_system/src/features/branches/presentation/pages/branches_page.dart';
import 'package:gym_system/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_record_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patients_form_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/treatment_record_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patients_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/product/product_add_stock_form_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/product/product_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/product/products_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/product/product_form_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/inventory/product_inventories_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/stock/product_stock_form_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/stock/product_stock_page.dart';
import 'package:gym_system/src/features/settings/presentation/pages/domain_page.dart';
import 'package:gym_system/src/features/settings/presentation/pages/settings_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/user_form_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/user_page.dart';
import 'package:gym_system/src/features/users/presentation/pages/users_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/your_account_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'main.routes.g.dart';
part 'routes/admins.routes.dart';
part 'routes/branches.routes.dart';
part 'routes/authentication.routes.dart';
part 'routes/users.routes.dart';
part 'routes/settings.routes.dart';
part 'routes/patients.routes.dart';
part 'routes/dashboard.routes.dart';
part 'routes/others.routes.dart';
part 'routes/sales.routes.dart';
part 'routes/products.routes.dart';
part 'routes/patient_records.routes.dart';
part 'routes/patient_treatment_records.routes.dart';
part 'routes/appointments.routes.dart';

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
        TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path),
        TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path),
        TypedGoRoute<PatientPatientRecordPageRoute>(
          path: PatientPatientRecordPageRoute.path,
        ),
      ],
    ),

    ///
    /// Products
    ///
    TypedStatefulShellBranch<ProductsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path),
        TypedGoRoute<ProductInventoriesPageRoute>(
            path: ProductInventoriesPageRoute.path),
        TypedGoRoute<ProductPageRoute>(path: ProductPageRoute.path),
        TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path),
        TypedGoRoute<ProductStockFormPageRoute>(
            path: ProductStockFormPageRoute.path),
        TypedGoRoute<ProductStockPageRoute>(path: ProductStockPageRoute.path),
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
    /// Sales Cashier
    ///
    TypedStatefulShellBranch<SalesCashierBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<SalesCashierPageRoute>(path: SalesCashierPageRoute.path),
      ],
    ),

    ///
    /// Branches
    ///
    TypedStatefulShellBranch<BranchesBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path),
        TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path),
        TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path),
      ],
    ),

    ///
    /// Users
    ///
    TypedStatefulShellBranch<UsersBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<UsersPageRoute>(path: UsersPageRoute.path),
        TypedGoRoute<UserPageRoute>(path: UserPageRoute.path),
        TypedGoRoute<UserFormPageRoute>(path: UserFormPageRoute.path),
      ],
    ),

    ///
    /// Admins
    ///
    TypedStatefulShellBranch<AdminsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<AdminsPageRoute>(path: AdminsPageRoute.path),
        TypedGoRoute<AdminPageRoute>(path: AdminPageRoute.path),
        TypedGoRoute<AdminFormPageRoute>(path: AdminFormPageRoute.path),
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
    /// Account
    ///
    TypedStatefulShellBranch<AuthenticationBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<YourAccountPageRoute>(path: YourAccountPageRoute.path),
      ],
    ),

    ///
    /// Appointments
    ///
    TypedStatefulShellBranch<AppointmentBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<AppointmentsPageRoute>(path: AppointmentsPageRoute.path),
      ],
    ),

    ///
    /// Medical Records
    ///
    // TypedStatefulShellBranch<PatientRecordsBranchData>(
    //   routes: <TypeRouteData>[
    //     TypedGoRoute<PatientRecordsPageRoute>(
    //         path: PatientRecordsPageRoute.path),
    //     TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path),
    //   ],
    // ),

    ///
    /// PatientTreatment Records
    ///
    TypedStatefulShellBranch<PatientTreatmentRecordsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<PatientTreatmentRecordsPageRoute>(
            path: PatientTreatmentRecordsPageRoute.path),
        TypedGoRoute<PatientTreatmentRecordPageRoute>(
            path: PatientTreatmentRecordPageRoute.path),
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

  // @override
  // FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
  //   final provider = ProviderScope.containerOf(context);
  //   final auth = await provider.read(authControllerProvider);

  //   if (auth.isLoading) return SplashPageRoute.path;

  //   return null;
  // }
}
