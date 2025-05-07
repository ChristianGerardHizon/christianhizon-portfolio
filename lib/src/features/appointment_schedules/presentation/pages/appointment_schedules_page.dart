import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/widgets/appointment_schedule_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentSchedulesPage extends HookConsumerWidget {
  const AppointmentSchedulesPage(
      {super.key, this.patientId, this.showAppBar = true});

  final String? patientId;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = patientId is String
        ? TableControllerKeys.appointmentSchedulePatient(patientId!)
        : TableControllerKeys.appointmentSchedule;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = appointmentScheduleTableControllerProvider(tableKey,
        patientId: patientId);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(AppointmentSchedule appointmentSchedule) {
      AppointmentSchedulePageRoute(appointmentSchedule.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(appointmentScheduleTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
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
          if (context.canPop()) context.pop();
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      AppointmentScheduleFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text('AppointmentSchedules'),
              actions: [
                RefreshButton(
                  onPressed: onRefresh,
                ),
              ],
            )
          : null,
      body: DynamicTableView<AppointmentSchedule>(
        tableKey: TableControllerKeys.appointmentSchedule,
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
          TableColumn(
            header: 'Date and Time',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.date.fullDateTime,
                ),
              );
            },
          ),
          TableColumn(
            header: 'Purpose',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.purpose.optional(),
                ),
              );
            },
          ),
          TableColumn(
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
          TableColumn(
            header: 'Status',
            width: 200,
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
          TableColumn(
            header: 'Actions',
            alignment: Alignment.centerLeft,
            width: 150,
            builder: (context, product, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child:
                    TextButton(onPressed: () {}, child: Text('Adjust Status')),
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
      ),
    );
  }
}
