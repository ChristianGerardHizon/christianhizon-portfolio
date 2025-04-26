import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_table_controller.dart';
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
            ref.invalidate(userTableControllerProvider);
            AppSnackBar.root(message: 'Successfully Deleted');
            if (context.canPop()) context.pop();
          },
        );
      });
    }

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => CenteredProgressIndicator(),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (user) {
          return CustomScrollView(
            slivers: [
              ///
              /// AppBar
              ///
              SliverAppBar(
                title: Text(user.name),
                actions: [
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
                sliver: SliverToBoxAdapter(
                  child: CollapsingCard(
                    canCollapse: false,
                    header: Text(
                      'Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    child: Column(children: [
                      ///
                      /// email
                      ///
                      DynamicListTile.divider(
                        leading: Text('Email: '),
                        content: Text(user.email),
                      ),

                      ///
                      /// name
                      ///
                      DynamicListTile.divider(
                        leading: Text('Name: '),
                        content: Text(user.name),
                      ),

                      ///
                      /// updated
                      ///
                      DynamicListTile.divider(
                        leading: Text('Updated: '),
                        content:
                            Text((user.updated?.yyyyMMddHHmm()).optional()),
                      ),

                      ///
                      /// created
                      ///
                      DynamicListTile(
                        leading: Text('Created: '),
                        content:
                            Text((user.created?.yyyyMMddHHmm()).optional()),
                      ),
                    ]),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverToBoxAdapter(
                  child: CardGroup(
                    header: 'Actions',
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: const Text('Edit User Information'),
                        trailing: const Icon(
                          Icons.chevron_right_outlined,
                          size: 24,
                        ),
                        onTap: () => UserFormPageRoute(id: id).push(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: const Text('Change Password'),
                        trailing: const Icon(
                          Icons.chevron_right_outlined,
                          size: 24,
                        ),
                        onTap: () => UserFormPageRoute(id: id).push(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_outlined),
                        title: const Text('Delete User Permanently'),
                        trailing: const Icon(
                          Icons.chevron_right_outlined,
                          size: 24,
                        ),
                        onTap: onDelete,
                      ),
                    ],
                  ),
                ),
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
