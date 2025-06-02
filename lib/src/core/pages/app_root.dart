import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/controllers/nav_items_controller.dart';
import 'package:sannjosevet/src/core/controllers/scaffold_controller.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/logo.dart';
import 'package:sannjosevet/src/core/widgets/mobile_bottom_nav.dart';
import 'package:sannjosevet/src/core/widgets/mobile_drawer.dart';
import 'package:sannjosevet/src/features/authentication/presentation/widgets/account_circle_image.dart';
import 'package:sannjosevet/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:sannjosevet/src/features/patient_treaments/presentation/controllers/patient_treatments_controller.dart';
import 'package:sannjosevet/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppRoot extends HookConsumerWidget {
  final StatefulNavigationShell shell;
  final GoRouterState routerState;

  const AppRoot({super.key, required this.shell, required this.routerState});

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

    final errorWidget = SizedBox();
    final loadingWidget = SizedBox();

    final state = ref.watch(navItemsControllerProvider);

    return Scaffold(
      key: scaffoldKey,
      drawer: MobileDrawer(rootContext: context),
      body: Builder(builder: (context) {
        /// has error
        if (state.hasError) return errorWidget;

        /// is loading
        if (state.isLoading) return loadingWidget;

        /// has value
        final items = state.value ?? [];

        final isMobile = getValueForScreenType<bool>(
          context: context,
          mobile: true,
        );

        if (!isMobile) {
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
                            ? theme.colorScheme.primary
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
                      onTap: () => e.onTap?.call(context),
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
              state: routerState,
            ),
          ),
        );
      }),
    );
  }
}
