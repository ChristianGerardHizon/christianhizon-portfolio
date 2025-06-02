part of '../main.routes.dart';

///
/// Authentication
///

class AuthenticationBranchData extends StatefulShellBranchData {
  const AuthenticationBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<YourAccountPageRoute>(path: YourAccountPageRoute.path),
  ];
}

@TypedGoRoute<LoginPageRoute>(path: LoginPageRoute.path)
class LoginPageRoute extends GoRouteData {
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
class EmailValidationPageRoute extends GoRouteData {
  const EmailValidationPageRoute();
  static const path = '/email/validation';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EmailValidationPage();
  }
}

@TypedGoRoute<AdminLoginPageRoute>(path: AdminLoginPageRoute.path)
class AdminLoginPageRoute extends GoRouteData {
  const AdminLoginPageRoute();
  static const path = '/login/admin';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminLoginPage();
  }
}

class AccountRecoveryPageRoute extends GoRouteData {
  const AccountRecoveryPageRoute();
  static const path = 'recovery';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountRecoveryPage();
  }
}

///
/// Account
///
@TypedGoRoute<AccountPageRoute>(path: AccountPageRoute.path, routes: [])
class AccountPageRoute extends GoRouteData {
  const AccountPageRoute();
  static const path = '/account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountPage();
  }
}

@TypedGoRoute<YourAccountPageRoute>(path: YourAccountPageRoute.path)
class YourAccountPageRoute extends GoRouteData {
  const YourAccountPageRoute();
  static const path = '/your-account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const YourAccountPage();
  }
}
