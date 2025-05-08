import 'package:flutter/material.dart';
import 'package:gym_system/src/core/controllers/scaffold_controller.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MobileDrawer extends HookConsumerWidget {
  final BuildContext rootContext;

  const MobileDrawer({
    super.key,
    required this.rootContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(scaffoldControllerProvider);
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  // color: Theme.of(context).colorScheme.primaryContainer,
                  ),
              child: Center(
                child: Logo(),
              ),
            ),
            ListTile(
              leading: Icon(MIcons.homeOutline),
              title: const Text('Dashboard'),
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                DashboardPageRoute().go(context);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Account'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Privacy'),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.category),
              title: const Text('Products'),
              children: [
                ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('All Products'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Featured'),
                  onTap: () {},
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // handle logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
