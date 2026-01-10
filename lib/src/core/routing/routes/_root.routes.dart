import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/routing/router.dart';

class RootRoutes {
  static const branches = <TypedStatefulShellBranch<StatefulShellBranchData>>[
    ///
    /// dashboard
    ///
    TypedStatefulShellBranch<DashboardBranchData>(
      routes: DashboardBranchData.routes,
    ),

    ///
    /// patients
    ///
    TypedStatefulShellBranch<PatientsBranchData>(
      routes: PatientsBranchData.routes,
    ),

    ///
    /// Products
    ///
    TypedStatefulShellBranch<ProductsBranchData>(
      routes: ProductsBranchData.routes,
    ),

    /// Calendar
    ///
    TypedStatefulShellBranch<CalendarAppointmentSchedulesData>(
      routes: CalendarAppointmentSchedulesData.routes,
    ),

    ///
    /// Sales Cashier
    ///
    TypedStatefulShellBranch<SalesCashierBranchData>(
      routes: SalesCashierBranchData.routes,
    ),

    ///
    /// Branches
    ///
    TypedStatefulShellBranch<BranchesBranchData>(
      routes: BranchesBranchData.routes,
    ),

    ///
    /// Users
    ///
    TypedStatefulShellBranch<UsersBranchData>(
      routes: UsersBranchData.routes,
    ),

    ///
    /// Admins
    ///
    TypedStatefulShellBranch<AdminsBranchData>(
      routes: AdminsBranchData.routes,
    ),

    ///
    /// Settings
    ///
    TypedStatefulShellBranch<SettingsBranchData>(
      routes: SettingsBranchData.routes,
    ),

    ///
    /// ChangeLogs
    ///
    TypedStatefulShellBranch<ChangeLogsBranchData>(
      routes: ChangeLogsBranchData.routes,
    ),

    ///
    /// Account
    ///
    TypedStatefulShellBranch<AuthenticationBranchData>(
      routes: AuthenticationBranchData.routes,
    ),

    ///
    /// Appointments
    ///
    TypedStatefulShellBranch<AppointmentSchedulesData>(
      routes: AppointmentSchedulesData.routes,
    ),

    ///
    /// Species
    ///
    TypedStatefulShellBranch<PatientSpeciesBranchData>(
      routes: PatientSpeciesBranchData.routes,
    ),

    ///
    /// Breeds
    ///
    TypedStatefulShellBranch<PatientBreedsBranchData>(
      routes: PatientBreedsBranchData.routes,
    ),

    ///
    /// Stock Adjustments
    ///
    TypedStatefulShellBranch<ProductAdjustmentsBranchData>(
      routes: ProductAdjustmentsBranchData.routes,
    ),

    ///
    /// Patient Treatments
    ///
    TypedStatefulShellBranch<PatientTreatmentsBranchData>(
      routes: PatientTreatmentsBranchData.routes,
    ),
  ];
}