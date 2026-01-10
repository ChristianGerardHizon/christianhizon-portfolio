import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/modals/dropdown_confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/appointments/schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointments/schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/controllers/appointment_schedules_controller.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/widgets/appointment_schedule_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentScheduleGroup extends HookConsumerWidget {
  const AppointmentScheduleGroup({
    super.key,
    required this.patientId,
    required this.patientRecordId,
  });

  final String patientId;
  final String patientRecordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// state
    ///
    final provider = appointmentSchedulesControllerProvider(
      patientId: patientId,
      patientRecordId: patientRecordId,
    );
    final state = ref.watch(provider);

    ///
    /// refresh
    ///
    refresh() {
      ref.invalidate(provider);
    }

    ///
    /// onAdd
    ///
    void onAdd(String patientId, String patientRecordId) async {
      final result = await AppointmentScheduleFormPageRoute(
        patientId: patientId,
        patientRecordId: patientRecordId,
      ).push(context);
      if (result is AppointmentSchedule) {
        refresh();
      }
    }

    ///
    /// onEdit
    ///
    void onEdit(AppointmentSchedule appointmentSchedule) async {
      final result = await AppointmentScheduleFormPageRoute(
              id: appointmentSchedule.id, patientId: patientId)
          .push(context);
      if (result is AppointmentSchedule) {
        refresh();
      }
    }

    ///
    /// onDelete
    ///
    onDelete(List<AppointmentSchedule> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(appointmentScheduleRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          ref.invalidate(appointmentScheduleTableControllerProvider);
          refresh();
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    onChangeStatus(AppointmentSchedule appointmentSchedule) async {
      final repo = ref.read(appointmentScheduleRepositoryProvider);
      final task =
          DropdownConfirmModal.showTaskResult<AppointmentScheduleStatus>(
                  context,
                  title: 'Select New Status',
                  initialValue: appointmentSchedule.status,
                  options: AppointmentScheduleStatus.values.map((e) {
                    return DropdownConfirmOption(
                      label: e.name,
                      value: e,
                    );
                  }).toList())
              .map((status) => {AppointmentScheduleField.status: status.name})
              .flatMap((value) => repo.update(appointmentSchedule, value))
              .flatMap((r) => _handleSuccessfulUpdateTaskSidEffects(
                    context: context,
                    id: appointmentSchedule.id,
                    refresh: refresh,
                  ));

      /// start
      isLoading.value = true;
      final result = await task.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    return StackLoader(
      isLoading: isLoading.value,
      child: DynamicGroup(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        header: 'Follow Up Appointment',
        headerAction: TextButton.icon(
          onPressed: () => onAdd(patientId, patientRecordId),
          icon: Icon(MIcons.plus),
          label: const Text('Add'),
        ),
        items: state.maybeWhen(
          skipError: false,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: false,
          data: (data) {
            if (data.isEmpty)
              return [
                DynamicGroupItem.widget(
                  value: const Center(
                    heightFactor: 5,
                    child: Text('No appointments found'),
                  ),
                )
              ];
            return data
                .map((e) => DynamicGroupItem.widget(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      value: AppointmentScheduleTile(
                        appointmentSchedule: e,
                        onLongPress: () {},
                        onTap: () {
                          AppointmentSchedulePageRoute(e.id).push(context);
                        },
                        onDelete: () => onDelete([e]),
                        onChangeStatus: () => onChangeStatus(e),
                        onEdit: () => onEdit(e),
                      ),
                    ))
                .toList();
          },
          orElse: () => [],
        ),
      ),
    );
  }
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulUpdateTaskSidEffects({
  required BuildContext context,
  required String id,
  required void Function() refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Success');
    refresh();
    return null;
  }).toTaskEither<Failure>();
}
