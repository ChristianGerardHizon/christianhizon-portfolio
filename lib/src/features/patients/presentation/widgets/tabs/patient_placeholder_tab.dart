import 'package:flutter/material.dart';

/// Placeholder tab for unimplemented tab content.
class PatientPlaceholderTab extends StatelessWidget {
  const PatientPlaceholderTab({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            '$title Tab',
            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 8),
          Text(
            'Content coming soon',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
