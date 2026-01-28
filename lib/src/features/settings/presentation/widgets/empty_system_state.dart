import 'package:flutter/material.dart';

import 'system_nav_panel.dart';

/// Empty state shown when no item is selected in tablet layout.
class EmptySystemState extends StatelessWidget {
  const EmptySystemState({
    super.key,
    required this.mode,
  });

  /// Current system mode to determine the message.
  final SystemMode mode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (icon, title, subtitle) = switch (mode) {
      SystemMode.speciesBreeds => (
          Icons.pets_outlined,
          'Select a species',
          'Choose a species from the list to view breeds and details',
        ),
      SystemMode.productCategories => (
          Icons.inventory_2_outlined,
          'Select a category',
          'Choose a category from the list to view details',
        ),
      SystemMode.messageTemplates => (
          Icons.chat_bubble_outline,
          'Select a template',
          'Choose a template from the list to view and edit',
        ),
      SystemMode.treatmentTypes => (
          Icons.medical_services_outlined,
          'Select a treatment type',
          'Choose a treatment type from the list to view and edit',
        ),
      SystemMode.printers => (
          Icons.print_outlined,
          'Select a printer',
          'Choose a printer from the list to view and configure',
        ),
      SystemMode.appearance => (
          Icons.palette_outlined,
          'Appearance',
          'Customize app theme and colors',
        ),
    };

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
