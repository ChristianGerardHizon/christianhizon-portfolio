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
      $productAddStockFormPageRoute,
      $productStockPageRoute,
      $patientRecordPageRoute,
      $patientRecordFormPageRoute,
      $patientTreatmentRecordsPageRoute,
      $patientTreatmentRecordPageRoute,
      $appointmentsPageRoute,
      $changeLogsPageRoute,
      $changeLogPageRoute,
      $changeLogFormPageRoute,
      $productCategoriesPageRoute,
      $productCategoryPageRoute,
      $productCategoryFormPageRoute,
    ];

RouteBase get $notFoundRoute => GoRouteData.$route(
      path: '/not-found',
      factory: $NotFoundRouteExtension._fromState,
    );

extension $NotFoundRouteExtension on NotFoundRoute {
  static NotFoundRoute _fromState(GoRouterState state) => const NotFoundRoute();

  String get location => GoRouteData.$location(
        '/not-found',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashPageRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashPageRouteExtension._fromState,
    );

extension $SplashPageRouteExtension on SplashPageRoute {
  static SplashPageRoute _fromState(GoRouterState state) =>
      const SplashPageRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

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
              factory: $DashboardPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/patients',
              factory: $PatientsPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patient',
              factory: $PatientFormPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/patient/:id',
              factory: $PatientPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/patientRecord/:id',
              factory: $PatientRecordPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/patientRecord',
              factory: $PatientRecordFormPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/products',
              factory: $ProductsPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/productInventories',
              factory: $ProductInventoriesPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/product/:id',
              factory: $ProductPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/product',
              factory: $ProductFormPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/productStock',
              factory: $ProductStockFormPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/product/form/:id',
              factory: $ProductStockPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/product-categories',
              factory: $ProductCategoriesPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/product-category/:id',
              factory: $ProductCategoryPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/product-category/form/:id',
              factory: $ProductCategoryFormPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/sales',
              factory: $SalesPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/cashier',
              factory: $SalesCashierPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/branches',
              factory: $BranchesPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/branch/:id',
              factory: $BranchPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/branch',
              factory: $BranchFormPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/user',
              factory: $UsersPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/user/:id',
              factory: $UserPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/user',
              factory: $UserFormPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/admins',
              factory: $AdminsPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/admin/:id',
              factory: $AdminPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/admin',
              factory: $AdminFormPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/settings',
              factory: $SettingsPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/changeLogs',
              factory: $ChangeLogsPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/changeLog/:id',
              factory: $ChangeLogPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/form/changelog',
              factory: $ChangeLogFormPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/your-account',
              factory: $YourAccountPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/appointments',
              factory: $AppointmentsPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/treatment-records',
              factory: $PatientTreatmentRecordsPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/treatment-record/:id',
              factory: $PatientTreatmentRecordPageRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $RootRouteDataExtension on RootRouteData {
  static RootRouteData _fromState(GoRouterState state) => const RootRouteData();
}

extension $DashboardPageRouteExtension on DashboardPageRoute {
  static DashboardPageRoute _fromState(GoRouterState state) =>
      const DashboardPageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientsPageRouteExtension on PatientsPageRoute {
  static PatientsPageRoute _fromState(GoRouterState state) =>
      const PatientsPageRoute();

  String get location => GoRouteData.$location(
        '/patients',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientFormPageRouteExtension on PatientFormPageRoute {
  static PatientFormPageRoute _fromState(GoRouterState state) =>
      PatientFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/patient',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientPageRouteExtension on PatientPageRoute {
  static PatientPageRoute _fromState(GoRouterState state) => PatientPageRoute(
        state.pathParameters['id']!,
        page: _$convertMapValue('page', state.uri.queryParameters, int.parse) ??
            0,
      );

  String get location => GoRouteData.$location(
        '/patient/${Uri.encodeComponent(id)}',
        queryParams: {
          if (page != 0) 'page': page.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientRecordPageRouteExtension on PatientRecordPageRoute {
  static PatientRecordPageRoute _fromState(GoRouterState state) =>
      PatientRecordPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/patientRecord/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientRecordFormPageRouteExtension on PatientRecordFormPageRoute {
  static PatientRecordFormPageRoute _fromState(GoRouterState state) =>
      PatientRecordFormPageRoute(
        parentId: state.uri.queryParameters['parent-id']!,
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/patientRecord',
        queryParams: {
          'parent-id': parentId,
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductsPageRouteExtension on ProductsPageRoute {
  static ProductsPageRoute _fromState(GoRouterState state) =>
      const ProductsPageRoute();

  String get location => GoRouteData.$location(
        '/products',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductInventoriesPageRouteExtension on ProductInventoriesPageRoute {
  static ProductInventoriesPageRoute _fromState(GoRouterState state) =>
      const ProductInventoriesPageRoute();

  String get location => GoRouteData.$location(
        '/productInventories',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductPageRouteExtension on ProductPageRoute {
  static ProductPageRoute _fromState(GoRouterState state) => ProductPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/product/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductFormPageRouteExtension on ProductFormPageRoute {
  static ProductFormPageRoute _fromState(GoRouterState state) =>
      ProductFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/product',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductStockFormPageRouteExtension on ProductStockFormPageRoute {
  static ProductStockFormPageRoute _fromState(GoRouterState state) =>
      ProductStockFormPageRoute(
        id: state.uri.queryParameters['id'],
        productId: state.uri.queryParameters['product-id']!,
      );

  String get location => GoRouteData.$location(
        '/form/productStock',
        queryParams: {
          if (id != null) 'id': id,
          'product-id': productId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductStockPageRouteExtension on ProductStockPageRoute {
  static ProductStockPageRoute _fromState(GoRouterState state) =>
      ProductStockPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/product/form/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductCategoriesPageRouteExtension on ProductCategoriesPageRoute {
  static ProductCategoriesPageRoute _fromState(GoRouterState state) =>
      const ProductCategoriesPageRoute();

  String get location => GoRouteData.$location(
        '/product-categories',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductCategoryPageRouteExtension on ProductCategoryPageRoute {
  static ProductCategoryPageRoute _fromState(GoRouterState state) =>
      ProductCategoryPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/product-category/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductCategoryFormPageRouteExtension
    on ProductCategoryFormPageRoute {
  static ProductCategoryFormPageRoute _fromState(GoRouterState state) =>
      ProductCategoryFormPageRoute(
        id: state.pathParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/product-category/form/${Uri.encodeComponent(id ?? '')}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SalesPageRouteExtension on SalesPageRoute {
  static SalesPageRoute _fromState(GoRouterState state) =>
      const SalesPageRoute();

  String get location => GoRouteData.$location(
        '/sales',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SalesCashierPageRouteExtension on SalesCashierPageRoute {
  static SalesCashierPageRoute _fromState(GoRouterState state) =>
      const SalesCashierPageRoute();

  String get location => GoRouteData.$location(
        '/cashier',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BranchesPageRouteExtension on BranchesPageRoute {
  static BranchesPageRoute _fromState(GoRouterState state) =>
      const BranchesPageRoute();

  String get location => GoRouteData.$location(
        '/branches',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BranchPageRouteExtension on BranchPageRoute {
  static BranchPageRoute _fromState(GoRouterState state) => BranchPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/branch/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BranchFormPageRouteExtension on BranchFormPageRoute {
  static BranchFormPageRoute _fromState(GoRouterState state) =>
      BranchFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/branch',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UsersPageRouteExtension on UsersPageRoute {
  static UsersPageRoute _fromState(GoRouterState state) =>
      const UsersPageRoute();

  String get location => GoRouteData.$location(
        '/user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserPageRouteExtension on UserPageRoute {
  static UserPageRoute _fromState(GoRouterState state) => UserPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/user/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserFormPageRouteExtension on UserFormPageRoute {
  static UserFormPageRoute _fromState(GoRouterState state) => UserFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/user',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminsPageRouteExtension on AdminsPageRoute {
  static AdminsPageRoute _fromState(GoRouterState state) =>
      const AdminsPageRoute();

  String get location => GoRouteData.$location(
        '/admins',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminPageRouteExtension on AdminPageRoute {
  static AdminPageRoute _fromState(GoRouterState state) => AdminPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/admin/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdminFormPageRouteExtension on AdminFormPageRoute {
  static AdminFormPageRoute _fromState(GoRouterState state) =>
      AdminFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/admin',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsPageRouteExtension on SettingsPageRoute {
  static SettingsPageRoute _fromState(GoRouterState state) =>
      const SettingsPageRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChangeLogsPageRouteExtension on ChangeLogsPageRoute {
  static ChangeLogsPageRoute _fromState(GoRouterState state) =>
      const ChangeLogsPageRoute();

  String get location => GoRouteData.$location(
        '/changeLogs',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChangeLogPageRouteExtension on ChangeLogPageRoute {
  static ChangeLogPageRoute _fromState(GoRouterState state) =>
      ChangeLogPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/changeLog/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChangeLogFormPageRouteExtension on ChangeLogFormPageRoute {
  static ChangeLogFormPageRoute _fromState(GoRouterState state) =>
      ChangeLogFormPageRoute(
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/form/changelog',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $YourAccountPageRouteExtension on YourAccountPageRoute {
  static YourAccountPageRoute _fromState(GoRouterState state) =>
      const YourAccountPageRoute();

  String get location => GoRouteData.$location(
        '/your-account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AppointmentsPageRouteExtension on AppointmentsPageRoute {
  static AppointmentsPageRoute _fromState(GoRouterState state) =>
      const AppointmentsPageRoute();

  String get location => GoRouteData.$location(
        '/appointments',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientTreatmentRecordsPageRouteExtension
    on PatientTreatmentRecordsPageRoute {
  static PatientTreatmentRecordsPageRoute _fromState(GoRouterState state) =>
      const PatientTreatmentRecordsPageRoute();

  String get location => GoRouteData.$location(
        '/treatment-records',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientTreatmentRecordPageRouteExtension
    on PatientTreatmentRecordPageRoute {
  static PatientTreatmentRecordPageRoute _fromState(GoRouterState state) =>
      PatientTreatmentRecordPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/treatment-record/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

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
      factory: $AdminsPageRouteExtension._fromState,
    );

RouteBase get $adminPageRoute => GoRouteData.$route(
      path: '/admin/:id',
      factory: $AdminPageRouteExtension._fromState,
    );

RouteBase get $adminFormPageRoute => GoRouteData.$route(
      path: '/form/admin',
      factory: $AdminFormPageRouteExtension._fromState,
    );

RouteBase get $branchesPageRoute => GoRouteData.$route(
      path: '/branches',
      factory: $BranchesPageRouteExtension._fromState,
    );

RouteBase get $branchFormPageRoute => GoRouteData.$route(
      path: '/form/branch',
      factory: $BranchFormPageRouteExtension._fromState,
    );

RouteBase get $branchPageRoute => GoRouteData.$route(
      path: '/branch/:id',
      factory: $BranchPageRouteExtension._fromState,
    );

RouteBase get $loginPageRoute => GoRouteData.$route(
      path: '/login/user',
      factory: $LoginPageRouteExtension._fromState,
    );

extension $LoginPageRouteExtension on LoginPageRoute {
  static LoginPageRoute _fromState(GoRouterState state) =>
      const LoginPageRoute();

  String get location => GoRouteData.$location(
        '/login/user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $emailValidationPageRoute => GoRouteData.$route(
      path: '/email/validation',
      factory: $EmailValidationPageRouteExtension._fromState,
    );

extension $EmailValidationPageRouteExtension on EmailValidationPageRoute {
  static EmailValidationPageRoute _fromState(GoRouterState state) =>
      const EmailValidationPageRoute();

  String get location => GoRouteData.$location(
        '/email/validation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminLoginPageRoute => GoRouteData.$route(
      path: '/login/admin',
      factory: $AdminLoginPageRouteExtension._fromState,
    );

extension $AdminLoginPageRouteExtension on AdminLoginPageRoute {
  static AdminLoginPageRoute _fromState(GoRouterState state) =>
      const AdminLoginPageRoute();

  String get location => GoRouteData.$location(
        '/login/admin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountPageRoute => GoRouteData.$route(
      path: '/account',
      factory: $AccountPageRouteExtension._fromState,
    );

extension $AccountPageRouteExtension on AccountPageRoute {
  static AccountPageRoute _fromState(GoRouterState state) =>
      const AccountPageRoute();

  String get location => GoRouteData.$location(
        '/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $yourAccountPageRoute => GoRouteData.$route(
      path: '/your-account',
      factory: $YourAccountPageRouteExtension._fromState,
    );

RouteBase get $usersPageRoute => GoRouteData.$route(
      path: '/user',
      factory: $UsersPageRouteExtension._fromState,
    );

RouteBase get $userPageRoute => GoRouteData.$route(
      path: '/user/:id',
      factory: $UserPageRouteExtension._fromState,
    );

RouteBase get $userFormPageRoute => GoRouteData.$route(
      path: '/form/user',
      factory: $UserFormPageRouteExtension._fromState,
    );

RouteBase get $settingsPageRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsPageRouteExtension._fromState,
    );

RouteBase get $domainPageRoute => GoRouteData.$route(
      path: '/domain',
      factory: $DomainPageRouteExtension._fromState,
    );

extension $DomainPageRouteExtension on DomainPageRoute {
  static DomainPageRoute _fromState(GoRouterState state) =>
      const DomainPageRoute();

  String get location => GoRouteData.$location(
        '/domain',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $patientsPageRoute => GoRouteData.$route(
      path: '/patients',
      factory: $PatientsPageRouteExtension._fromState,
    );

RouteBase get $patientPageRoute => GoRouteData.$route(
      path: '/patient/:id',
      factory: $PatientPageRouteExtension._fromState,
    );

RouteBase get $patientFormPageRoute => GoRouteData.$route(
      path: '/form/patient',
      factory: $PatientFormPageRouteExtension._fromState,
    );

RouteBase get $dashboardPageRoute => GoRouteData.$route(
      path: '/',
      factory: $DashboardPageRouteExtension._fromState,
    );

RouteBase get $morePageRoute => GoRouteData.$route(
      path: '/more',
      factory: $MorePageRouteExtension._fromState,
    );

extension $MorePageRouteExtension on MorePageRoute {
  static MorePageRoute _fromState(GoRouterState state) => const MorePageRoute();

  String get location => GoRouteData.$location(
        '/more',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $salesPageRoute => GoRouteData.$route(
      path: '/sales',
      factory: $SalesPageRouteExtension._fromState,
    );

RouteBase get $salesCashierPageRoute => GoRouteData.$route(
      path: '/cashier',
      factory: $SalesCashierPageRouteExtension._fromState,
    );

RouteBase get $productsPageRoute => GoRouteData.$route(
      path: '/products',
      factory: $ProductsPageRouteExtension._fromState,
    );

RouteBase get $productInventoriesPageRoute => GoRouteData.$route(
      path: '/productInventories',
      factory: $ProductInventoriesPageRouteExtension._fromState,
    );

RouteBase get $productFormPageRoute => GoRouteData.$route(
      path: '/form/product',
      factory: $ProductFormPageRouteExtension._fromState,
    );

RouteBase get $productStockFormPageRoute => GoRouteData.$route(
      path: '/form/productStock',
      factory: $ProductStockFormPageRouteExtension._fromState,
    );

RouteBase get $productPageRoute => GoRouteData.$route(
      path: '/product/:id',
      factory: $ProductPageRouteExtension._fromState,
    );

RouteBase get $productAddStockFormPageRoute => GoRouteData.$route(
      path: '/product/simple/add',
      factory: $ProductAddStockFormPageRouteExtension._fromState,
    );

extension $ProductAddStockFormPageRouteExtension
    on ProductAddStockFormPageRoute {
  static ProductAddStockFormPageRoute _fromState(GoRouterState state) =>
      ProductAddStockFormPageRoute(
        state.uri.queryParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/product/simple/add',
        queryParams: {
          'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productStockPageRoute => GoRouteData.$route(
      path: '/product/form/:id',
      factory: $ProductStockPageRouteExtension._fromState,
    );

RouteBase get $patientRecordPageRoute => GoRouteData.$route(
      path: '/patientRecord/:id',
      factory: $PatientRecordPageRouteExtension._fromState,
    );

RouteBase get $patientRecordFormPageRoute => GoRouteData.$route(
      path: '/form/patientRecord',
      factory: $PatientRecordFormPageRouteExtension._fromState,
    );

RouteBase get $patientTreatmentRecordsPageRoute => GoRouteData.$route(
      path: '/treatment-records',
      factory: $PatientTreatmentRecordsPageRouteExtension._fromState,
    );

RouteBase get $patientTreatmentRecordPageRoute => GoRouteData.$route(
      path: '/treatment-record/:id',
      factory: $PatientTreatmentRecordPageRouteExtension._fromState,
    );

RouteBase get $appointmentsPageRoute => GoRouteData.$route(
      path: '/appointments',
      factory: $AppointmentsPageRouteExtension._fromState,
    );

RouteBase get $changeLogsPageRoute => GoRouteData.$route(
      path: '/changeLogs',
      factory: $ChangeLogsPageRouteExtension._fromState,
    );

RouteBase get $changeLogPageRoute => GoRouteData.$route(
      path: '/changeLog/:id',
      factory: $ChangeLogPageRouteExtension._fromState,
    );

RouteBase get $changeLogFormPageRoute => GoRouteData.$route(
      path: '/form/changelog',
      factory: $ChangeLogFormPageRouteExtension._fromState,
    );

RouteBase get $productCategoriesPageRoute => GoRouteData.$route(
      path: '/product-categories',
      factory: $ProductCategoriesPageRouteExtension._fromState,
    );

RouteBase get $productCategoryPageRoute => GoRouteData.$route(
      path: '/product-category/:id',
      factory: $ProductCategoryPageRouteExtension._fromState,
    );

RouteBase get $productCategoryFormPageRoute => GoRouteData.$route(
      path: '/product-category/form/:id',
      factory: $ProductCategoryFormPageRouteExtension._fromState,
    );
