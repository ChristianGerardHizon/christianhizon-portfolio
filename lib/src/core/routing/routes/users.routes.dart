part of '../main.routes.dart';

class UsersBranchData extends StatefulShellBranchData {
  const UsersBranchData();
}

@TypedGoRoute<UserPageRoute>(path: UserPageRoute.path)
class UserPageRoute extends GoRouteData {
  const UserPageRoute();
  static const path = '/user';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserPage();
  }
}

@TypedGoRoute<UsersPageRoute>(path: UsersPageRoute.path)
class UsersPageRoute extends GoRouteData {
  const UsersPageRoute();
  static const path = '/users';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UsersPage();
  }
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

@TypedGoRoute<UserUpdatePageRoute>(path: UserUpdatePageRoute.path)
class UserUpdatePageRoute extends GoRouteData {
  const UserUpdatePageRoute(this.id);
  static const path = '/user/:id/update';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserUpdatePage(id: id);
  }
}
