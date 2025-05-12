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
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/modals/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/controllers/appointment_schedule_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentSchedulePage extends HookConsumerWidget {
  const AppointmentSchedulePage(this.id, {super.key});

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
    final repo = ref.read(appointmentScheduleRepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(appointmentScheduleControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(AppointmentSchedule appointmentSchedule) {
      AppointmentScheduleFormPageRoute(
        id: appointmentSchedule.id,
      ).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(AppointmentSchedule appointmentSchedule) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([appointmentSchedule.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  appointmentScheduleId: appointmentSchedule.id,
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
        title: const Text('AppointmentSchedule Details'),
        actions: [
          RefreshButton(
            onPressed: () => refresh(id),
          )
        ],
      ),
      body: ref.watch(appointmentScheduleControllerProvider(id)).when(
            error: (error, stack) => FailureMessage(error, stack),
            loading: () => Center(child: CircularProgressIndicator()),
            data: (appointmentSchedule) {
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
                          header: 'Appointment Schedule Details',
                          items: [
                            DynamicGroupItem.text(
                              title: 'Purpose',
                              value: appointmentSchedule.purpose.optional(),
                            ),
                            DynamicGroupItem.text(
                              title: 'Satatus',
                              value: appointmentSchedule.status.name,
                            ),
                            DynamicGroupItem.text(
                              title: 'Last Updated',
                              value: (appointmentSchedule.updated
                                      ?.toLocal()
                                      .fullReadable)
                                  .optional(),
                            ),
                            DynamicGroupItem.text(
                              title: 'Created',
                              value: (appointmentSchedule.created
                                      ?.toLocal()
                                      .fullReadable)
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
                              onTap: () => tap(appointmentSchedule),
                              leading: Icon(MIcons.fileEditOutline),
                              title: 'Edit Details',
                              trailing: Icon(MIcons.chevronRight),
                            ),
                            DynamicGroupItem.action(
                              titleColor: Theme.of(context).colorScheme.error,
                              onTap: () => onDelete(appointmentSchedule),
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
  required String appointmentScheduleId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(appointmentScheduleId);
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
