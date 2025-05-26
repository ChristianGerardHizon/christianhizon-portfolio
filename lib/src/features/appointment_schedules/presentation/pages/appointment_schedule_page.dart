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
import 'package:sannjosevet/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/controllers/appointment_schedule_controller.dart';
import 'package:sannjosevet/src/features/patients/presentation/widgets/patient_tile.dart';
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
        title: const Text('Appointment Schedule Details'),
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
                          header: 'Appointment Details',
                          items: [
                            DynamicGroupItem.text(
                              title: 'Purpose',
                              value: appointmentSchedule.purpose.optional(),
                            ),
                            DynamicGroupItem.text(
                              title: 'Status',
                              value: appointmentSchedule.status.name,
                            ),
                            DynamicGroupItem.text(
                              title: 'Notes',
                              value: appointmentSchedule.notes.optional(),
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

                        if (appointmentSchedule.patientName != null)
                          DynamicGroup(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 12),
                            header: 'Patient and Owner Details',
                            items: [
                              if (appointmentSchedule.patientName != null)
                                DynamicGroupItem.text(
                                  title: 'Patient Name',
                                  value: appointmentSchedule.patientName
                                      .optional(),
                                ),
                              DynamicGroupItem.text(
                                title: 'Owner Name',
                                value: appointmentSchedule.ownerName.optional(),
                              ),
                              DynamicGroupItem.text(
                                title: 'Owner Contact',
                                value:
                                    appointmentSchedule.ownerContact.optional(),
                              ),
                            ],
                          ),

                        if (appointmentSchedule.expand.patient != null)
                          DynamicGroup(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 12),
                            header: 'Patient Details',
                            items: [
                              /// registered patient
                              if (appointmentSchedule.expand.patient != null)
                                DynamicGroupItem.widget(
                                  value: PatientTile(
                                    patient:
                                        appointmentSchedule.expand.patient!,
                                  ),
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
    refresh(appointmentScheduleId);
    if (context.canPop()) context.pop();
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
