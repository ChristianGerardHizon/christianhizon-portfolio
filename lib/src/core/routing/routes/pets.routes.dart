part of '../main.routes.dart';

class PetsBranchData extends StatefulShellBranchData {
  const PetsBranchData();
}

@TypedGoRoute<PetsPageRoute>(path: PetsPageRoute.path)
class PetsPageRoute extends GoRouteData {
  const PetsPageRoute();
  static const path = '/pets';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PetsPage();
  }
}

@TypedGoRoute<PetPageRoute>(path: PetPageRoute.path)
class PetPageRoute extends GoRouteData {
  const PetPageRoute(this.id);
  static const path = '/pet/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PetPage(id);
  }
}

@TypedGoRoute<PetCreatePageRoute>(path: PetCreatePageRoute.path)
class PetCreatePageRoute extends GoRouteData {
  const PetCreatePageRoute();
  static const path = '/newPet';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PetCreatePage();
  }
}

@TypedGoRoute<PetUpdatePageRoute>(path: PetUpdatePageRoute.path)
class PetUpdatePageRoute extends GoRouteData {
  const PetUpdatePageRoute(this.id);
  static const path = '/updatePet/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PetUpdatePage(id);
  }
}
