import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    ref.listen(authControllerProvider, (previous, current) {
      if (current is AsyncError) const LoginPageRoute().go(context);
    });

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Placeholder(
            child: Text('Home Page'),
          ),
          ListTile(
            title: const Text('Account'),
            subtitle: const Text('your account details will be here'),
            onTap: () => const AccountPageRoute().push(context),
          ),
          ListTile(
            title: const Text('Settings'),
            subtitle: const Text('your orders are all here'),
            onTap: () => const SettingsPageRoute().push(context),
          )
        ],
      ),
    );
  }
}
