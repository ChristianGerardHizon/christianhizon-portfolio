import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScheduleCalendarPage extends HookConsumerWidget {
  const AppointmentScheduleCalendarPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();

    final focusedDay = useState(now);

    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          eventLoader: (day) {
            return [];
          },
          
          onDaySelected: (selectedDay, _f) {
            focusedDay.value = selectedDay;
          },
        
          shouldFillViewport: true,
          focusedDay: focusedDay.value,
          currentDay: now,
          firstDay: now.subtract(Duration(days: 10000)),
          lastDay: now.add(Duration(days: 10000)),
        ),
      ),
    );
  }
}
