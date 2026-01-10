// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $notFoundRoute,
      $splashPageRoute,
      $rootRouteData,
      $adminsPageRoute,
      $adminPageRoute,
      $adminFormPageRoute,
      $branchesPageRoute,
      $branchFormPageRoute,
      $branchPageRoute,
      $loginPageRoute,
      $emailValidationPageRoute,
      $adminLoginPageRoute,
      $accountRecoveryPageRoute,
      $accountPageRoute,
      $yourAccountPageRoute,
      $usersPageRoute,
      $userPageRoute,
      $userFormPageRoute,
      $settingsPageRoute,
      $domainPageRoute,
      $patientsPageRoute,
      $patientPageRoute,
      $patientFormPageRoute,
      $dashboardPageRoute,
      $morePageRoute,
      $salesPageRoute,
      $salesCashierPageRoute,
      $productsPageRoute,
      $productInventoriesPageRoute,
      $productFormPageRoute,
      $productStockFormPageRoute,
      $productPageRoute,
      $productStockPageRoute,
      $patientRecordPageRoute,
      $patientRecordFormPageRoute,
      $patientTreatmentRecordPageRoute,
      $patientTreatmentsRecordPageRoute,
      $patientTreatmentRecordFormPageRoute,
      $patientAppointmentSchedulesPageRoute,
      $appointmentSchedulesPageRoute,
      $appointmentSchedulesByDatePageRoute,
      $appointmentScheduleFormPageRoute,
      $appointmentSchedulePageRoute,
      $calendarAppointmentSchedulesPageRoute,
      $changeLogsPageRoute,
      $changeLogPageRoute,
      $changeLogFormPageRoute,
      $productCategoriesPageRoute,
      $productCategoryPageRoute,
      $productCategoryFormPageRoute,
      $patientPrescriptionItemFormPageRoute,
      $patientFileFormPageRoute,
      $productAdjustmentsPageRoute,
      $productAdjustmentFormPageRoute,
      $patientSpeciesListPageRoute,
      $patientSpeciesFormPageRoute,
      $patientSpeciesPageRoute,
      $patientBreedFormPageRoute,
      $patientTreatmentPageRoute,
      $patientTreatmentFormPageRoute,
    ];

RouteBase get $notFoundRoute => GoRouteData.$route(
      path: '/not-found',
      factory: $NotFoundRoute._fromState,
    );

mixin $NotFoundRoute on GoRouteData {
  static NotFoundRoute _fromState(GoRouterState state) => const NotFoundRoute();

  @override
  String get location => GoRouteData.$location(
        '/not-found',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashPageRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashPageRoute._fromState,
    );

mixin $SplashPageRoute on GoRouteData {
  static SplashPageRoute _fromState(GoRouterState state) =>
      const SplashPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/splash',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rootRouteData => StatefulShellRouteData.$route(
      parentNavigatorKey: RootRouteData.$parentNavigatorKey,
      restorationScopeId: RootRouteData.$restorationScopeId,
      factory: $RootRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $DashboardPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/patients',
              factory: $PatientsPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patient',
              factory: $PatientFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/patient/:id',
              factory: $PatientPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/patientRecord/:id',
              factory: $PatientRecordPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientRecord',
              factory: $PatientRecordFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/product-categories',
              factory: $ProductCategoriesPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/product-category/:id',
              factory: $ProductCategoryPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/product-category',
              factory: $ProductCategoryFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/patientTreatmentRecords',
              factory: $PatientTreatmentsRecordPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/patientTreatmentRecord/:id',
              factory: $PatientTreatmentRecordPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientTreatmentRecord',
              factory: $PatientTreatmentRecordFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientPrescriptionItem',
              factory: $PatientPrescriptionItemFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/patient/appointmentSchedules',
              factory: $PatientAppointmentSchedulesPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientFiles',
              factory: $PatientFileFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/products',
              factory: $ProductsPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/product/:id',
              factory: $ProductPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/product',
              factory: $ProductFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/productInventories',
              factory: $ProductInventoriesPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/productStock',
              factory: $ProductStockFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/product/form/:id',
              factory: $ProductStockPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/calendar',
              factory: $CalendarAppointmentSchedulesPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/cashier',
              factory: $SalesCashierPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/branches',
              factory: $BranchesPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/branch',
              factory: $BranchFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/branch/:id',
              factory: $BranchPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/user',
              factory: $UsersPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/user/:id',
              factory: $UserPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/user',
              factory: $UserFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/admins',
              factory: $AdminsPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/admin/:id',
              factory: $AdminPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/admin',
              factory: $AdminFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/settings',
              factory: $SettingsPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/domain',
              factory: $DomainPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/changeLogs',
              factory: $ChangeLogsPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/changeLog/:id',
              factory: $ChangeLogPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/changelog',
              factory: $ChangeLogFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/your-account',
              factory: $YourAccountPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/appointmentSchedules',
              factory: $AppointmentSchedulesPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/today/appointmentSchedules',
              factory: $AppointmentSchedulesByDatePageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/appointmentSchedule/:id',
              factory: $AppointmentSchedulePageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/appointmentSchedule',
              factory: $AppointmentScheduleFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/patientSpecies',
              factory: $PatientSpeciesListPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientSpecies',
              factory: $PatientSpeciesFormPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/patientSpecies/:id',
              factory: $PatientSpeciesPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/form/patientBreeds',
              factory: $PatientBreedFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/product-adjustments',
              factory: $ProductAdjustmentsPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/product-adjustments',
              factory: $ProductAdjustmentFormPageRoute._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/patientTreatments',
              factory: $PatientTreatmentPageRoute._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientTreatments',
              factory: $PatientTreatmentFormPageRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $RootRouteDataExtension on RootRouteData {
  static RootRouteData _fromState(GoRouterState state) => const RootRouteData();
}

mixin $DashboardPageRoute on GoRouteData {
  static DashboardPageRoute _fromState(GoRouterState state) =>
      const DashboardPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientsPageRoute on GoRouteData {
  static PatientsPageRoute _fromState(GoRouterState state) =>
      const PatientsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/patients',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientFormPageRoute on GoRouteData {
  static PatientFormPageRoute _fromState(GoRouterState state) =>
      PatientFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  PatientFormPageRoute get _self => this as PatientFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patient',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientPageRoute on GoRouteData {
  static PatientPageRoute _fromState(GoRouterState state) => PatientPageRoute(
        state.pathParameters['id']!,
        page: _$convertMapValue('page', state.uri.queryParameters, int.parse) ??
            0,
      );

  PatientPageRoute get _self => this as PatientPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/patient/${Uri.encodeComponent(_self.id)}',
        queryParams: {
          if (_self.page != 0) 'page': _self.page.toString(),
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientRecordPageRoute on GoRouteData {
  static PatientRecordPageRoute _fromState(GoRouterState state) =>
      PatientRecordPageRoute(
        state.pathParameters['id']!,
      );

  PatientRecordPageRoute get _self => this as PatientRecordPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/patientRecord/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientRecordFormPageRoute on GoRouteData {
  static PatientRecordFormPageRoute _fromState(GoRouterState state) =>
      PatientRecordFormPageRoute(
        parentId: state.uri.queryParameters['parent-id']!,
        id: state.uri.queryParameters['id'],
      );

  PatientRecordFormPageRoute get _self => this as PatientRecordFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientRecord',
        queryParams: {
          'parent-id': _self.parentId,
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductCategoriesPageRoute on GoRouteData {
  static ProductCategoriesPageRoute _fromState(GoRouterState state) =>
      const ProductCategoriesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/product-categories',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductCategoryPageRoute on GoRouteData {
  static ProductCategoryPageRoute _fromState(GoRouterState state) =>
      ProductCategoryPageRoute(
        state.pathParameters['id']!,
      );

  ProductCategoryPageRoute get _self => this as ProductCategoryPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/product-category/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductCategoryFormPageRoute on GoRouteData {
  static ProductCategoryFormPageRoute _fromState(GoRouterState state) =>
      ProductCategoryFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  ProductCategoryFormPageRoute get _self =>
      this as ProductCategoryFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/product-category',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientTreatmentsRecordPageRoute on GoRouteData {
  static PatientTreatmentsRecordPageRoute _fromState(GoRouterState state) =>
      PatientTreatmentsRecordPageRoute(
        state.uri.queryParameters['id']!,
      );

  PatientTreatmentsRecordPageRoute get _self =>
      this as PatientTreatmentsRecordPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/patientTreatmentRecords',
        queryParams: {
          'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientTreatmentRecordPageRoute on GoRouteData {
  static PatientTreatmentRecordPageRoute _fromState(GoRouterState state) =>
      PatientTreatmentRecordPageRoute(
        state.pathParameters['id']!,
      );

  PatientTreatmentRecordPageRoute get _self =>
      this as PatientTreatmentRecordPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/patientTreatmentRecord/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientTreatmentRecordFormPageRoute on GoRouteData {
  static PatientTreatmentRecordFormPageRoute _fromState(GoRouterState state) =>
      PatientTreatmentRecordFormPageRoute(
        parentId: state.uri.queryParameters['parent-id']!,
        id: state.uri.queryParameters['id'],
      );

  PatientTreatmentRecordFormPageRoute get _self =>
      this as PatientTreatmentRecordFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientTreatmentRecord',
        queryParams: {
          'parent-id': _self.parentId,
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientPrescriptionItemFormPageRoute on GoRouteData {
  static PatientPrescriptionItemFormPageRoute _fromState(GoRouterState state) =>
      PatientPrescriptionItemFormPageRoute(
        parentId: state.uri.queryParameters['parent-id']!,
        id: state.uri.queryParameters['id'],
      );

  PatientPrescriptionItemFormPageRoute get _self =>
      this as PatientPrescriptionItemFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientPrescriptionItem',
        queryParams: {
          'parent-id': _self.parentId,
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientAppointmentSchedulesPageRoute on GoRouteData {
  static PatientAppointmentSchedulesPageRoute _fromState(GoRouterState state) =>
      const PatientAppointmentSchedulesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/patient/appointmentSchedules',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientFileFormPageRoute on GoRouteData {
  static PatientFileFormPageRoute _fromState(GoRouterState state) =>
      PatientFileFormPageRoute(
        parentId: state.uri.queryParameters['parent-id']!,
        id: state.uri.queryParameters['id'],
      );

  PatientFileFormPageRoute get _self => this as PatientFileFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientFiles',
        queryParams: {
          'parent-id': _self.parentId,
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductsPageRoute on GoRouteData {
  static ProductsPageRoute _fromState(GoRouterState state) =>
      const ProductsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/products',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductPageRoute on GoRouteData {
  static ProductPageRoute _fromState(GoRouterState state) => ProductPageRoute(
        state.pathParameters['id']!,
      );

  ProductPageRoute get _self => this as ProductPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/product/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductFormPageRoute on GoRouteData {
  static ProductFormPageRoute _fromState(GoRouterState state) =>
      ProductFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  ProductFormPageRoute get _self => this as ProductFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/product',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductInventoriesPageRoute on GoRouteData {
  static ProductInventoriesPageRoute _fromState(GoRouterState state) =>
      const ProductInventoriesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/productInventories',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductStockFormPageRoute on GoRouteData {
  static ProductStockFormPageRoute _fromState(GoRouterState state) =>
      ProductStockFormPageRoute(
        id: state.uri.queryParameters['id'],
        productId: state.uri.queryParameters['product-id']!,
      );

  ProductStockFormPageRoute get _self => this as ProductStockFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/productStock',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
          'product-id': _self.productId,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductStockPageRoute on GoRouteData {
  static ProductStockPageRoute _fromState(GoRouterState state) =>
      ProductStockPageRoute(
        state.pathParameters['id']!,
      );

  ProductStockPageRoute get _self => this as ProductStockPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/product/form/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CalendarAppointmentSchedulesPageRoute on GoRouteData {
  static CalendarAppointmentSchedulesPageRoute _fromState(
          GoRouterState state) =>
      const CalendarAppointmentSchedulesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/calendar',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SalesCashierPageRoute on GoRouteData {
  static SalesCashierPageRoute _fromState(GoRouterState state) =>
      const SalesCashierPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/cashier',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BranchesPageRoute on GoRouteData {
  static BranchesPageRoute _fromState(GoRouterState state) =>
      const BranchesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/branches',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BranchFormPageRoute on GoRouteData {
  static BranchFormPageRoute _fromState(GoRouterState state) =>
      BranchFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  BranchFormPageRoute get _self => this as BranchFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/branch',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BranchPageRoute on GoRouteData {
  static BranchPageRoute _fromState(GoRouterState state) => BranchPageRoute(
        state.pathParameters['id']!,
      );

  BranchPageRoute get _self => this as BranchPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/branch/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UsersPageRoute on GoRouteData {
  static UsersPageRoute _fromState(GoRouterState state) =>
      const UsersPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/user',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UserPageRoute on GoRouteData {
  static UserPageRoute _fromState(GoRouterState state) => UserPageRoute(
        state.pathParameters['id']!,
      );

  UserPageRoute get _self => this as UserPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/user/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UserFormPageRoute on GoRouteData {
  static UserFormPageRoute _fromState(GoRouterState state) => UserFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  UserFormPageRoute get _self => this as UserFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/user',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminsPageRoute on GoRouteData {
  static AdminsPageRoute _fromState(GoRouterState state) =>
      const AdminsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/admins',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminPageRoute on GoRouteData {
  static AdminPageRoute _fromState(GoRouterState state) => AdminPageRoute(
        state.pathParameters['id']!,
      );

  AdminPageRoute get _self => this as AdminPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/admin/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdminFormPageRoute on GoRouteData {
  static AdminFormPageRoute _fromState(GoRouterState state) =>
      AdminFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  AdminFormPageRoute get _self => this as AdminFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/admin',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsPageRoute on GoRouteData {
  static SettingsPageRoute _fromState(GoRouterState state) =>
      const SettingsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/settings',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DomainPageRoute on GoRouteData {
  static DomainPageRoute _fromState(GoRouterState state) =>
      const DomainPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/domain',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChangeLogsPageRoute on GoRouteData {
  static ChangeLogsPageRoute _fromState(GoRouterState state) =>
      const ChangeLogsPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/changeLogs',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChangeLogPageRoute on GoRouteData {
  static ChangeLogPageRoute _fromState(GoRouterState state) =>
      ChangeLogPageRoute(
        state.pathParameters['id']!,
      );

  ChangeLogPageRoute get _self => this as ChangeLogPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/changeLog/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChangeLogFormPageRoute on GoRouteData {
  static ChangeLogFormPageRoute _fromState(GoRouterState state) =>
      ChangeLogFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  ChangeLogFormPageRoute get _self => this as ChangeLogFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/changelog',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $YourAccountPageRoute on GoRouteData {
  static YourAccountPageRoute _fromState(GoRouterState state) =>
      const YourAccountPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/your-account',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppointmentSchedulesPageRoute on GoRouteData {
  static AppointmentSchedulesPageRoute _fromState(GoRouterState state) =>
      const AppointmentSchedulesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/appointmentSchedules',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppointmentSchedulesByDatePageRoute on GoRouteData {
  static AppointmentSchedulesByDatePageRoute _fromState(GoRouterState state) =>
      AppointmentSchedulesByDatePageRoute(
        date: _$convertMapValue(
            'date', state.uri.queryParameters, DateTime.tryParse),
      );

  AppointmentSchedulesByDatePageRoute get _self =>
      this as AppointmentSchedulesByDatePageRoute;

  @override
  String get location => GoRouteData.$location(
        '/today/appointmentSchedules',
        queryParams: {
          if (_self.date != null) 'date': _self.date!.toString(),
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppointmentSchedulePageRoute on GoRouteData {
  static AppointmentSchedulePageRoute _fromState(GoRouterState state) =>
      AppointmentSchedulePageRoute(
        state.pathParameters['id']!,
      );

  AppointmentSchedulePageRoute get _self =>
      this as AppointmentSchedulePageRoute;

  @override
  String get location => GoRouteData.$location(
        '/appointmentSchedule/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppointmentScheduleFormPageRoute on GoRouteData {
  static AppointmentScheduleFormPageRoute _fromState(GoRouterState state) =>
      AppointmentScheduleFormPageRoute(
        id: state.uri.queryParameters['id'],
        patientId: state.uri.queryParameters['patient-id'],
        patientRecordId: state.uri.queryParameters['patient-record-id'],
      );

  AppointmentScheduleFormPageRoute get _self =>
      this as AppointmentScheduleFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/appointmentSchedule',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
          if (_self.patientId != null) 'patient-id': _self.patientId,
          if (_self.patientRecordId != null)
            'patient-record-id': _self.patientRecordId,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientSpeciesListPageRoute on GoRouteData {
  static PatientSpeciesListPageRoute _fromState(GoRouterState state) =>
      const PatientSpeciesListPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/patientSpecies',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientSpeciesFormPageRoute on GoRouteData {
  static PatientSpeciesFormPageRoute _fromState(GoRouterState state) =>
      PatientSpeciesFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  PatientSpeciesFormPageRoute get _self => this as PatientSpeciesFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientSpecies',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientSpeciesPageRoute on GoRouteData {
  static PatientSpeciesPageRoute _fromState(GoRouterState state) =>
      PatientSpeciesPageRoute(
        state.pathParameters['id']!,
      );

  PatientSpeciesPageRoute get _self => this as PatientSpeciesPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/patientSpecies/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientBreedFormPageRoute on GoRouteData {
  static PatientBreedFormPageRoute _fromState(GoRouterState state) =>
      PatientBreedFormPageRoute(
        id: state.uri.queryParameters['id'],
        parentId: state.uri.queryParameters['parent-id']!,
      );

  PatientBreedFormPageRoute get _self => this as PatientBreedFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientBreeds',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
          'parent-id': _self.parentId,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductAdjustmentsPageRoute on GoRouteData {
  static ProductAdjustmentsPageRoute _fromState(GoRouterState state) =>
      ProductAdjustmentsPageRoute(
        productId: state.uri.queryParameters['product-id'],
        productStockId: state.uri.queryParameters['product-stock-id'],
      );

  ProductAdjustmentsPageRoute get _self => this as ProductAdjustmentsPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/product-adjustments',
        queryParams: {
          if (_self.productId != null) 'product-id': _self.productId,
          if (_self.productStockId != null)
            'product-stock-id': _self.productStockId,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductAdjustmentFormPageRoute on GoRouteData {
  static ProductAdjustmentFormPageRoute _fromState(GoRouterState state) =>
      ProductAdjustmentFormPageRoute(
        id: state.uri.queryParameters['id'],
        productId: state.uri.queryParameters['product-id'],
        productStockId: state.uri.queryParameters['product-stock-id'],
      );

  ProductAdjustmentFormPageRoute get _self =>
      this as ProductAdjustmentFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/product-adjustments',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
          if (_self.productId != null) 'product-id': _self.productId,
          if (_self.productStockId != null)
            'product-stock-id': _self.productStockId,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientTreatmentPageRoute on GoRouteData {
  static PatientTreatmentPageRoute _fromState(GoRouterState state) =>
      const PatientTreatmentPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/patientTreatments',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientTreatmentFormPageRoute on GoRouteData {
  static PatientTreatmentFormPageRoute _fromState(GoRouterState state) =>
      PatientTreatmentFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  PatientTreatmentFormPageRoute get _self =>
      this as PatientTreatmentFormPageRoute;

  @override
  String get location => GoRouteData.$location(
        '/form/patientTreatments',
        queryParams: {
          if (_self.id != null) 'id': _self.id,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $adminsPageRoute => GoRouteData.$route(
      path: '/admins',
      factory: $AdminsPageRoute._fromState,
    );

RouteBase get $adminPageRoute => GoRouteData.$route(
      path: '/admin/:id',
      factory: $AdminPageRoute._fromState,
    );

RouteBase get $adminFormPageRoute => GoRouteData.$route(
      path: '/form/admin',
      factory: $AdminFormPageRoute._fromState,
    );

RouteBase get $branchesPageRoute => GoRouteData.$route(
      path: '/branches',
      factory: $BranchesPageRoute._fromState,
    );

RouteBase get $branchFormPageRoute => GoRouteData.$route(
      path: '/form/branch',
      factory: $BranchFormPageRoute._fromState,
    );

RouteBase get $branchPageRoute => GoRouteData.$route(
      path: '/branch/:id',
      factory: $BranchPageRoute._fromState,
    );

RouteBase get $loginPageRoute => GoRouteData.$route(
      path: '/login/user',
      factory: $LoginPageRoute._fromState,
    );

mixin $LoginPageRoute on GoRouteData {
  static LoginPageRoute _fromState(GoRouterState state) =>
      const LoginPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/login/user',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $emailValidationPageRoute => GoRouteData.$route(
      path: '/email/validation',
      factory: $EmailValidationPageRoute._fromState,
    );

mixin $EmailValidationPageRoute on GoRouteData {
  static EmailValidationPageRoute _fromState(GoRouterState state) =>
      const EmailValidationPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/email/validation',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminLoginPageRoute => GoRouteData.$route(
      path: '/login/admin',
      factory: $AdminLoginPageRoute._fromState,
    );

mixin $AdminLoginPageRoute on GoRouteData {
  static AdminLoginPageRoute _fromState(GoRouterState state) =>
      const AdminLoginPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/login/admin',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountRecoveryPageRoute => GoRouteData.$route(
      path: 'recovery',
      factory: $AccountRecoveryPageRoute._fromState,
    );

mixin $AccountRecoveryPageRoute on GoRouteData {
  static AccountRecoveryPageRoute _fromState(GoRouterState state) =>
      const AccountRecoveryPageRoute();

  @override
  String get location => GoRouteData.$location(
        'recovery',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountPageRoute => GoRouteData.$route(
      path: '/account',
      factory: $AccountPageRoute._fromState,
    );

mixin $AccountPageRoute on GoRouteData {
  static AccountPageRoute _fromState(GoRouterState state) =>
      const AccountPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/account',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $yourAccountPageRoute => GoRouteData.$route(
      path: '/your-account',
      factory: $YourAccountPageRoute._fromState,
    );

RouteBase get $usersPageRoute => GoRouteData.$route(
      path: '/user',
      factory: $UsersPageRoute._fromState,
    );

RouteBase get $userPageRoute => GoRouteData.$route(
      path: '/user/:id',
      factory: $UserPageRoute._fromState,
    );

RouteBase get $userFormPageRoute => GoRouteData.$route(
      path: '/form/user',
      factory: $UserFormPageRoute._fromState,
    );

RouteBase get $settingsPageRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsPageRoute._fromState,
    );

RouteBase get $domainPageRoute => GoRouteData.$route(
      path: '/domain',
      factory: $DomainPageRoute._fromState,
    );

RouteBase get $patientsPageRoute => GoRouteData.$route(
      path: '/patients',
      factory: $PatientsPageRoute._fromState,
    );

RouteBase get $patientPageRoute => GoRouteData.$route(
      path: '/patient/:id',
      factory: $PatientPageRoute._fromState,
    );

RouteBase get $patientFormPageRoute => GoRouteData.$route(
      path: '/form/patient',
      factory: $PatientFormPageRoute._fromState,
    );

RouteBase get $dashboardPageRoute => GoRouteData.$route(
      path: '/',
      factory: $DashboardPageRoute._fromState,
    );

RouteBase get $morePageRoute => GoRouteData.$route(
      path: '/more',
      factory: $MorePageRoute._fromState,
    );

mixin $MorePageRoute on GoRouteData {
  static MorePageRoute _fromState(GoRouterState state) => const MorePageRoute();

  @override
  String get location => GoRouteData.$location(
        '/more',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $salesPageRoute => GoRouteData.$route(
      path: '/sales',
      factory: $SalesPageRoute._fromState,
    );

mixin $SalesPageRoute on GoRouteData {
  static SalesPageRoute _fromState(GoRouterState state) =>
      const SalesPageRoute();

  @override
  String get location => GoRouteData.$location(
        '/sales',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $salesCashierPageRoute => GoRouteData.$route(
      path: '/cashier',
      factory: $SalesCashierPageRoute._fromState,
    );

RouteBase get $productsPageRoute => GoRouteData.$route(
      path: '/products',
      factory: $ProductsPageRoute._fromState,
    );

RouteBase get $productInventoriesPageRoute => GoRouteData.$route(
      path: '/productInventories',
      factory: $ProductInventoriesPageRoute._fromState,
    );

RouteBase get $productFormPageRoute => GoRouteData.$route(
      path: '/form/product',
      factory: $ProductFormPageRoute._fromState,
    );

RouteBase get $productStockFormPageRoute => GoRouteData.$route(
      path: '/form/productStock',
      factory: $ProductStockFormPageRoute._fromState,
    );

RouteBase get $productPageRoute => GoRouteData.$route(
      path: '/product/:id',
      factory: $ProductPageRoute._fromState,
    );

RouteBase get $productStockPageRoute => GoRouteData.$route(
      path: '/product/form/:id',
      factory: $ProductStockPageRoute._fromState,
    );

RouteBase get $patientRecordPageRoute => GoRouteData.$route(
      path: '/patientRecord/:id',
      factory: $PatientRecordPageRoute._fromState,
    );

RouteBase get $patientRecordFormPageRoute => GoRouteData.$route(
      path: '/form/patientRecord',
      factory: $PatientRecordFormPageRoute._fromState,
    );

RouteBase get $patientTreatmentRecordPageRoute => GoRouteData.$route(
      path: '/patientTreatmentRecord/:id',
      factory: $PatientTreatmentRecordPageRoute._fromState,
    );

RouteBase get $patientTreatmentsRecordPageRoute => GoRouteData.$route(
      path: '/patientTreatmentRecords',
      factory: $PatientTreatmentsRecordPageRoute._fromState,
    );

RouteBase get $patientTreatmentRecordFormPageRoute => GoRouteData.$route(
      path: '/form/patientTreatmentRecord',
      factory: $PatientTreatmentRecordFormPageRoute._fromState,
    );

RouteBase get $patientAppointmentSchedulesPageRoute => GoRouteData.$route(
      path: '/patient/appointmentSchedules',
      factory: $PatientAppointmentSchedulesPageRoute._fromState,
    );

RouteBase get $appointmentSchedulesPageRoute => GoRouteData.$route(
      path: '/appointmentSchedules',
      factory: $AppointmentSchedulesPageRoute._fromState,
    );

RouteBase get $appointmentSchedulesByDatePageRoute => GoRouteData.$route(
      path: '/today/appointmentSchedules',
      factory: $AppointmentSchedulesByDatePageRoute._fromState,
    );

RouteBase get $appointmentScheduleFormPageRoute => GoRouteData.$route(
      path: '/form/appointmentSchedule',
      factory: $AppointmentScheduleFormPageRoute._fromState,
    );

RouteBase get $appointmentSchedulePageRoute => GoRouteData.$route(
      path: '/appointmentSchedule/:id',
      factory: $AppointmentSchedulePageRoute._fromState,
    );

RouteBase get $calendarAppointmentSchedulesPageRoute => GoRouteData.$route(
      path: '/calendar',
      factory: $CalendarAppointmentSchedulesPageRoute._fromState,
    );

RouteBase get $changeLogsPageRoute => GoRouteData.$route(
      path: '/changeLogs',
      factory: $ChangeLogsPageRoute._fromState,
    );

RouteBase get $changeLogPageRoute => GoRouteData.$route(
      path: '/changeLog/:id',
      factory: $ChangeLogPageRoute._fromState,
    );

RouteBase get $changeLogFormPageRoute => GoRouteData.$route(
      path: '/form/changelog',
      factory: $ChangeLogFormPageRoute._fromState,
    );

RouteBase get $productCategoriesPageRoute => GoRouteData.$route(
      path: '/product-categories',
      factory: $ProductCategoriesPageRoute._fromState,
    );

RouteBase get $productCategoryPageRoute => GoRouteData.$route(
      path: '/product-category/:id',
      factory: $ProductCategoryPageRoute._fromState,
    );

RouteBase get $productCategoryFormPageRoute => GoRouteData.$route(
      path: '/form/product-category',
      factory: $ProductCategoryFormPageRoute._fromState,
    );

RouteBase get $patientPrescriptionItemFormPageRoute => GoRouteData.$route(
      path: '/form/patientPrescriptionItem',
      factory: $PatientPrescriptionItemFormPageRoute._fromState,
    );

RouteBase get $patientFileFormPageRoute => GoRouteData.$route(
      path: '/form/patientFiles',
      factory: $PatientFileFormPageRoute._fromState,
    );

RouteBase get $productAdjustmentsPageRoute => GoRouteData.$route(
      path: '/product-adjustments',
      factory: $ProductAdjustmentsPageRoute._fromState,
    );

RouteBase get $productAdjustmentFormPageRoute => GoRouteData.$route(
      path: '/form/product-adjustments',
      factory: $ProductAdjustmentFormPageRoute._fromState,
    );

RouteBase get $patientSpeciesListPageRoute => GoRouteData.$route(
      path: '/patientSpecies',
      factory: $PatientSpeciesListPageRoute._fromState,
    );

RouteBase get $patientSpeciesFormPageRoute => GoRouteData.$route(
      path: '/form/patientSpecies',
      factory: $PatientSpeciesFormPageRoute._fromState,
    );

RouteBase get $patientSpeciesPageRoute => GoRouteData.$route(
      path: '/patientSpecies/:id',
      factory: $PatientSpeciesPageRoute._fromState,
    );

RouteBase get $patientBreedFormPageRoute => GoRouteData.$route(
      path: '/form/patientBreeds',
      factory: $PatientBreedFormPageRoute._fromState,
    );

RouteBase get $patientTreatmentPageRoute => GoRouteData.$route(
      path: '/patientTreatments',
      factory: $PatientTreatmentPageRoute._fromState,
    );

RouteBase get $patientTreatmentFormPageRoute => GoRouteData.$route(
      path: '/form/patientTreatments',
      factory: $PatientTreatmentFormPageRoute._fromState,
    );
