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
      $adminLoginPageRoute,
      $accountPageRoute,
      $userPageRoute,
      $usersPageRoute,
      $yourUserPageRoute,
      $userUpdatePageRoute,
      $settingsPageRoute,
      $domainPageRoute,
      $patientsPageRoute,
      $patientPageRoute,
      $patientCreatePageRoute,
      $patientUpdatePageRoute,
      $dashboardPageRoute,
      $staffsPageRoute,
      $staffPageRoute,
      $staffCreatePageRoute,
      $staffUpdatePageRoute,
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
              path: '/patient/:id',
              factory: $PatientPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/updatePatient/:id',
              factory: $PatientUpdatePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/newPatient',
              factory: $PatientCreatePageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/admins',
              factory: $AdminsPageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/admins',
              factory: $AdminsPageRouteExtension._fromState,
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

extension $PatientPageRouteExtension on PatientPageRoute {
  static PatientPageRoute _fromState(GoRouterState state) => PatientPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/patient/${Uri.encodeComponent(id)}',
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

RouteBase get $adminsPageRoute => GoRouteData.$route(
      path: '/admins',
      factory: $AdminsPageRouteExtension._fromState,
    );

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
      path: '/login/staff',
      factory: $LoginPageRouteExtension._fromState,
    );

extension $LoginPageRouteExtension on LoginPageRoute {
  static LoginPageRoute _fromState(GoRouterState state) =>
      const LoginPageRoute();

  String get location => GoRouteData.$location(
        '/login/staff',
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

RouteBase get $userPageRoute => GoRouteData.$route(
      path: '/user',
      factory: $UserPageRouteExtension._fromState,
    );

extension $UserPageRouteExtension on UserPageRoute {
  static UserPageRoute _fromState(GoRouterState state) => const UserPageRoute();

  String get location => GoRouteData.$location(
        '/user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $usersPageRoute => GoRouteData.$route(
      path: '/users',
      factory: $UsersPageRouteExtension._fromState,
    );

extension $UsersPageRouteExtension on UsersPageRoute {
  static UsersPageRoute _fromState(GoRouterState state) =>
      const UsersPageRoute();

  String get location => GoRouteData.$location(
        '/users',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $yourUserPageRoute => GoRouteData.$route(
      path: '/your-account',
      factory: $YourUserPageRouteExtension._fromState,
    );

extension $YourUserPageRouteExtension on YourUserPageRoute {
  static YourUserPageRoute _fromState(GoRouterState state) =>
      const YourUserPageRoute();

  String get location => GoRouteData.$location(
        '/your-account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userUpdatePageRoute => GoRouteData.$route(
      path: '/user/:id/update',
      factory: $UserUpdatePageRouteExtension._fromState,
    );

extension $UserUpdatePageRouteExtension on UserUpdatePageRoute {
  static UserUpdatePageRoute _fromState(GoRouterState state) =>
      UserUpdatePageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/user/${Uri.encodeComponent(id)}/update',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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

RouteBase get $dashboardPageRoute => GoRouteData.$route(
      path: '/',
      factory: $DashboardPageRouteExtension._fromState,
    );

RouteBase get $staffsPageRoute => GoRouteData.$route(
      path: '/patients',
      factory: $StaffsPageRouteExtension._fromState,
    );

extension $StaffsPageRouteExtension on StaffsPageRoute {
  static StaffsPageRoute _fromState(GoRouterState state) =>
      const StaffsPageRoute();

  String get location => GoRouteData.$location(
        '/patients',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $staffPageRoute => GoRouteData.$route(
      path: '/patient/:id',
      factory: $StaffPageRouteExtension._fromState,
    );

extension $StaffPageRouteExtension on StaffPageRoute {
  static StaffPageRoute _fromState(GoRouterState state) => StaffPageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/patient/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $staffCreatePageRoute => GoRouteData.$route(
      path: '/newStaff',
      factory: $StaffCreatePageRouteExtension._fromState,
    );

extension $StaffCreatePageRouteExtension on StaffCreatePageRoute {
  static StaffCreatePageRoute _fromState(GoRouterState state) =>
      const StaffCreatePageRoute();

  String get location => GoRouteData.$location(
        '/newStaff',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $staffUpdatePageRoute => GoRouteData.$route(
      path: '/updateStaff/:id',
      factory: $StaffUpdatePageRouteExtension._fromState,
    );

extension $StaffUpdatePageRouteExtension on StaffUpdatePageRoute {
  static StaffUpdatePageRoute _fromState(GoRouterState state) =>
      StaffUpdatePageRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/updateStaff/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
