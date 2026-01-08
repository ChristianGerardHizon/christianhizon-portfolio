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
import 'package:sannjosevet/src/core/widgets/center_progress_indicator.dart';
import 'package:sannjosevet/src/core/widgets/circle_widget.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_simple.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/modals/dropdown_confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_circle.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentScheduleByDateView extends HookConsumerWidget {
  const AppointmentScheduleByDateView({super.key, this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(date ?? DateTime.now());

    final tableKey = TableControllerKeys.appointmentScheduleToday;
    final listProvider = appointmentScheduleTableControllerProvider(
      tableKey,
      date: selectedDate.value,
    );
    final listState = ref.watch(listProvider);

    final isLoading = useState(false);

    onShowMore() {
      AppointmentSchedulesByDatePageRoute(date: selectedDate.value)
          .push(context);
    }

    void refresh() {
      ref.invalidate(listProvider);
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

    onRowTap(AppointmentSchedule appointmentSchedule) {
      AppointmentSchedulePageRoute(appointmentSchedule.id).push(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///
        /// Today
        ///
        ListTile(
          title: Text(
            'Today\'s Appointments',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Text(selectedDate.value.yyyyMMdd()),
          trailing: RefreshButton(
            onPressed: refresh,
          ),
        ),

        ///
        /// Content
        ///
        Card(
          child: Container(
            constraints: const BoxConstraints(minHeight: 300),
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (context) {
                // loading
                if (listState.isLoading) {
                  return const CenteredProgressIndicator();
                }

                // empty
                if (listState.value?.isEmpty ?? false) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(MIcons.calendarTodayOutline, size: 45),
                        SizedBox(height: 16),
                        Text('No appointments found'),
                      ],
                    ),
                  );
                }

                // content
                return DynamicTableSimple<AppointmentSchedule>(
                  tableKey: tableKey,
                  error: FailureMessage.asyncValue(listState),
                  items: listState.value ?? [],
                  onRowTap: onRowTap,
                  showMore: true,
                  onShowMore: onShowMore,
                  hidePageController: (listState.value ?? []).length > 5,
                  columns: [
                    DynamicTableColumn(
                      header: 'Date and Time',
                      width: 200,
                      alignment: Alignment.centerLeft,
                      builder: (context, data, row, column) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            data.displayDate,
                          ),
                        );
                      },
                    ),
                    DynamicTableColumn(
                      header: 'Patient',
                      alignment: Alignment.centerLeft,
                      builder: (context, data, row, column) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            (data.patientDisplayName).optional(),
                          ),
                        );
                      },
                    ),
                    DynamicTableColumn(
                      header: 'Owner',
                      alignment: Alignment.centerLeft,
                      builder: (context, data, row, column) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            (data.ownerDisplayName).optional(),
                          ),
                        );
                      },
                    ),
                    DynamicTableColumn(
                      header: 'Status',
                      width: 200,
                      alignment: Alignment.centerLeft,
                      builder: (context, data, row, column) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            data.status.name,
                          ),
                        );
                      },
                    ),
                    DynamicTableColumn(
                      header: 'Actions',
                      width: 80,
                      alignment: Alignment.centerLeft,
                      builder: (context, data, row, column) {
                        return Align(
                          alignment: Alignment.center,
                          child: PopoverWidget.icon(
                            icon: Icon(MIcons.dotsHorizontal),
                            bottomSheetHeader: const Text('Action'),
                            items: [
                              PopoverMenuItemData(
                                name: 'Change Status',
                                onTap: () {
                                  onChangeStatus(data);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                  mobileBuilder: (context, index, data, isSelected) {
                    final patient = data.expand.patient;
                    if (patient == null)
                      return ListTile(
                        leading: CircleWidget(
                          size: Size.square(40),
                          child: Icon(MIcons.dog),
                        ),
                        title: Text(
                          (data.patientName).optional(),
                        ),
                        subtitle: Text(data.displayDate),
                      );
                    return ListTile(
                      leading: CircleWidget(
                        size: Size.square(40),
                        child: PbImageCircle(
                          collection: patient.collectionId,
                          recordId: patient.id,
                          file: patient.avatar,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      title: Text(
                        (patient.name).optional(),
                      ),
                      subtitle: Text(data.displayDate),
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
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
