part of '../main.routes.dart';

class UserBranchData extends StatefulShellBranchData {
  const UserBranchData();
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

@TypedGoRoute<YourUserPageRoute>(path: YourUserPageRoute.path)
class YourUserPageRoute extends GoRouteData {
  const YourUserPageRoute();
  static const path = '/your-account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserPage();
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
