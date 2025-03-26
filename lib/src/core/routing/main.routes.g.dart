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
      $loginPageRoute,
      $emailValidationPageRoute,
      $adminLoginPageRoute,
      $accountPageRoute,
      $yourAccountPageRoute,
      $usersPageRoute,
      $userPageRoute,
      $userCreatePageRoute,
      $userUpdatePageRoute,
      $settingsPageRoute,
      $domainPageRoute,
      $patientsPageRoute,
      $patientPageRoute,
      $patientCreatePageRoute,
      $patientUpdatePageRoute,
      $patientMedicalRecordPageRoute,
      $dashboardPageRoute,
      $morePageRoute,
      $salesPageRoute,
      $productsPageRoute,
      $productCreatePageRoute,
      $productUpdatePageRoute,
      $productPageRoute,
      $medicalRecordsPageRoute,
      $medicalRecordPageRoute,
      $treatmentRecordsPageRoute,
      $treatmentRecordPageRoute,
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
              path: '/updatePatient/:id',
              factory: $PatientUpdatePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/newPatient',
              factory: $PatientCreatePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/patient/:id',
              factory: $PatientPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/medicalRecord/:medicalRecordId',
              factory: $PatientMedicalRecordPageRouteExtension._fromState,
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
              path: '/updateproduct//:id',
              factory: $ProductUpdatePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/newProduct',
              factory: $ProductCreatePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/product/:id',
              factory: $ProductPageRouteExtension._fromState,
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
              path: '/user',
              factory: $UsersPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/user/:id',
              factory: $UserPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/updateUser/:id',
              factory: $UserUpdatePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/newUser',
              factory: $UserCreatePageRouteExtension._fromState,
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
              path: '/your-account',
              factory: $YourAccountPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/treatment-records',
              factory: $TreatmentRecordsPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/treatment-record/:id',
              factory: $TreatmentRecordPageRouteExtension._fromState,
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

extension $PatientUpdatePageRouteExtension on PatientUpdatePageRoute {
  static PatientUpdatePageRoute _fromState(GoRouterState state) =>
      PatientUpdatePageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/updatePatient/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PatientCreatePageRouteExtension on PatientCreatePageRoute {
  static PatientCreatePageRoute _fromState(GoRouterState state) =>
      const PatientCreatePageRoute();

  String get location => GoRouteData.$location(
        '/newPatient',
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

extension $PatientMedicalRecordPageRouteExtension
    on PatientMedicalRecordPageRoute {
  static PatientMedicalRecordPageRoute _fromState(GoRouterState state) =>
      PatientMedicalRecordPageRoute(
        medicalRecordId: state.pathParameters['medicalRecordId']!,
      );

  String get location => GoRouteData.$location(
        '/medicalRecord/${Uri.encodeComponent(medicalRecordId)}',
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

extension $ProductUpdatePageRouteExtension on ProductUpdatePageRoute {
  static ProductUpdatePageRoute _fromState(GoRouterState state) =>
      ProductUpdatePageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/updateproduct//${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProductCreatePageRouteExtension on ProductCreatePageRoute {
  static ProductCreatePageRoute _fromState(GoRouterState state) =>
      const ProductCreatePageRoute();

  String get location => GoRouteData.$location(
        '/newProduct',
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

extension $UserUpdatePageRouteExtension on UserUpdatePageRoute {
  static UserUpdatePageRoute _fromState(GoRouterState state) =>
      UserUpdatePageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/updateUser/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserCreatePageRouteExtension on UserCreatePageRoute {
  static UserCreatePageRoute _fromState(GoRouterState state) =>
      const UserCreatePageRoute();

  String get location => GoRouteData.$location(
        '/newUser',
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

extension $TreatmentRecordsPageRouteExtension on TreatmentRecordsPageRoute {
  static TreatmentRecordsPageRoute _fromState(GoRouterState state) =>
      const TreatmentRecordsPageRoute();

  String get location => GoRouteData.$location(
        '/treatment-records',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TreatmentRecordPageRouteExtension on TreatmentRecordPageRoute {
  static TreatmentRecordPageRoute _fromState(GoRouterState state) =>
      TreatmentRecordPageRoute(
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

RouteBase get $adminPageRoute => GoRouteData.$route(
      path: '/admin/:id',
      factory: $AdminPageRouteExtension._fromState,
    );

extension $AdminPageRouteExtension on AdminPageRoute {
  static AdminPageRoute _fromState(GoRouterState state) => AdminPageRoute(
        id: state.pathParameters['id']!,
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

RouteBase get $userCreatePageRoute => GoRouteData.$route(
      path: '/newUser',
      factory: $UserCreatePageRouteExtension._fromState,
    );

RouteBase get $userUpdatePageRoute => GoRouteData.$route(
      path: '/updateUser/:id',
      factory: $UserUpdatePageRouteExtension._fromState,
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

RouteBase get $patientCreatePageRoute => GoRouteData.$route(
      path: '/newPatient',
      factory: $PatientCreatePageRouteExtension._fromState,
    );

RouteBase get $patientUpdatePageRoute => GoRouteData.$route(
      path: '/updatePatient/:id',
      factory: $PatientUpdatePageRouteExtension._fromState,
    );

RouteBase get $patientMedicalRecordPageRoute => GoRouteData.$route(
      path: '/medicalRecord/:medicalRecordId',
      factory: $PatientMedicalRecordPageRouteExtension._fromState,
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

RouteBase get $productsPageRoute => GoRouteData.$route(
      path: '/products',
      factory: $ProductsPageRouteExtension._fromState,
    );

RouteBase get $productCreatePageRoute => GoRouteData.$route(
      path: '/newProduct',
      factory: $ProductCreatePageRouteExtension._fromState,
    );

RouteBase get $productUpdatePageRoute => GoRouteData.$route(
      path: '/updateproduct//:id',
      factory: $ProductUpdatePageRouteExtension._fromState,
    );

RouteBase get $productPageRoute => GoRouteData.$route(
      path: '/product/:id',
      factory: $ProductPageRouteExtension._fromState,
    );

RouteBase get $medicalRecordsPageRoute => GoRouteData.$route(
      path: '/medicalRecords',
      factory: $MedicalRecordsPageRouteExtension._fromState,
    );

extension $MedicalRecordsPageRouteExtension on MedicalRecordsPageRoute {
  static MedicalRecordsPageRoute _fromState(GoRouterState state) =>
      MedicalRecordsPageRoute(
        state.uri.queryParameters['id']!,
        state.uri.queryParameters['patient-id']!,
      );

  String get location => GoRouteData.$location(
        '/medicalRecords',
        queryParams: {
          'id': id,
          'patient-id': patientId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $medicalRecordPageRoute => GoRouteData.$route(
      path: '/medicalRecord/:id/:patientId',
      factory: $MedicalRecordPageRouteExtension._fromState,
    );

extension $MedicalRecordPageRouteExtension on MedicalRecordPageRoute {
  static MedicalRecordPageRoute _fromState(GoRouterState state) =>
      MedicalRecordPageRoute(
        state.pathParameters['id']!,
        state.pathParameters['patientId']!,
      );

  String get location => GoRouteData.$location(
        '/medicalRecord/${Uri.encodeComponent(id)}/${Uri.encodeComponent(patientId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $treatmentRecordsPageRoute => GoRouteData.$route(
      path: '/treatment-records',
      factory: $TreatmentRecordsPageRouteExtension._fromState,
    );

RouteBase get $treatmentRecordPageRoute => GoRouteData.$route(
      path: '/treatment-record/:id',
      factory: $TreatmentRecordPageRouteExtension._fromState,
    );
