part of '../main.routes.dart';

class UsersBranchData extends StatefulShellBranchData {
  const UsersBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<UsersPageRoute>(path: UsersPageRoute.path),
    TypedGoRoute<UserPageRoute>(path: UserPageRoute.path),
    TypedGoRoute<UserFormPageRoute>(path: UserFormPageRoute.path),
  ];
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

@TypedGoRoute<UserFormPageRoute>(path: UserFormPageRoute.path)
class UserFormPageRoute extends GoRouteData {
  const UserFormPageRoute({this.id});
  static const path = '/form/user';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserFormPage(id: id);
  }
}
