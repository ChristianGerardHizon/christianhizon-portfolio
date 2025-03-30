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
import 'package:gym_system/src/features/admins/data/admin_repository.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admin_controller.dart';
import 'package:gym_system/src/features/admins/presentation/widgets/admin_circle_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminPage extends HookConsumerWidget {
  final String id;

  const AdminPage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = adminControllerProvider(id);
    final state = ref.watch(provider);

    ///
    /// onDelete
    ///
    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(adminRepositoryProvider);
      final result = repo.softDeleteMulti([id]).run();
      result.then((result) {
        result.fold(
          (l) => AppSnackBar.rootFailure(l),
          (r) {
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
        data: (admin) {
          return CustomScrollView(
            slivers: [
              ///
              /// AppBar
              ///
              SliverAppBar(
                title: Text(admin.name),
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
                    child: AdminCircleImage(
                      radius: 100,
                      admin: admin,
                    ),
                  ),
                ),
              ),

              ///
              /// Admin Info
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
                        content: Text(admin.email),
                      ),

                      ///
                      /// name
                      ///
                      DynamicListTile.divider(
                        leading: Text('Name: '),
                        content: Text(admin.name),
                      ),

                      ///
                      /// updated
                      ///
                      DynamicListTile.divider(
                        leading: Text('Updated: '),
                        content:
                            Text((admin.updated?.yyyyMMddHHmm()).optional()),
                      ),

                      ///
                      /// created
                      ///
                      DynamicListTile(
                        leading: Text('Created: '),
                        content:
                            Text((admin.created?.yyyyMMddHHmm()).optional()),
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
                        title: const Text('Edit Admin Information'),
                        trailing: const Icon(
                          Icons.chevron_right_outlined,
                          size: 24,
                        ),
                        onTap: () => AdminUpdatePageRoute(id).push(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_outlined),
                        title: const Text('Delete Admin Permanently'),
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
