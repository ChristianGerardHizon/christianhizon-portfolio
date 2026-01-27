import 'package:flutter/material.dart';

/// Empty state shown when no message is selected in tablet layout.
class EmptyMessageDetailState extends StatelessWidget {
  const EmptyMessageDetailState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message_outlined, size: 80, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              'Select a message',
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a message from the list to view details',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
