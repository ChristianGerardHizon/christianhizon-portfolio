part of '../../main.routes.dart';

/// System Branch - consolidates settings, change logs, and account management
class SystemBranchData extends StatefulShellBranchData {
  const SystemBranchData();

  static const routes = <TypeRouteData>[
    // Settings
    TypedGoRoute<SettingsPageRoute>(path: SettingsPageRoute.path),
    TypedGoRoute<DomainPageRoute>(path: DomainPageRoute.path),
    // Change Logs
    TypedGoRoute<ChangeLogsPageRoute>(path: ChangeLogsPageRoute.path),
    TypedGoRoute<ChangeLogPageRoute>(path: ChangeLogPageRoute.path),
    TypedGoRoute<ChangeLogFormPageRoute>(path: ChangeLogFormPageRoute.path),
    // Account
    TypedGoRoute<YourAccountPageRoute>(path: YourAccountPageRoute.path),
  ];
}

// =============================================================================
// Settings Routes
// =============================================================================

@TypedGoRoute<SettingsPageRoute>(path: SettingsPageRoute.path)
class SettingsPageRoute extends GoRouteData with $SettingsPageRoute {
  const SettingsPageRoute();
  static const path = '/system/settings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@TypedGoRoute<DomainPageRoute>(path: DomainPageRoute.path)
class DomainPageRoute extends GoRouteData with $DomainPageRoute {
  const DomainPageRoute();
  static const path = '/system/domain';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DomainPage();
  }
}

// =============================================================================
// Change Logs Routes
// =============================================================================

@TypedGoRoute<ChangeLogsPageRoute>(path: ChangeLogsPageRoute.path)
class ChangeLogsPageRoute extends GoRouteData with $ChangeLogsPageRoute {
  const ChangeLogsPageRoute();
  static const path = '/system/change-logs';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChangeLogsPage();
  }
}

@TypedGoRoute<ChangeLogPageRoute>(path: ChangeLogPageRoute.path)
class ChangeLogPageRoute extends GoRouteData with $ChangeLogPageRoute {
  const ChangeLogPageRoute(this.id);
  static const path = '/system/change-logs/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeLogPage(id);
  }
}

@TypedGoRoute<ChangeLogFormPageRoute>(path: ChangeLogFormPageRoute.path)
class ChangeLogFormPageRoute extends GoRouteData with $ChangeLogFormPageRoute {
  const ChangeLogFormPageRoute({this.id});
  static const path = '/system/change-logs/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeLogFormPage(id: id);
  }
}

// =============================================================================
// Account Routes
// =============================================================================

@TypedGoRoute<YourAccountPageRoute>(path: YourAccountPageRoute.path)
class YourAccountPageRoute extends GoRouteData with $YourAccountPageRoute {
  const YourAccountPageRoute();
  static const path = '/system/account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const YourAccountPage();
  }
}

// =============================================================================
// Authentication Routes (not part of shell branches, standalone routes)
// =============================================================================

@TypedGoRoute<LoginPageRoute>(path: LoginPageRoute.path)
class LoginPageRoute extends GoRouteData with $LoginPageRoute {
  const LoginPageRoute();
  static const path = '/login/user';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserLoginPage();
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final provider = ProviderScope.containerOf(context);
    final auth = await provider.read(authControllerProvider);

    if (auth.isLoading) return SplashPageRoute.path;

    return null;
  }
}

@TypedGoRoute<EmailValidationPageRoute>(path: EmailValidationPageRoute.path)
class EmailValidationPageRoute extends GoRouteData
    with $EmailValidationPageRoute {
  const EmailValidationPageRoute();
  static const path = '/email/validation';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EmailValidationPage();
  }
}

@TypedGoRoute<AdminLoginPageRoute>(path: AdminLoginPageRoute.path)
class AdminLoginPageRoute extends GoRouteData with $AdminLoginPageRoute {
  const AdminLoginPageRoute();
  static const path = '/login/admin';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminLoginPage();
  }
}

@TypedGoRoute<AccountRecoveryPageRoute>(path: AccountRecoveryPageRoute.path)
class AccountRecoveryPageRoute extends GoRouteData with $AccountRecoveryPageRoute {
  const AccountRecoveryPageRoute();
  static const path = '/recovery';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountRecoveryPage();
  }
}

@TypedGoRoute<AccountPageRoute>(path: AccountPageRoute.path, routes: [])
class AccountPageRoute extends GoRouteData with $AccountPageRoute {
  const AccountPageRoute();
  static const path = '/account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountPage();
  }
}
