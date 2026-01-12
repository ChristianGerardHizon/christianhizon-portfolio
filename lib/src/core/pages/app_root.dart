import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../i18n/strings.g.dart';
import '../routing/routes/appointments.routes.dart';
import '../routing/routes/dashboard.routes.dart';
import '../routing/routes/organization.routes.dart';
import '../routing/routes/patients.routes.dart';
import '../routing/routes/products.routes.dart';
import '../routing/routes/sales.routes.dart';
import '../routing/routes/system.routes.dart';
import '../utils/breakpoints.dart';
import '../widgets/mobile_bottom_nav.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/tablet_nav_rail.dart';

/// Main adaptive shell widget that wraps authenticated app content.
///
/// Provides responsive navigation:
/// - Mobile (< 600px): Bottom navigation + drawer
/// - Tablet (600-1200px): Navigation rail
/// - Desktop (>= 1200px): Expanded navigation rail
class AppRoot extends StatefulWidget {
  const AppRoot({
    super.key,
    required this.child,
  });

  /// The child widget from the router (page content).
  final Widget child;

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  /// Key for the scaffold to control drawer.
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Route paths in order of navigation index.
  static const _routePaths = [
    DashboardRoute.path, // 0: /
    PatientsRoute.path, // 1: /patients
    AppointmentsRoute.path, // 2: /appointments
    ProductsRoute.path, // 3: /products
    SalesRoute.path, // 4: /cashier
    OrganizationRoute.path, // 5: /organization
    SystemRoute.path, // 6: /system
  ];

  /// Routes in order of navigation index.
  static const _routes = <GoRouteData>[
    DashboardRoute(), // 0
    PatientsRoute(), // 1
    AppointmentsRoute(), // 2
    ProductsRoute(), // 3
    SalesRoute(), // 4
    OrganizationRoute(), // 5
    SystemRoute(), // 6
  ];

  /// Gets the selected index based on current route location.
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _routePaths.indexOf(location);
    return index >= 0 ? index : 0;
  }

  void _onDestinationSelected(int index) {
    if (index >= 0 && index < _routes.length) {
      _routes[index].go(context);
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    if (isMobile) {
      return _buildMobileLayout(context);
    }

    return _buildTabletLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    final t = Translations.of(context);
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_getPageTitle(t, selectedIndex)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MobileDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
      body: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: widget.child,
      ),
      bottomNavigationBar: MobileBottomNav(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        onMoreTap: _openDrawer,
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final t = Translations.of(context);
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail
          TabletNavRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
          ),

          const VerticalDivider(width: 1),

          // Main content area
          Expanded(
            child: Scaffold(
              // appBar: AppBar(
              //   title: Text(_getPageTitle(t, selectedIndex)),
              // ),
              body: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPageTitle(Translations t, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return t.navigation.dashboard;
      case 1:
        return t.navigation.patients;
      case 2:
        return t.navigation.appointments;
      case 3:
        return t.navigation.products;
      case 4:
        return t.navigation.sales;
      case 5:
        return t.navigation.organization;
      case 6:
        return t.navigation.system;
      default:
        return t.navigation.dashboard;
    }
  }
}
