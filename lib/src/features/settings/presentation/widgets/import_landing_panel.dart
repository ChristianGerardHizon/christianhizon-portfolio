import 'package:flutter/material.dart';

import 'dialogs/csv_import_dialog.dart';

/// Landing panel for the Import section in System Settings.
///
/// Displays a description and a button to launch the CSV import wizard.
class ImportLandingPanel extends StatelessWidget {
  const ImportLandingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.file_upload_outlined,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Import Products',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Import products and categories from a CSV file. '
                'New categories will be created automatically.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Supported format: CSV files with columns for '
                'Name, Category, Price, and stock information.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => showCsvImportDialog(context),
                icon: const Icon(Icons.upload_file),
                label: const Text('Import from CSV'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
