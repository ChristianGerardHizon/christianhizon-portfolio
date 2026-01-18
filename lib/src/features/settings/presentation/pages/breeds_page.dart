import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../patients/domain/patient_breed.dart';
import '../../../patients/presentation/controllers/species_breeds_provider.dart';
import '../controllers/breeds_controller.dart';
import '../widgets/sheets/breed_form_sheet.dart';

/// Breeds list page with CRUD operations and species filtering.
class BreedsPage extends HookConsumerWidget {
  const BreedsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final breedsAsync = ref.watch(breedsControllerProvider);
    final speciesAsync = ref.watch(speciesProvider);

    // Filter state
    final selectedSpeciesId = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breeds'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormSheet(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Species filter dropdown
          Padding(
            padding: const EdgeInsets.all(16),
            child: speciesAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
              data: (speciesList) => InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Filter by Species',
                  prefixIcon: Icon(Icons.filter_list),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    value: selectedSpeciesId.value,
                    isExpanded: true,
                    isDense: true,
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Species'),
                      ),
                      ...speciesList.map((s) => DropdownMenuItem(
                            value: s.id,
                            child: Text(s.name),
                          )),
                    ],
                    onChanged: (value) => selectedSpeciesId.value = value,
                  ),
                ),
              ),
            ),
          ),

          // Breeds list
          Expanded(
            child: breedsAsync.when(
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
                          ref.read(breedsControllerProvider.notifier).refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (breedsList) {
                // Filter by selected species
                final filteredBreeds = selectedSpeciesId.value != null
                    ? breedsList
                        .where((b) => b.speciesId == selectedSpeciesId.value)
                        .toList()
                    : breedsList;

                if (filteredBreeds.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 64,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          selectedSpeciesId.value != null
                              ? 'No breeds for selected species'
                              : 'No breeds yet',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap + to add a breed',
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
                      ref.read(breedsControllerProvider.notifier).refresh(),
                  child: ListView.builder(
                    itemCount: filteredBreeds.length,
                    itemBuilder: (context, index) {
                      final breed = filteredBreeds[index];

                      // Get species name
                      final speciesName = speciesAsync.maybeWhen(
                        data: (list) => list
                            .where((s) => s.id == breed.speciesId)
                            .map((s) => s.name)
                            .firstOrNull,
                        orElse: () => null,
                      );

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.category_outlined,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        title: Text(breed.name),
                        subtitle:
                            speciesName != null ? Text(speciesName) : null,
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) =>
                              _handleAction(context, ref, value, breed),
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
                        onTap: () => _showFormSheet(context, breed: breed),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFormSheet(BuildContext context, {PatientBreed? breed}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => BreedFormSheet(breed: breed),
    );
  }

  void _handleAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    PatientBreed breed,
  ) {
    switch (action) {
      case 'edit':
        _showFormSheet(context, breed: breed);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref, breed);
        break;
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    PatientBreed breed,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Breed'),
        content: Text('Are you sure you want to delete "${breed.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(breedsControllerProvider.notifier)
                  .deleteBreed(breed.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
