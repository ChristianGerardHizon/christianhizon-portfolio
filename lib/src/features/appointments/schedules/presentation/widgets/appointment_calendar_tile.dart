import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentCalendarTile extends HookConsumerWidget {
  const AppointmentCalendarTile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Container(
        child: Text('2 Appointments'),
      ),
    );
  }
}
