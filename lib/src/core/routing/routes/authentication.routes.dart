part of '../main.routes.dart';

///
/// Authentication
///

@TypedGoRoute<LoginPageRoute>(path: LoginPageRoute.path, routes: [
  TypedGoRoute<AccountRecoveryPageRoute>(path: AccountRecoveryPageRoute.path),
])
class LoginPageRoute extends GoRouteData {
  const LoginPageRoute();
  static const path = '/authentication';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
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
