import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/type_defs/custom_navbar_item.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/mobile_bottom_nav.dart';
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
    final items = [
      CustomNavigationBarItem(
        route: RootRoute.path,
        icon: Icon(MIcons.viewDashboard),
        label: 'Dashboard',
        onTap: () {
          RootRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: PatientsPageRoute.path,
        icon: Icon(MIcons.clipboardAccount),
        label: 'Patients',
        onTap: () {
          PatientsPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: ProductsPageRoute.path,
        icon: Icon(MIcons.shoppingOutline),
        label: 'Products',
        onTap: () {
          ProductsPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: SalesPageRoute.path,
        icon: Icon(MIcons.chartLine),
        label: 'Sales',
        onTap: () {
          SalesPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: StaffsPageRoute.path,
        icon: Icon(MIcons.accountGroupOutline),
        label: 'Staffs',
        onTap: () {
          StaffsPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: AccountPageRoute.path,
        icon: Icon(MIcons.accountCircle),
        label: 'Account',
        onTap: () {
          AccountPageRoute().go(context);
        },
      ),
    ];

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
                  items: items.mapWithIndex((e, index) {
                    return SideMenuItemDataTile(
                      hasSelectedLine: false,
                      isSelected: shell.currentIndex == index,
                      onTap: () => e.onTap?.call(),
                      title: e.label,
                      icon: e.icon,
                    );
                  }).toList(),
                  footer: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      child: CircleAvatar(),
                    ),
                  ),
                ),
              ),
              Expanded(child: shell),
            ],
          ),
        );
      }

      return Scaffold(
        body: shell,
        bottomNavigationBar: MobileBottomNav(
          index: shell.currentIndex,
          list: items,
          state: state,
        ),
      );
    });
  }
}
