import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/center_progress_indicator.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// Logout
    ///
    void onLogout() {
      ref.read(authControllerProvider.notifier).logout().run();
    }

    ///
    /// Refresh
    ///
    Future<void> onRefresh() async {
      await ref.read(authControllerProvider.notifier).refresh().run();
    }

    ///
    /// Navigate to account update page
    ///
    // void onAccountUpdate(User user) async {
    //   final result = await UserFormPageRoute(id: user.id).push(context);
    //   if (result is User) {
    //     ref.invalidate(authControllerProvider);
    //     AppSnackBar.root(message: 'updated success');
    //   }
    // }

    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            authState.when(
              skipError: false,
              skipLoadingOnRefresh: false,
              skipLoadingOnReload: false,
              data: (user) {
                return SliverList.list(
                  children: [
                    ///
                    /// logout
                    ///
                    ListTile(
                      leading: Icon(
                        MIcons.logout,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: const Text('Logout'),
                      onTap: onLogout,
                    ),
                  ],
                );
              },
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Text(error.toString()),
                ),
              ),
              loading: () {
                return const SliverFillRemaining(
                  child: CenteredProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
