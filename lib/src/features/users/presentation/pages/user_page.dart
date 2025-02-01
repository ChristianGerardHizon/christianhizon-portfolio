import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_controller.dart';
import 'package:gym_system/src/features/users/presentation/widgets/user_circle_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPage extends HookConsumerWidget {
  final String id;

  const UserPage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = userControllerProvider(id);
    final state = ref.watch(provider);

    ///
    /// onDelete
    ///
    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(userRepositoryProvider);
      final result = repo.softDeleteMulti([id]).run();
      result.then((result) {
        result.fold(
          (l) => AppSnackBar.rootFailure(l),
          (r) {
            ref.invalidate(usersControllerProvider);
            AppSnackBar.root(message: 'Successfully Deleted');
            PatientsPageRoute().go(context);
          },
        );
      });
    }

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (user) {
          return CustomScrollView(
            slivers: [
              ///
              /// AppBar
              ///
              SliverAppBar(
                leading: BackButton(
                  onPressed: () => UsersPageRoute().go(context),
                ),
                title: Text(user.name),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => UserUpdatePageRoute(id).go(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => ref.invalidate(provider),
                  )
                ],
              ),

              ///
              /// Picture
              ///
              SliverPadding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    child: UserCircleImage(
                      radius: 100,
                      user: user,
                    ),
                  ),
                ),
              ),

              ///
              /// User Info
              ///
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.list(children: [
                  ///
                  /// Header
                  ///
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 14),
                    title: Text(
                      'User Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  ///
                  /// email
                  ///
                  ListTile(
                    leading: Text('Email: '),
                    title: Text(user.email),
                  ),

                  ///
                  /// name
                  ///
                  ListTile(
                    leading: Text('Name: '),
                    title: Text(user.name),
                  ),

                  ///
                  /// create
                  ///
                  ListTile(
                    leading: Text('Updated: '),
                    title: Text((user.updated?.yyyyMMddHHmm()).optional()),
                  ),

                  ///
                  /// name
                  ///
                  ListTile(
                    leading: Text('Created: '),
                    title: Text((user.created?.yyyyMMddHHmm()).optional()),
                  ),
                ]),
              ),

              ///
              /// Spacer
              ///
              SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        },
      ),
    );
  }
}
