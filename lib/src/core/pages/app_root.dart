import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/controllers/scaffold_controller.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/models/custom_navbar_item.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/logo.dart';
import 'package:sannjosevet/src/core/widgets/mobile_bottom_nav.dart';
import 'package:sannjosevet/src/core/widgets/mobile_drawer.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:sannjosevet/src/features/authentication/presentation/widgets/account_circle_image.dart';
import 'package:sannjosevet/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:sannjosevet/src/features/patient_treaments/presentation/controllers/patient_treatments_controller.dart';
import 'package:sannjosevet/src/features/settings/presentation/controllers/settings_controller.dart';
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

    final scaffoldKey = ref.watch(scaffoldControllerProvider);

    ref.watch(settingsControllerProvider);
    ref.watch(patientTreatmentsControllerProvider);
    ref.watch(branchesControllerProvider);

    ref.watch(tableControllerProvider(TableControllerKeys.product));

    final sideMenuCtrl = useMemoized(() => SideMenuController(), []);
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
    List<CustomNavigationBarItem> buildItems(AuthData auth) {
      // final isAdmin = auth is AuthAdmin;
      // final isUser = auth is AuthUser;

      return [
        CustomNavigationBarItem(
          isRoot: true,
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
          icon: Icon(MIcons.dog),
          selectedIcon: Icon(MIcons.dog),
          label: 'Patients',
          onTap: () {
            PatientsPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: AppointmentSchedulesPageRoute.path,
          icon: Icon(MIcons.calendarAccount),
          selectedIcon: Icon(MIcons.calendarAccountOutline),
          label: 'Appointments',
          onTap: () {
            AppointmentSchedulesPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: CalendarAppointmentSchedulesPageRoute.path,
          icon: Icon(MIcons.calendarOutline),
          selectedIcon: Icon(MIcons.calendar),
          label: 'Calendar',
          onTap: () {
            CalendarAppointmentSchedulesPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: ProductInventoriesPageRoute.path,
          icon: Icon(MIcons.shoppingOutline),
          selectedIcon: Icon(MIcons.shopping),
          label: 'Products',
          onTap: () {
            ProductInventoriesPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: SalesCashierPageRoute.path,
          icon: Icon(MIcons.cashRegister),
          selectedIcon: Icon(MIcons.cashRegister),
          label: 'Cashier',
          onTap: () {
            SalesCashierPageRoute().go(context);
          },
        ),
        // CustomNavigationBarItem(
        //   route: SalesPageRoute.path,
        //   icon: Icon(MIcons.chartLineVariant),
        //   selectedIcon: Icon(MIcons.chartLine),
        //   label: 'Sales',
        //   onTap: () {
        //     SalesPageRoute().go(context);
        //   },
        // ),
        // if (isAdmin)
        //   CustomNavigationBarItem(
        //     route: ChangeLogsPageRoute.path,
        //     icon: Icon(MIcons.pencilOutline),
        //     selectedIcon: Icon(MIcons.pencil),
        //     label: 'Changes',
        //     onTap: () {
        //       ChangeLogsPageRoute().go(context);
        //     },
        //   ),
        // if (isAdmin)
        //   CustomNavigationBarItem(
        //     route: BranchesPageRoute.path,
        //     icon: Icon(MIcons.storeOutline),
        //     selectedIcon: Icon(MIcons.store),
        //     label: 'Branches',
        //     onTap: () {
        //       BranchesPageRoute().go(context);
        //     },
        //   ),
        // if (isAdmin)
        //   CustomNavigationBarItem(
        //     route: UsersPageRoute.path,
        //     icon: Icon(MIcons.accountGroupOutline),
        //     selectedIcon: Icon(MIcons.accountGroup),
        //     label: 'Users',
        //     onTap: () {
        //       UsersPageRoute().go(context);
        //     },
        //   ),
        // if (isAdmin)
        //   CustomNavigationBarItem(
        //     route: AdminsPageRoute.path,
        //     icon: Icon(MIcons.accountSupervisorOutline),
        //     selectedIcon: Icon(MIcons.accountSupervisor),
        //     label: 'Admins',
        //     onTap: () {
        //       AdminsPageRoute().go(context);
        //     },
        //   ),
      ];
    }

    final errorWidget = SizedBox();
    final loadingWidget = SizedBox();

    return Scaffold(
      key: scaffoldKey,
      drawer: MobileDrawer(rootContext: context),
      body: ref.watch(authControllerProvider).when(
            error: (error, stack) => errorWidget,
            loading: () => loadingWidget,
            data: (auth) {
              final items = buildItems(auth);
              return ResponsiveBuilder(builder: (context, sizeInfo) {
                if (sizeInfo.isTablet || sizeInfo.isDesktop) {
                  return Row(
                    children: [
                      SideMenu(
                        minWidth: 80,
                        maxWidth: 200,
                        controller: sideMenuCtrl,
                        mode: SideMenuMode.open,
                        backgroundColor: theme.scaffoldBackgroundColor,
                        builder: (data) => SideMenuData(
                          header: Logo(
                            height: sideMenuCtrl.isCollapsed() ? 60 : 150,
                          ),
                          items: items.mapWithIndex((e, index) {
                            final goRouter = GoRouter.of(context);
                            final currentLocation = goRouter
                                .routerDelegate.currentConfiguration.uri
                                .toString();
                            return SideMenuItemDataTile(
                              decoration: BoxDecoration(
                                color: currentLocation == e.route
                                    ? theme.colorScheme.primaryContainer
                                        .withValues(alpha: .3)
                                    : null,
                              ),
                              clipBehavior: Clip.none,
                              titleStyle: TextStyle(
                                color: currentLocation == e.route
                                    ? theme.primaryColor
                                    : null,
                                fontSize: 14,
                              ),
                              selectedTitleStyle: TextStyle(
                                color: currentLocation == e.route
                                    ? theme.colorScheme.primary
                                    : null,
                                fontSize: 14,
                              ),
                              hasSelectedLine: true,
                              isSelected: e.isRoot
                                  ? currentLocation == RootRoute.path
                                  : currentLocation.contains(e.route),
                              onTap: () => e.onTap?.call(),
                              title: e.label,
                              icon: e.icon,
                              selectedIcon: e.selectedIcon,
                            );
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
                  );
                }

                return PopScope(
                  canPop: canPop.value,
                  onPopInvokedWithResult: (didPop, result) async {
                    if (didPop) return;
                    final confirm = await ConfirmModal.show(context,
                            title: 'Exit',
                            message: 'Are you sure you want to exit?') ??
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
            },
          ),
    );
  }
}
