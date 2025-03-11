import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/type_defs/custom_navbar_item.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/logo.dart';
import 'package:gym_system/src/core/widgets/mobile_bottom_nav.dart';
import 'package:gym_system/src/features/authentication/presentation/widgets/account_circle_image.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment/treatments_controller.dart';
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
    ref.watch(treatmentsControllerProvider);

    final sideMenuCtrl = useMemoized(() => SideMenuController());
    final canPop = useState(false);

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
        icon: Icon(MIcons.viewDashboardOutline),
        selectedIcon: Icon(MIcons.viewDashboard),
        label: 'Dashboard',
        onTap: () {
          RootRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: PatientsPageRoute.path,
        icon: Icon(MIcons.clipboardAccountOutline),
        selectedIcon: Icon(MIcons.clipboardAccount),
        label: 'Patients',
        onTap: () {
          PatientsPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: ProductsPageRoute.path,
        icon: Icon(MIcons.shoppingOutline),
        selectedIcon: Icon(MIcons.shopping),
        label: 'Products',
        onTap: () {
          ProductsPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: SalesPageRoute.path,
        icon: Icon(MIcons.chartLineVariant),
        selectedIcon: Icon(MIcons.chartLine),
        label: 'Sales',
        onTap: () {
          SalesPageRoute().go(context);
        },
      ),
      CustomNavigationBarItem(
        route: UsersPageRoute.path,
        icon: Icon(MIcons.accountGroupOutline),
        selectedIcon: Icon(MIcons.accountGroup),
        label: 'Users',
        onTap: () {
          UsersPageRoute().go(context);
        },
      ),
    ];

    return ResponsiveBuilder(builder: (context, sizeInfo) {
      if (sizeInfo.isTablet || sizeInfo.isDesktop) {
        return Scaffold(
          body: Row(
            children: [
              SideMenu(
                minWidth: 80,
                maxWidth: 200,
                controller: sideMenuCtrl,
                mode: SideMenuMode.open,
                backgroundColor: theme.appBarTheme.backgroundColor,
                builder: (data) => SideMenuData(
                  header: Logo(
                    width: null,
                    height: null,
                  ),
                  items: items.mapWithIndex((e, index) {
                    return SideMenuItemDataTile(
                        hasSelectedLine: false,
                        isSelected: shell.currentIndex == index,
                        onTap: () => e.onTap?.call(),
                        title: e.label,
                        icon: e.icon,
                        selectedIcon: e.selectedIcon);
                  }).toList(),
                  footer: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () => YourAccountPageRoute().go(context),
                      child: AccountCircleImage(
                        radius: !sideMenuCtrl.isCollapsed() ? 30 : 40,
                        showName: !sideMenuCtrl.isCollapsed(),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: shell),
            ],
          ),
        );
      }

      return PopScope(
        canPop: canPop.value,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final confirm = await ConfirmModal.show(context,
                  title: 'Exit', message: 'Are you sure you want to exit?') ??
              false;
          if (context.mounted && confirm) {
            context.canPop();
          }
        },
        child: Scaffold(
          body: shell,
          bottomNavigationBar: MobileBottomNav(
            index: shell.currentIndex,
            list: items,
            state: state,
          ),
        ),
      );
    });
  }
}
