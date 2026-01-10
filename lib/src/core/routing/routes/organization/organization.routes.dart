part of '../../main.routes.dart';

/// Organization Branch - consolidates admins, users, and branches management
class OrganizationBranchData extends StatefulShellBranchData {
  const OrganizationBranchData();

  static const routes = <TypeRouteData>[
    // Admins
    TypedGoRoute<AdminsPageRoute>(path: AdminsPageRoute.path),
    TypedGoRoute<AdminPageRoute>(path: AdminPageRoute.path),
    TypedGoRoute<AdminFormPageRoute>(path: AdminFormPageRoute.path),
    // Users
    TypedGoRoute<UsersPageRoute>(path: UsersPageRoute.path),
    TypedGoRoute<UserPageRoute>(path: UserPageRoute.path),
    TypedGoRoute<UserFormPageRoute>(path: UserFormPageRoute.path),
    // Branches
    TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path),
    TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path),
    TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path),
  ];
}

// =============================================================================
// Admins Routes
// =============================================================================

@TypedGoRoute<AdminsPageRoute>(path: AdminsPageRoute.path)
class AdminsPageRoute extends GoRouteData with $AdminsPageRoute {
  const AdminsPageRoute();
  static const path = '/organization/admins';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminsPage();
  }
}

@TypedGoRoute<AdminPageRoute>(path: AdminPageRoute.path)
class AdminPageRoute extends GoRouteData with $AdminPageRoute {
  const AdminPageRoute(this.id);
  static const path = '/organization/admins/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminPage(id);
  }
}

@TypedGoRoute<AdminFormPageRoute>(path: AdminFormPageRoute.path)
class AdminFormPageRoute extends GoRouteData with $AdminFormPageRoute {
  const AdminFormPageRoute({this.id});
  static const path = '/organization/admins/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminFormPage(id: id);
  }
}

// =============================================================================
// Users Routes
// =============================================================================

@TypedGoRoute<UsersPageRoute>(path: UsersPageRoute.path)
class UsersPageRoute extends GoRouteData with $UsersPageRoute {
  const UsersPageRoute();
  static const path = '/organization/users';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersPage();
  }
}

@TypedGoRoute<UserPageRoute>(path: UserPageRoute.path)
class UserPageRoute extends GoRouteData with $UserPageRoute {
  const UserPageRoute(this.id);
  static const path = '/organization/users/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserPage(id);
  }
}

@TypedGoRoute<UserFormPageRoute>(path: UserFormPageRoute.path)
class UserFormPageRoute extends GoRouteData with $UserFormPageRoute {
  const UserFormPageRoute({this.id});
  static const path = '/organization/users/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserFormPage(id: id);
  }
}

// =============================================================================
// Branches Routes
// =============================================================================

@TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path)
class BranchesPageRoute extends GoRouteData with $BranchesPageRoute {
  const BranchesPageRoute();
  static const path = '/organization/branches';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BranchesPage();
  }
}

@TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path)
class BranchPageRoute extends GoRouteData with $BranchPageRoute {
  const BranchPageRoute(this.id);
  static const path = '/organization/branches/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchPage(id);
  }
}

@TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path)
class BranchFormPageRoute extends GoRouteData with $BranchFormPageRoute {
  const BranchFormPageRoute({this.id});
  static const path = '/organization/branches/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchFormPage(id: id);
  }
}
