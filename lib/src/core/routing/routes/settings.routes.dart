part of '../main.routes.dart';

class SettingsBranchData extends StatefulShellBranchData {
  const SettingsBranchData();
}

///
/// Settings
///
@TypedGoRoute<SettingsPageRoute>(path: SettingsPageRoute.path)
class SettingsPageRoute extends GoRouteData {
  const SettingsPageRoute();
  static const path = '/settings';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@TypedGoRoute<DomainPageRoute>(path: DomainPageRoute.path)
class DomainPageRoute extends GoRouteData {
  const DomainPageRoute();
  static const path = '/domain';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DomainPage();
  }
}
