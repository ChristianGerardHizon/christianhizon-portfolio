import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';

class AppointmentScheduleTile extends StatelessWidget {
  const AppointmentScheduleTile({
    super.key,
    required this.appointmentSchedule,
    required this.onLongPress,
    required this.onTap,
    required this.onDelete,
    required this.onChangeStatus,
    required this.onEdit,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final Function() onDelete;
  final Function() onChangeStatus;
  final Function() onEdit;
  final bool selected;
  final AppointmentSchedule appointmentSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(MIcons.calendarOutline),
          title: Text(
            (appointmentSchedule.date.fullDateTime).optional(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: PopoverWidget.icon(
            icon: Icon(MIcons.dotsHorizontal),
            bottomSheetHeader: const Text('Action'),
            items: [
              PopoverMenuItemData(
                name: 'Change Status',
                onTap: onChangeStatus,
              ),
              PopoverMenuItemData(
                name: 'View',
                onTap: onTap,
              ),
              PopoverMenuItemData(
                name: 'Edit',
                onTap: onEdit,
              ),
              PopoverMenuItemData(
                name: 'Delete',
                onTap: onDelete,
              ),
            ],
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: 'Purpose: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: appointmentSchedule.purpose.optional(),
                      ),
                    ],
                  ),
                ),
                RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: 'Status: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: appointmentSchedule.status.name.optional(),
                      ),
                    ],
                  ),
                ),
                RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: 'Notes: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: appointmentSchedule.notes.optional(),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
