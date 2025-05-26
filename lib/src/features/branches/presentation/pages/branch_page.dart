import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BranchPage extends HookConsumerWidget {
  const BranchPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(branchRepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(branchControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(Branch branch) {
      BranchFormPageRoute(id: branch.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(Branch branch) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([branch.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  branchId: branch.id,
                  refresh: refresh,
                ),
              );

      isLoading.value = true;
      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Branch Details'),
        actions: [
          RefreshButton(
            onPressed: () => refresh(id),
          )
        ],
      ),
      body: ref.watch(branchControllerProvider(id)).when(
            error: (error, stack) => FailureMessage(error, stack),
            loading: () => Center(child: CircularProgressIndicator()),
            data: (branch) {
              return StackLoader(
                isLoading: isLoading.value,
                child: CustomScrollView(
                  slivers: [
                    ///
                    /// Content
                    ///
                    SliverList.list(
                      children: [
                        SizedBox(height: 20),

                        ///
                        /// Information
                        ///
                        DynamicGroup(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 12),
                          header: 'Branch Information',
                          items: [
                            DynamicGroupItem.text(
                              title: 'Name',
                              value: branch.name,
                            ),
                            DynamicGroupItem.text(
                              title: 'Last Updated',
                              value: (branch.updated?.toLocal().fullReadable)
                                  .optional(),
                            ),
                            DynamicGroupItem.text(
                              title: 'Created',
                              value: (branch.created?.toLocal().fullReadable)
                                  .optional(),
                            ),
                          ],
                        ),

                        ///
                        /// Actions
                        ///
                        DynamicGroup(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 12),
                          header: 'Actions',
                          items: [
                            DynamicGroupItem.action(
                              onTap: () => tap(branch),
                              leading: Icon(MIcons.fileEditOutline),
                              title: 'Edit Details',
                              trailing: Icon(MIcons.chevronRight),
                            ),
                            DynamicGroupItem.action(
                              titleColor: Theme.of(context).colorScheme.error,
                              onTap: () => onDelete(branch),
                              leading: Icon(
                                MIcons.trashCan,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              title: 'Delete',
                              trailing: Icon(MIcons.chevronRight),
                            ),
                          ],
                        ),

                        ///
                        /// Spacer
                        ///
                        SizedBox(height: 50),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String branchId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(branchId);
    return null;
  }).toTaskEither<Failure>();
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}
