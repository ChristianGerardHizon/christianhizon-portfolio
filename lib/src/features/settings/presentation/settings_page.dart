import 'package:flutter/material.dart';
import 'package:gym_system/src/core/common_widgets/app_snackbar.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/authentication/presentation/widgets/auth_builder.dart';
import 'package:gym_system/src/features/user/presentation/widgets/user_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
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
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: [
          ///
          /// User Profile
          ///
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 205,
            ),
            child: AuthBuilder(
              builder: (user) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (user.hasPicture)
                      ClipOval(
                        child: CircleAvatar(
                          maxRadius: 60,
                          minRadius: 50,
                          backgroundColor: Colors.transparent,
                          child: UserImage(user: user),
                        ),
                      ),
                    SizedBox(height: 20),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(user.name),
                  ],
                );
              },
            ),
          ),

          ///
          ///
          ///
          // ListTile(
          //   title: const Text('Server URL'),
          //   onTap: () => const DomainPageRoute().push(context),
          //   trailing: const Icon(Icons.chevron_right),
          // ),
          AuthBuilder(
            builder: (user) {
              return Column(
                children: [
                  ListTile(
                    title: const Text('Update Your Profile'),
                    onTap: () => UserUpdatePageRoute(user.id).push(context),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              );
            },
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
          )
        ],
      ),
    );
  }
}
