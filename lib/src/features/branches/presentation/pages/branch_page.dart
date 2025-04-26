import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branch_table_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BranchPage extends HookConsumerWidget {
  const BranchPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = branchControllerProvider(id);
    final state = ref.watch(provider);
    final branch = useState<Branch?>(null);

    ///
    /// onDelete
    ///
    onDelete(Branch branch) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(branchRepositoryProvider);
      repo.softDeleteMulti([branch.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(patientTableControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                if (context.canPop()) context.pop();
              },
            );
          });
    }

    ///
    /// Refresh
    ///
    refresh() async {
      ref.invalidate(provider);
      ref.invalidate(branchTableControllerProvider);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: state.when(
          skipError: false,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          loading: () => Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (branch) {
            return CustomScrollView(
              slivers: [
                ///
                /// AppBar
                ///
                SliverAppBar(
                  title: Text(branch.name),
                ),

                ///
                /// Content
                ///
                SliverList.list(
                  children: [
                    SizedBox(height: 20),

                    ///
                    /// Branch General Info
                    ///
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        child: CollapsingCard(
                          header: Text(
                            'Branch Info',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          child: Column(
                            children: [
                              ///
                              /// name
                              ///
                              DynamicListTile(
                                title: Text('Name: '),
                                content: Text(branch.name),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///
                    /// System Details
                    ///
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        child: CollapsingCard(
                          header: Text(
                            'Other Info',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          child: Column(
                            children: [
                              DynamicListTile(
                                title: Text('Created At: '),
                                content: Text(
                                    (branch.created?.toLocal().yyyyMMddHHmmA())
                                        .optional()),
                              ),
                              Divider(),
                              DynamicListTile(
                                title: Text('Updated At: '),
                                content: Text(
                                    (branch.updated?.toLocal().yyyyMMddHHmmA())
                                        .optional()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CardGroup(
                        header: 'Actions',
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit_outlined),
                            title: const Text('Edit Branch Information'),
                            trailing: const Icon(
                              Icons.chevron_right_outlined,
                              size: 24,
                            ),
                            onTap: () => BranchFormPageRoute(id: branch.id)
                                .push(context),
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete_outlined),
                            title: const Text('Delete Branch Permanently'),
                            trailing: const Icon(
                              Icons.chevron_right_outlined,
                              size: 24,
                            ),
                            onTap: () => onDelete(branch),
                          ),
                        ],
                      ),
                    ),

                    ///
                    /// Spacer
                    ///
                    SizedBox(height: 50),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
