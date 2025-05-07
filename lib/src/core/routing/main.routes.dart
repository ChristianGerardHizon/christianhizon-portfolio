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
import 'package:gym_system/src/features/appointment_schedules/presentation/pages/appointment_schedule_form_page.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/pages/appointment_schedule_page.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/pages/appointment_schedules_page.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/account_recovery_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/admin_login_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/email_validation_page.dart';
import 'package:gym_system/src/features/authentication/presentation/pages/user_login_page.dart';
import 'package:gym_system/src/features/branches/presentation/pages/branch_form_page.dart';
import 'package:gym_system/src/features/branches/presentation/pages/branch_page.dart';
import 'package:gym_system/src/features/branches/presentation/pages/branches_page.dart';
import 'package:gym_system/src/features/change_logs/presentation/pages/change_log_form_page.dart';
import 'package:gym_system/src/features/change_logs/presentation/pages/change_log_page.dart';
import 'package:gym_system/src/features/change_logs/presentation/pages/change_logs_page.dart';
import 'package:gym_system/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:gym_system/src/features/patient_files/presentation/presentation/pages/patient_file_form_page.dart';
import 'package:gym_system/src/features/patient_prescription_items/presentation/pages/patient_prescription_item_form_page.dart';
import 'package:gym_system/src/features/patient_records/presentation/pages/patient_record_form_page.dart';
import 'package:gym_system/src/features/patient_records/presentation/pages/patient_record_page.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/pages/patient_treatment_record_form_page.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/pages/patient_treatment_record_page.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/pages/patient_treatment_records_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_form_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patient_page.dart';
import 'package:gym_system/src/features/patients/presentation/pages/patients_page.dart';
import 'package:gym_system/src/features/product_categories/presentation/pages/product_categories_page.dart';
import 'package:gym_system/src/features/product_categories/presentation/pages/product_category_form_page.dart';
import 'package:gym_system/src/features/product_categories/presentation/pages/product_category_page.dart';
import 'package:gym_system/src/features/product_stock_adjustment/presentation/pages/product_stock_adjustment_form_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/product_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/products_page.dart';
import 'package:gym_system/src/features/products/presentation/pages/product_form_page.dart';
import 'package:gym_system/src/features/product_inventories/presentation/pages/product_inventories_page.dart';
import 'package:gym_system/src/features/product_stocks/presentation/pages/product_stock_form_page.dart';
import 'package:gym_system/src/features/product_stocks/presentation/pages/product_stock_page.dart';
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
part 'routes/appointment_schedules.routes.dart';
part 'routes/change_logs.routes.dart';
part 'routes/product_category.routes.dart';
part 'routes/patient_prescription_item.routes.dart';
part 'routes/patient_files.routes.dart';
part 'routes/product_stock_adjustments.routes.dart';

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
        ///
        /// Patient
        ///
        TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path),
        TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path),
        TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path),

        ///
        /// Patient Record
        ///
        TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path),
        TypedGoRoute<PatientRecordFormPageRoute>(
            path: PatientRecordFormPageRoute.path),

        ///
        /// Categories
        ///
        TypedGoRoute<ProductCategoriesPageRoute>(
            path: ProductCategoriesPageRoute.path),
        TypedGoRoute<ProductCategoryPageRoute>(
            path: ProductCategoryPageRoute.path),
        TypedGoRoute<ProductCategoryFormPageRoute>(
            path: ProductCategoryFormPageRoute.path),

        ///
        /// Patient Treatment
        ///
        TypedGoRoute<PatientTreatmentsRecordPageRoute>(
            path: PatientTreatmentsRecordPageRoute.path),
        TypedGoRoute<PatientTreatmentRecordPageRoute>(
            path: PatientTreatmentRecordPageRoute.path),
        TypedGoRoute<PatientTreatmentRecordFormPageRoute>(
            path: PatientTreatmentRecordFormPageRoute.path),

        ///
        /// Patient Prescription Item
        ///
        TypedGoRoute<PatientPrescriptionItemFormPageRoute>(
            path: PatientPrescriptionItemFormPageRoute.path),

        ///
        /// Appointments
        ///
        TypedGoRoute<PatientAppointmentSchedulesPageRoute>(
            path: PatientAppointmentSchedulesPageRoute.path),

        ///
        /// Files
        ///
        TypedGoRoute<PatientFileFormPageRoute>(
            path: PatientFileFormPageRoute.path),
      ],
    ),

    ///
    /// Products
    ///
    TypedStatefulShellBranch<ProductsBranchData>(
      routes: <TypeRouteData>[
        ///
        /// Products
        ///
        TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path),
        TypedGoRoute<ProductPageRoute>(path: ProductPageRoute.path),
        TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path),

        ///
        /// Inventory
        ///
        TypedGoRoute<ProductInventoriesPageRoute>(
            path: ProductInventoriesPageRoute.path),

        ///
        /// Stocks
        ///
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
    /// Calendar
    ///
    TypedStatefulShellBranch<CalendarAppointmentSchedulesData>(
      routes: <TypeRouteData>[
        TypedGoRoute<CalendarAppointmentSchedulesPageRoute>(
            path: CalendarAppointmentSchedulesPageRoute.path),
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
    /// ChangeLogs
    ///
    TypedStatefulShellBranch<ChangeLogsBranchData>(
      routes: <TypeRouteData>[
        TypedGoRoute<ChangeLogsPageRoute>(path: ChangeLogsPageRoute.path),
        TypedGoRoute<ChangeLogPageRoute>(path: ChangeLogPageRoute.path),
        TypedGoRoute<ChangeLogFormPageRoute>(path: ChangeLogFormPageRoute.path),
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
    TypedStatefulShellBranch<AppointmentSchedulesData>(
      routes: <TypeRouteData>[
        TypedGoRoute<AppointmentSchedulesPageRoute>(
            path: AppointmentSchedulesPageRoute.path),
        TypedGoRoute<AppointmentSchedulePageRoute>(
            path: AppointmentSchedulePageRoute.path),
        TypedGoRoute<AppointmentScheduleFormPageRoute>(
            path: AppointmentScheduleFormPageRoute.path),
      ],
    ),
  ],
)
class RootRouteData extends StatefulShellRouteData {
  const RootRouteData();

  static const String $restorationScopeId = 'restorationScopeId';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootKey;

  @override
  Widget builder(context, state, navigationShell) =>
      AppRoot(shell: navigationShell, state: state);
}
