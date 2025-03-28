import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/authentication/domain/auth_admin.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YourAccountPage extends HookConsumerWidget {
  const YourAccountPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    onLogout() async {
      final result =
          await ref.read(authControllerProvider.notifier).logout().run();
      result.fold(
        (l) => AppSnackBar.rootError(message: l.toString()),
        (r) => const LoginPageRoute().go(context),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Your Account'),
            actions: [
              RefreshButton(onPressed: () {
                ref.read(authControllerProvider.notifier).refresh().run();
              })
            ],
          ),
          SliverList.list(children: [
            ListTile(
              title: Text('Domain'),
              subtitle: Text(ref.read(pocketbaseProvider).baseURL),
            ),
            // state.maybeWhen(
            //   orElse: () => SizedBox(),
            //   data: (data) {
            //     final user = data;
            //     if (user is AuthUser) {
            //       return ListTile(
            //         title: Text(user.record.name),
            //         subtitle: Column(
            //           children: [
            //             Text('User'),
            //             Text(user.record.toJson()),
            //           ],
            //         ),
            //       );
            //     }
            //     if (user is AuthAdmin) {
            //       return ListTile(
            //         title: Text(user.record.name),
            //         subtitle: Column(
            //           children: [
            //             Text('Admin'),
            //             Text(user.record.toJson()),
            //           ],
            //         ),
            //       );
            //     }
            //     return Text('Unkown User Type');
            //   },
            // ),
            ref.watch(authControllerProvider).maybeWhen(
                  skipError: true,
                  skipLoadingOnRefresh: true,
                  skipLoadingOnReload: true,
                  data: (auth) {
                    return auth.map<Widget>(
                      (user) => ListTile(
                        onTap: () => UserPageRoute(auth.id).push(context),
                        title: Text('Your User Profile'),
                        subtitle: Text(user.record.email),
                      ),
                      (admin) => ListTile(
                        onTap: () => AdminPageRoute(auth.id).push(context),
                        title: Text('Your Admin Profile'),
                        subtitle: Text(admin.record.email),
                      ),
                    );
                  },
                  orElse: () => SizedBox(),
                ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: onLogout,
            ),
          ])
        ],
      ),
    );
  }
}
