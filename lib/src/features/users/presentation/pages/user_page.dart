import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/circle_widget.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/pb_image_circle.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPage extends HookConsumerWidget {
  const UserPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    final state = ref.watch(userControllerProvider(id));

    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(userRepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(userControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(User user) {
      UserFormPageRoute(id: user.id).push(context);
    }

    sendVerification(User user) async {
      final repo = ref.read(userRepositoryProvider);
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.requestVerification(user.email))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulVerifyTaskSidEffects(
                  context: context,
                  userId: user.id,
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

    ///
    /// onDelete
    ///
    onDelete(User user) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([user.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  userId: user.id,
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
        title: const Text('User Details'),
        actions: [
          RefreshButton(
            onPressed: () => refresh(id),
          )
        ],
      ),
      body: state.when(
        error: (error, stack) => FailureMessage(error, stack),
        loading: () => Center(child: CircularProgressIndicator()),
        data: (user) {
          return StackLoader(
            isLoading: isLoading.value,
            child: CustomScrollView(
              slivers: [
                ///
                /// Image
                ///
                SliverPadding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  sliver: SliverToBoxAdapter(
                    child: CircleWidget(
                      size: 300,
                      child: PbImageCircle(
                        radius: 120,
                        collection: user.collectionId,
                        recordId: user.id,
                        file: user.avatar,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

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
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                      header: 'User Information',
                      items: [
                        DynamicGroupItem.text(
                          title: 'Name',
                          value: user.name,
                        ),
                        DynamicGroupItem.text(
                          title: 'Email',
                          value: user.email,
                        ),
                        DynamicGroupItem.text(
                          title: 'Verified',
                          value: user.verified ? 'Yes' : 'No',
                          trailing: user.verified == false
                              ? TextButton(
                                  child: Text(
                                    'Send Verification',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  onPressed: () => sendVerification(user),
                                )
                              : null,
                        ),
                        DynamicGroupItem.text(
                          title: 'Last Updated',
                          value:
                              (user.updated?.toLocal().fullReadable).optional(),
                        ),
                        DynamicGroupItem.text(
                          title: 'Created',
                          value:
                              (user.created?.toLocal().fullReadable).optional(),
                        ),
                      ],
                    ),

                    ///
                    /// Actions
                    ///
                    DynamicGroup(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                      header: 'Actions',
                      items: [
                        DynamicGroupItem.action(
                          onTap: () => tap(user),
                          leading: Icon(MIcons.fileEditOutline),
                          title: 'Edit Details',
                          trailing: Icon(MIcons.chevronRight),
                        ),
                        DynamicGroupItem.action(
                          titleColor: Theme.of(context).colorScheme.error,
                          onTap: () => onDelete(user),
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
  required String userId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(userId);
    return null;
  }).toTaskEither<Failure>();
}

TaskResult<void> _handleSuccessfulVerifyTaskSidEffects({
  required BuildContext context,
  required String userId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Verification Email Sent');
    refresh(userId);
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
