import 'package:flutter/material.dart';

/// Empty state shown when no patient is selected in tablet layout.
class EmptyDetailState extends StatelessWidget {
  const EmptyDetailState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets, size: 80, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              'Select a patient',
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a patient from the list to view details',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
