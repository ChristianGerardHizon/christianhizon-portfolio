import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/app_version.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_admin.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:sannjosevet/src/features/system_versions/presentation/widgets/system_version_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:theme_provider/theme_provider.dart';

class YourAccountPage extends HookConsumerWidget {
  const YourAccountPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    ///
    ///
    ///
    onLogout() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;

      final result =
          await ref.read(authControllerProvider.notifier).logout().run();
      result.fold(
        (l) => AppSnackBar.rootError(message: l.toString()),
        (r) => const LoginPageRoute().go(context),
      );
    }

    final themeController = ThemeProvider.controllerOf(context);

    return Scaffold(
      body: state.when(
        error: (error, stack) => SizedBox(),
        loading: () => Center(child: CircularProgressIndicator()),
        data: (auth) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                // SliverAppBar(
                //   actions: [RefreshButton(onPressed: onRefresh)],
                // ),
                SliverToBoxAdapter(child: SizedBox(height: 20)),
                DynamicGroup.sliver(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                  header: 'Your Account',
                  items: [
                    auth.map<DynamicGroupItem>(
                      (user) => DynamicGroupItem.action(
                        onTap: () => UserPageRoute(auth.id).push(context),
                        title: 'Your Profile',
                        trailing: Icon(MIcons.chevronRight),
                      ),
                      (admin) => DynamicGroupItem.action(
                        onTap: () => AdminPageRoute(auth.id).push(context),
                        title: 'Your Profile',
                        trailing: Icon(MIcons.chevronRight),
                      ),
                    ),
                    DynamicGroupItem.text(
                      title: 'Domain',
                      value: ref.read(pocketbaseProvider).baseURL,
                    ),
                    DynamicGroupItem.action(
                      title: 'Theme',
                      leading: Icon(
                        Icons.sunny,
                      ),
                      onTap: () => themeController.nextTheme(),
                    ),
                    DynamicGroupItem.action(
                      title: 'Logout',
                      titleColor: theme.colorScheme.error,
                      leading: Icon(
                        Icons.logout_outlined,
                        color: theme.colorScheme.error,
                      ),
                      onTap: () => onLogout(),
                    ),
                  ],
                ),

                SliverToBoxAdapter(child: SizedBox(height: 20)),
                if (auth is AuthAdmin)
                  DynamicGroup.sliver(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                    header: 'Admin Section',
                    items: [
                      /// Sales
                      DynamicGroupItem.action(
                        title: 'Sales',
                        leading: Icon(MIcons.chartLineVariant),
                        onTap: () {
                          SalesPageRoute().push(context);
                        },
                      ),
                      DynamicGroupItem.action(
                        title: 'Changes',
                        leading: Icon(MIcons.pencil),
                        onTap: () {
                          ChangeLogsPageRoute().push(context);
                        },
                      ),

                      DynamicGroupItem.action(
                        title: 'Branches',
                        leading: Icon(MIcons.storeOutline),
                        onTap: () {
                          BranchesPageRoute().push(context);
                        },
                      ),

                      DynamicGroupItem.action(
                        title: 'Species and Breeds',
                        leading: Icon(MIcons.dogService),
                        onTap: () {
                          PatientSpeciesListPageRoute().push(context);
                        },
                      ),

                      DynamicGroupItem.action(
                        title: 'Treatments',
                        leading: Icon(MIcons.ambulance),
                        onTap: () {
                          PatientTreatmentPageRoute().push(context);
                        },
                      ),

                      DynamicGroupItem.action(
                        title: 'Product Categories',
                        leading: Icon(MIcons.cubeOutline),
                        onTap: () {
                          ProductCategoriesPageRoute().push(context);
                        },
                      ),

                      DynamicGroupItem.action(
                        title: 'Users',
                        leading: Icon(MIcons.accountGroupOutline),
                        onTap: () {
                          UsersPageRoute().push(context);
                        },
                      ),

                      DynamicGroupItem.action(
                        title: 'Admins',
                        leading: Icon(MIcons.accountSupervisorOutline),
                        onTap: () {
                          AdminsPageRoute().push(context);
                        },
                      ),
                    ],
                  ),

                SliverList.list(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AppVersion(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SystemVersionWidget(),
                    ),
                  ],
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: 40),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
