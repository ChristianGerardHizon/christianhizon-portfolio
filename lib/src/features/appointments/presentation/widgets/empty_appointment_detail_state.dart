import 'package:flutter/material.dart';

/// Empty state shown when no appointment is selected in tablet layout.
class EmptyAppointmentDetailState extends StatelessWidget {
  const EmptyAppointmentDetailState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Select an appointment',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose an appointment from the list to view details',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
