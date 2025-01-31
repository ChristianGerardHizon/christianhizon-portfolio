part of '../main.routes.dart';

class UsersBranchData extends StatefulShellBranchData {
  const UsersBranchData();
}

@TypedGoRoute<YourUserPageRoute>(path: YourUserPageRoute.path)
class YourUserPageRoute extends GoRouteData {
  const YourUserPageRoute();
  static const path = '/your-account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const YourUserPage();
  }
}

@TypedGoRoute<UsersPageRoute>(path: UsersPageRoute.path)
class UsersPageRoute extends GoRouteData {
  const UsersPageRoute();
  static const path = '/user';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersPage();
  }
}

@TypedGoRoute<UserPageRoute>(path: UserPageRoute.path)
class UserPageRoute extends GoRouteData {
  const UserPageRoute(this.id);
  static const path = '/user/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserPage(id);
  }
}

@TypedGoRoute<UserCreatePageRoute>(path: UserCreatePageRoute.path)
class UserCreatePageRoute extends GoRouteData {
  const UserCreatePageRoute();
  static const path = '/newUser';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserCreatePage();
  }
}

@TypedGoRoute<UserUpdatePageRoute>(path: UserUpdatePageRoute.path)
class UserUpdatePageRoute extends GoRouteData {
  const UserUpdatePageRoute(this.id);
  static const path = '/updateUser/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserUpdatePage(id);
  }
}
