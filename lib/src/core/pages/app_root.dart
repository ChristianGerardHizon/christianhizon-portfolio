import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes/appointments.routes.dart';
import '../routing/routes/dashboard.routes.dart';
import '../routing/routes/messages.routes.dart';
import '../routing/routes/organization.routes.dart';
import '../routing/routes/patients.routes.dart';
import '../routing/routes/products.routes.dart';
import '../routing/routes/roles.routes.dart';
import '../routing/routes/sales.routes.dart';
import '../routing/routes/sales_history.routes.dart';
import '../routing/routes/system.routes.dart';
import '../routing/routes/users.routes.dart';
import '../utils/breakpoints.dart';
import '../widgets/breadcrumb_nav.dart';
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
    SalesHistoryRoute.path, // 5: /sales
    MessagesRoute.path, // 6: /messages
    UsersRoute.path, // 7: /users
    RolesRoute.path, // 8: /roles
    OrganizationRoute.path, // 9: /organization
    SystemRoute.path, // 10: /system
  ];

  /// Routes in order of navigation index.
  static const _routes = <GoRouteData>[
    DashboardRoute(), // 0
    PatientsRoute(), // 1
    AppointmentsRoute(), // 2
    ProductsRoute(), // 3
    SalesRoute(), // 4
    SalesHistoryRoute(), // 5
    MessagesRoute(), // 6
    UsersRoute(), // 7
    RolesRoute(), // 8
    OrganizationRoute(), // 9
    SystemRoute(), // 10
  ];

  /// Gets the selected index based on current route location.
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    // Try exact match first
    final index = _routePaths.indexOf(location);
    if (index >= 0) return index;

    // For nested routes, check if location starts with any route path
    // Skip index 0 ('/') to prevent matching everything
    for (int i = 1; i < _routePaths.length; i++) {
      if (location.startsWith(_routePaths[i])) {
        return i;
      }
    }

    // Fallback to dashboard
    return 0;
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
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: MobileDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: widget.child,
        ),
      ),
      bottomNavigationBar: MobileBottomNav(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        onMoreTap: _openDrawer,
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
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
                body: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //   child: BreadcrumbNav(),
                      // ),
                      Expanded(child: widget.child),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
