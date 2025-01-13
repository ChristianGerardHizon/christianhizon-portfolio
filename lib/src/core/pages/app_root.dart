import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/type_defs/custom_navbar_item.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppRoot extends HookConsumerWidget {
  final StatefulNavigationShell shell;
  final GoRouterState state;

  const AppRoot({super.key, required this.shell, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// theme of the app.
    ///
    final theme = Theme.of(context);

    ref.watch(settingsControllerProvider);

    final sideMenuCtrl = useMemoized(() => SideMenuController());

    ///
    /// these are the bottom navigation items. ex. home, bids, orders, account.
    /// always starts with 0.
    ///
    ///
    /// [icon] -> the icon of the bottom nav bar
    /// [label] -> the name or the display title of the bottom nav bar
    /// [onTap] -> the function that will be called when the button is tapped
    /// in this case the on tap will redirect you to the the other pages
    ///
    final items = <int, CustomNavigationBarItem>{
      0: CustomNavigationBarItem(
        route: RootRoute.path,
        icon: Icon(MIcons.viewDashboard),
        label: 'Dashboard',
        onTap: () {
          RootRoute().go(context);
        },
      ),
      1: CustomNavigationBarItem(
        route: PetsPageRoute.path,
        icon: Icon(MIcons.dogSide),
        label: 'Pets',
        onTap: () {
          PetsPageRoute().go(context);
        },
      ),
      2: CustomNavigationBarItem(
        route: UserPageRoute.path,
        icon: Icon(MIcons.cubeOutline),
        label: 'Products',
        onTap: () {},
      ),
      3: CustomNavigationBarItem(
        route: YourUserPageRoute.path,
        icon: Icon(MIcons.chartLine),
        label: 'Sales',
        onTap: () {},
      ),
      4: CustomNavigationBarItem(
        route: SettingsPageRoute.path,
        icon: Icon(MIcons.accountOutline),
        label: 'Account',
        onTap: () {
          SettingsPageRoute().go(context);
        },
      ),
    };

    ///
    /// Handles the route change. In short this will be called when the button
    /// in the bottom nav bar is tapped. Like the icon in the bottom nav bar
    /// ex. if home is tapped it will go to the home page and this will also be
    /// called
    ///
    onRouteChanged(int index) {
      final item = items[index];
      if (item != null) {
        item.onTap?.call();
      }
    }

    int checkIndex(int currentIndex, int totalItems) {
      if (currentIndex < 0) {
        return totalItems - 1;
      }
      if (currentIndex >= totalItems) {
        return 0;
      }
      return currentIndex;
    }

    final index = checkIndex(shell.currentIndex, items.length);

    ///
    /// will determine if the bottom nav bar should be visible
    /// if true bottomNav will be shown if false it will be hidden
    ///
    /// will only show roots that are in the rootRoutes. if not it wont show it.
    ///
    bool shouldShowBottomNav(
      Map<int, CustomNavigationBarItem> items,
      String? path,
    ) {
      final routes = items.values.map((x) => x.route).toList();
      return routes.filter((t) => t == path).isNotEmpty;
    }

    return ResponsiveBuilder(builder: (context, sizeInfo) {
      if (!sizeInfo.isMobile) {
        return Scaffold(
          body: Row(
            children: [
              SideMenu(
                minWidth: 80,
                maxWidth: 200,
                controller: sideMenuCtrl,
                mode: SideMenuMode.compact,
                builder: (data) => SideMenuData(
                  header: sideMenuCtrl.isCollapsed()
                      ? SizedBox(
                          height: 100,
                          child: FlutterLogo(),
                        )
                      : SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                FlutterLogo(),
                                SizedBox(width: 10),
                                Text('Sample System'),
                              ],
                            ),
                          ),
                        ),
                  items: items.values.mapWithIndex((e, index) {
                    return SideMenuItemDataTile(
                      hasSelectedLine: false,
                      isSelected: shell.currentIndex == index,
                      onTap: () => e.onTap?.call(),
                      title: e.label,
                      icon: e.icon,
                    );
                  }).toList(),
                  footer: sideMenuCtrl.isCollapsed()
                      ? Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(MIcons.accountCircleOutline),
                            ),
                            SizedBox(height: 5),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(MIcons.logout),
                            ),
                            SizedBox(height: 10),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(MIcons.accountCircleOutline),
                              label: Text('Sample Name'),
                            ),
                            SizedBox(height: 5),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(MIcons.logout),
                              label: Text('Logout'),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                ),
              ),
              Expanded(child: shell),
            ],
          ),
        );
      }

      return Scaffold(
        ///
        /// this will be the content of your app
        ///
        body: shell,

        ///
        /// the bottom bar. the 4 icon button in the root of the app.
        ///
        bottomNavigationBar: shouldShowBottomNav(items, state.fullPath)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(height: 0),
                  BottomNavigationBar(
                    elevation: 0,
                    currentIndex: index,
                    selectedFontSize: 13,
                    unselectedFontSize: 11,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: theme.colorScheme.primary,
                    ),
                    selectedItemColor: theme.colorScheme.primary,
                    type: BottomNavigationBarType.fixed,
                    items: items.entries.map((e) => e.value).toList(),
                    onTap: onRouteChanged,
                  )
                ],
              )
            : null,
      );
    });
  }
}
