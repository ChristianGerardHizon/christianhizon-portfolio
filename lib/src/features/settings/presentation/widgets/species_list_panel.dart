import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../../patients/domain/patient_species.dart';
import '../controllers/species_controller.dart';

/// List panel for species in tablet two-pane layout.
class SpeciesListPanel extends ConsumerWidget {
  const SpeciesListPanel({
    super.key,
    this.selectedId,
  });

  /// Currently selected species ID for highlighting.
  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final speciesAsync = ref.watch(speciesControllerProvider);
    final controller = ref.read(speciesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Species'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'species_fab',
        onPressed: () => const SpeciesDetailRoute(id: 'new').go(context),
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
                onPressed: () => controller.refresh(),
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
            onRefresh: () => controller.refresh(),
            child: ListView.builder(
              itemCount: speciesList.length,
              itemBuilder: (context, index) {
                final species = speciesList[index];
                final isSelected = species.id == selectedId;

                return _SpeciesListTile(
                  species: species,
                  isSelected: isSelected,
                  onTap: () => SpeciesDetailRoute(id: species.id).go(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SpeciesListTile extends StatelessWidget {
  const _SpeciesListTile({
    required this.species,
    required this.isSelected,
    required this.onTap,
  });

  final PatientSpecies species;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primaryContainer.withValues(
        alpha: 0.3,
      ),
      leading: CircleAvatar(
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.primaryContainer,
        child: Icon(
          Icons.pets_outlined,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(species.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
