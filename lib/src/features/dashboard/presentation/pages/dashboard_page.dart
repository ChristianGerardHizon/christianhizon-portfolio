import 'package:flutter/material.dart';
import 'package:gym_system/src/features/authentication/domain/auth_admin.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ///
          /// Welcome Message
          ///
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: ref.watch(authControllerProvider).when(
                    data: (user) {
                      if (user is AuthUser) {
                        return Text(
                          'Welcome ${user.record.name}',
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      }
            
                      if (user is AuthAdmin) {
                        return Text(
                          'Welcome ${user.record.name}',
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      }
            
                      return SizedBox();
                    },
                    error: (error, stacl) => SizedBox(),
                    loading: () => Text('Loading...'),
                  ),
            ),
          )

          ///
          /// Cards
          ///
        ],
      ),
    );
  }
}
