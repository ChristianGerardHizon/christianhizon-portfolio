import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_simple.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/popover_widget.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentScheduleTodayView extends HookConsumerWidget {
  const AppointmentScheduleTodayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(DateTime.now());

    final tableKey = TableControllerKeys.appointmentScheduleToday;
    final listProvider = appointmentScheduleTableControllerProvider(
      tableKey,
      date: selectedDate.value,
    );
    final listState = ref.watch(listProvider);

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
            onPressed: () {
              ref.invalidate(listProvider);
            },
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
                if (listState.valueOrNull?.isEmpty ?? false) {
                  return const Center(
                    child: Text('No appointments found'),
                  );
                }

                // content
                return DynamicTableSimple<AppointmentSchedule>(
                  tableKey: tableKey,
                  error: FailureMessage.asyncValue(listState),
                  items: listState.valueOrNull ?? [],
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
                      header: 'Name',
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
                      header: 'Actions',
                      width: 200,
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
                                  // onChangeStatus(product);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                  mobileBuilder: (context, index, data, isSelected) {
                    return ListTile(title: Text(data.displayDate));
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
