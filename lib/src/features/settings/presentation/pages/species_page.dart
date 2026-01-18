import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../patients/domain/patient_species.dart';
import '../controllers/species_controller.dart';
import '../widgets/sheets/species_form_sheet.dart';

/// Species list page with CRUD operations.
class SpeciesPage extends ConsumerWidget {
  const SpeciesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final speciesAsync = ref.watch(speciesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Species'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormSheet(context),
        child: const Icon(Icons.add),
      ),
      body: speciesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(speciesControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (speciesList) {
          if (speciesList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No species yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a species',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(speciesControllerProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: speciesList.length,
              itemBuilder: (context, index) {
                final species = speciesList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.pets_outlined,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(species.name),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) =>
                        _handleAction(context, ref, value, species),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Edit'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete_outlined),
                          title: Text('Delete'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => _showFormSheet(context, species: species),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showFormSheet(BuildContext context, {PatientSpecies? species}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SpeciesFormSheet(species: species),
    );
  }

  void _handleAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    PatientSpecies species,
  ) {
    switch (action) {
      case 'edit':
        _showFormSheet(context, species: species);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref, species);
        break;
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    PatientSpecies species,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Species'),
        content: Text('Are you sure you want to delete "${species.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(speciesControllerProvider.notifier)
                  .deleteSpecies(species.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
