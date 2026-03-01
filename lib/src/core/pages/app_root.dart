import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../routing/routes/admin.routes.dart';
import '../widgets/mobile_bottom_nav.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/tablet_nav_rail.dart';
import '../utils/breakpoints.dart';

/// Main adaptive shell widget that wraps authenticated admin content.
///
/// Provides responsive navigation:
/// - Mobile (< 600px): Bottom navigation + drawer
/// - Tablet (600-1200px): Navigation rail
/// - Desktop (>= 1200px): Expanded navigation rail
class AppRoot extends ConsumerStatefulWidget {
  const AppRoot({
    super.key,
    required this.child,
  });

  /// The child widget from the router (page content).
  final Widget child;

  @override
  ConsumerState<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> {
  /// Key for the scaffold to control drawer.
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  /// Route paths in order of navigation index.
  static const _routePaths = [
    AdminProfileRoute.path, // 0: /admin/profile
    AdminProjectsRoute.path, // 1: /admin/projects
  ];

  /// Routes in order of navigation index.
  static const _routes = <GoRouteData>[
    AdminProfileRoute(), // 0
    AdminProjectsRoute(), // 1
  ];

  /// Gets the selected index based on current route location.
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    final index = _routePaths.indexOf(location);
    if (index >= 0) return index;

    for (int i = 0; i < _routePaths.length; i++) {
      if (location.startsWith(_routePaths[i])) {
        return i;
      }
    }

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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
          return;
        }

        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text(
              'Are you sure you want to close the app?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
        if (shouldExit ?? false) {
          SystemNavigator.pop();
        }
      },
      child: isMobile
          ? _buildMobileLayout(context)
          : _buildTabletLayout(context),
    );
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
            TabletNavRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Scaffold(
                body: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
