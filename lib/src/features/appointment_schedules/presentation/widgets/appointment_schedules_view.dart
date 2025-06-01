import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/modals/dropdown_confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/widgets/appointment_schedule_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentSchedulesView extends HookConsumerWidget {
  const AppointmentSchedulesView({super.key, this.patientId});

  final String? patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.appointmentScheduleToday;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = appointmentScheduleTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(listProvider);
    }

    ///
    /// onTap
    ///
    onTap(AppointmentSchedule appointmentSchedule) {
      AppointmentSchedulePageRoute(appointmentSchedule.id).push(context);
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

    onEdit(AppointmentSchedule appointmentSchedule) {
      AppointmentScheduleFormPageRoute(
              id: appointmentSchedule.id, patientId: patientId)
          .push(context);
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
          notifier.clearSelection();
          ref.invalidate(appointmentScheduleTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      AppointmentScheduleFormPageRoute(
        patientId: patientId,
      ).push(context);
    }

    return SliverDynamicTableView<AppointmentSchedule>(
      showSearch: false,
      tableKey: tableKey,
      error: FailureMessage.asyncValue(listState),
      isLoading: listState.isLoading,
      items: listState.valueOrNull ?? [],
      onDelete: onDelete,
      onRowTap: onTap,

      ///
      /// Search Features
      ///
      searchCtrl: searchCtrl,
      onCreate: onCreate,

      ///
      /// Table Data
      ///
      columns: [
        DynamicTableColumn(
          header: 'Patient',
          width: 200,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                (data.expand.patient?.name).optional(),
              ),
            );
          },
        ),
        DynamicTableColumn(
          header: 'Purpose',
          width: 200,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                data.notes.optional(),
              ),
            );
          },
        ),
        DynamicTableColumn(
          header: 'Record',
          width: 200,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                (data.expand.patientRecord?.visitDate.fullDateTime).optional(),
              ),
            );
          },
        ),
        DynamicTableColumn(
          header: 'Status',
          width: 150,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                data.status.name.optional(),
              ),
            );
          },
        ),
        DynamicTableColumn(
          header: 'Actions',
          alignment: Alignment.center,
          width: 150,
          builder: (context, product, row, column) {
            return Align(
              alignment: Alignment.center,
              child: PopoverWidget.icon(
                icon: Icon(MIcons.dotsHorizontal),
                bottomSheetHeader: const Text('Action'),
                items: [
                  PopoverMenuItemData(
                    name: 'Change Status',
                    onTap: () {
                      onChangeStatus(product);
                    },
                  ),
                  PopoverMenuItemData(
                    name: 'View',
                    onTap: () {
                      onTap(product);
                    },
                  ),
                  PopoverMenuItemData(
                    name: 'Edit',
                    onTap: () {
                      onEdit(product);
                    },
                  ),
                  PopoverMenuItemData(
                    name: 'Delete',
                    onTap: () {
                      onDelete([product]);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],

      ///
      /// Builder for mobile
      ///
      mobileBuilder: (context, index, appointmentSchedule, selected) {
        return AppointmentScheduleCard(
          appointmentSchedule: appointmentSchedule,
          onChangeStatus: () => onChangeStatus(appointmentSchedule),
          onEdit: () => onEdit(appointmentSchedule),
          onDelete: () => onDelete([appointmentSchedule]),
          onTap: () {
            if (selected)
              notifier.toggleRow(index);
            else
              onTap(appointmentSchedule);
          },
          selected: selected,
          onLongPress: () {
            notifier.toggleRow(index);
          },
        );
      },
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
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Success');
    refresh(id);
    return null;
  }).toTaskEither<Failure>();
}
