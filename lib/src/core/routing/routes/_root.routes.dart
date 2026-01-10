import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/routing/router.dart';

/// Root routes configuration with 8 consolidated branches
class RootRoutes {
  static const branches = <TypedStatefulShellBranch<StatefulShellBranchData>>[
    /// Dashboard - main entry point
    TypedStatefulShellBranch<DashboardBranchData>(
      routes: DashboardBranchData.routes,
    ),

    /// Patients - core patient management, records, treatment records, prescriptions, files
    TypedStatefulShellBranch<PatientsBranchData>(
      routes: PatientsBranchData.routes,
    ),

    /// Patient Config - species, breeds, treatments catalog
    TypedStatefulShellBranch<PatientConfigBranchData>(
      routes: PatientConfigBranchData.routes,
    ),

    /// Products - products, inventories, stocks, categories, adjustments
    TypedStatefulShellBranch<ProductsBranchData>(
      routes: ProductsBranchData.routes,
    ),

    /// Appointments - schedules, calendar view
    TypedStatefulShellBranch<AppointmentsBranchData>(
      routes: AppointmentsBranchData.routes,
    ),

    /// Organization - admins, users, branches
    TypedStatefulShellBranch<OrganizationBranchData>(
      routes: OrganizationBranchData.routes,
    ),

    /// System - settings, domain, change-logs, account
    TypedStatefulShellBranch<SystemBranchData>(
      routes: SystemBranchData.routes,
    ),

    /// Sales - cashier, sales
    TypedStatefulShellBranch<SalesCashierBranchData>(
      routes: SalesCashierBranchData.routes,
    ),
  ];
}
