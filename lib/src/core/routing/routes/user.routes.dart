part of '../main.routes.dart';

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
