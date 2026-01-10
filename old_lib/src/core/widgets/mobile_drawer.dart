import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/controllers/scaffold_controller.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/controllers/auth_controller.dart';

class MobileDrawer extends HookConsumerWidget {
  final BuildContext rootContext;

  const MobileDrawer({
    super.key,
    required this.rootContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(scaffoldControllerProvider);

    void closeDrawerAndNavigate(void Function() navigate) {
      scaffoldKey.currentState?.closeDrawer();
      navigate();
    }

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Center(
                child: Logo(),
              ),
            ),

            // Dashboard
            ListTile(
              leading: Icon(MIcons.homeOutline),
              title: const Text('Dashboard'),
              onTap: () => closeDrawerAndNavigate(
                () => DashboardPageRoute().go(context),
              ),
            ),

            const Divider(),

            // Patients Section
            ExpansionTile(
              leading: Icon(MIcons.pawOutline),
              title: const Text('Patients'),
              children: [
                ListTile(
                  leading: Icon(MIcons.formatListBulleted),
                  title: const Text('All Patients'),
                  onTap: () => closeDrawerAndNavigate(
                    () => PatientsPageRoute().go(context),
                  ),
                ),
              ],
            ),

            // Patient Configuration Section
            ExpansionTile(
              leading: Icon(MIcons.cogOutline),
              title: const Text('Patient Config'),
              children: [
                ListTile(
                  leading: Icon(MIcons.dna),
                  title: const Text('Species'),
                  onTap: () => closeDrawerAndNavigate(
                    () => PatientSpeciesListPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.medicalBag),
                  title: const Text('Treatments'),
                  onTap: () => closeDrawerAndNavigate(
                    () => PatientTreatmentPageRoute().go(context),
                  ),
                ),
              ],
            ),

            // Appointments Section
            ExpansionTile(
              leading: Icon(MIcons.calendarOutline),
              title: const Text('Appointments'),
              children: [
                ListTile(
                  leading: Icon(MIcons.formatListBulleted),
                  title: const Text('All Appointments'),
                  onTap: () => closeDrawerAndNavigate(
                    () => AppointmentSchedulesPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.calendarMonth),
                  title: const Text('Calendar'),
                  onTap: () => closeDrawerAndNavigate(
                    () => CalendarAppointmentSchedulesPageRoute().go(context),
                  ),
                ),
              ],
            ),

            // Products Section
            ExpansionTile(
              leading: Icon(MIcons.packageVariantClosed),
              title: const Text('Products'),
              children: [
                ListTile(
                  leading: Icon(MIcons.formatListBulleted),
                  title: const Text('All Products'),
                  onTap: () => closeDrawerAndNavigate(
                    () => ProductsPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.packageVariant),
                  title: const Text('Inventories'),
                  onTap: () => closeDrawerAndNavigate(
                    () => ProductInventoriesPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.tag),
                  title: const Text('Categories'),
                  onTap: () => closeDrawerAndNavigate(
                    () => ProductCategoriesPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.tuneVariant),
                  title: const Text('Adjustments'),
                  onTap: () => closeDrawerAndNavigate(
                    () => ProductAdjustmentsPageRoute().go(context),
                  ),
                ),
              ],
            ),

            // Sales Section
            ListTile(
              leading: Icon(MIcons.cashRegister),
              title: const Text('Cashier'),
              onTap: () => closeDrawerAndNavigate(
                () => SalesCashierPageRoute().go(context),
              ),
            ),

            const Divider(),

            // Organization Section
            ExpansionTile(
              leading: Icon(MIcons.officeBuildingOutline),
              title: const Text('Organization'),
              children: [
                ListTile(
                  leading: Icon(MIcons.shieldAccount),
                  title: const Text('Admins'),
                  onTap: () => closeDrawerAndNavigate(
                    () => AdminsPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.accountGroup),
                  title: const Text('Users'),
                  onTap: () => closeDrawerAndNavigate(
                    () => UsersPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.officeBuilding),
                  title: const Text('Branches'),
                  onTap: () => closeDrawerAndNavigate(
                    () => BranchesPageRoute().go(context),
                  ),
                ),
              ],
            ),

            // System Section
            ExpansionTile(
              leading: Icon(MIcons.cog),
              title: const Text('System'),
              children: [
                ListTile(
                  leading: Icon(MIcons.cogOutline),
                  title: const Text('Settings'),
                  onTap: () => closeDrawerAndNavigate(
                    () => SettingsPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.domain),
                  title: const Text('Domain'),
                  onTap: () => closeDrawerAndNavigate(
                    () => DomainPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.history),
                  title: const Text('Change Logs'),
                  onTap: () => closeDrawerAndNavigate(
                    () => ChangeLogsPageRoute().go(context),
                  ),
                ),
                ListTile(
                  leading: Icon(MIcons.accountCircleOutline),
                  title: const Text('Your Account'),
                  onTap: () => closeDrawerAndNavigate(
                    () => YourAccountPageRoute().go(context),
                  ),
                ),
              ],
            ),

            const Divider(),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                ref.read(authControllerProvider.notifier).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
