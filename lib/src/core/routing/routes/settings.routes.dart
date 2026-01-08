part of '../main.routes.dart';

class SettingsBranchData extends StatefulShellBranchData {
  const SettingsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<SettingsPageRoute>(path: SettingsPageRoute.path),
    TypedGoRoute<DomainPageRoute>(path: DomainPageRoute.path),
  ];
}

///
/// Settings
///
@TypedGoRoute<SettingsPageRoute>(path: SettingsPageRoute.path)
class SettingsPageRoute extends GoRouteData with $SettingsPageRoute {
  const SettingsPageRoute();
  static const path = '/settings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@TypedGoRoute<DomainPageRoute>(path: DomainPageRoute.path)
class DomainPageRoute extends GoRouteData with $DomainPageRoute {
  const DomainPageRoute();
  static const path = '/domain';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DomainPage();
  }
}
