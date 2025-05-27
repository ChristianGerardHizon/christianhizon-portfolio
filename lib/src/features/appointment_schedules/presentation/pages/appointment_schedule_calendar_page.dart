import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScheduleCalendarPage extends HookConsumerWidget {
  const AppointmentScheduleCalendarPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();

    final calendarFocusedDay = useState(now);
    final calendarFormat = useState(CalendarFormat.month);

    final selectedColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TableCalendar(
                eventLoader: (day) {
                  return ['test'];
                },
                onDaySelected: (selectedDay, _f) {
                  calendarFocusedDay.value = _f;
                },
                rowHeight: 60,
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, day, focusedDay) {
                    return FlutterLogo();
                  },
                  markerBuilder: (context, day, events) {
                    return SizedBox();
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CircleAvatar(
                        backgroundColor:
                            calendarFocusedDay.value.isAtSameMomentAs(day)
                                ? Colors.amber
                                : Colors.transparent,
                        child: Text(day.day.toString()),
                      ),
                    );
                  },

                  defaultBuilder: (context, day, focusedDay) {
                    if (calendarFocusedDay.value.isAtSameMomentAs(day)) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Text(day.day.toString()),
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text(day.day.toString()),
                      );
                    }
                  },

                  // markerBuilder: (context, day, events) {
                  //   return AppointmentCalendarTile();
                  // },
                ),
                onFormatChanged: (format) => calendarFormat.value = format,
                focusedDay: calendarFocusedDay.value.add(Duration(days: 2)),
                calendarFormat: calendarFormat.value,
                currentDay: now,
                firstDay: now.subtract(Duration(days: 10000)),
                lastDay: now.add(Duration(days: 10000)),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),

            ///
            /// Place Appointments Here
            ///
            SliverList.list(
              children: [
                Text(
                    'Appointments Here ${calendarFocusedDay.value.toIso8601String()}'),
              ],
            ),

            ///
            /// List of Appointments based on the selected
            ///
          ],
        ),
      ),
    );
  }
}
