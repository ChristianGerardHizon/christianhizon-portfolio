import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/routing/routes/system.routes.dart';
import '../../../patients/domain/patient_species.dart';
import '../controllers/species_controller.dart';

/// List panel for species in tablet two-pane layout.
class SpeciesListPanel extends HookConsumerWidget {
  const SpeciesListPanel({
    super.key,
    this.selectedId,
  });

  /// Currently selected species ID for highlighting.
  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final speciesAsync = ref.watch(speciesControllerProvider);
    final controller = ref.read(speciesControllerProvider.notifier);

    // Search state
    final searchController = useTextEditingController();
    final searchText = useState('');
    final appliedQuery = useState('');

    final isSearchActive = appliedQuery.value.isNotEmpty;

    void performSearch() {
      final query = searchController.text.trim();
      if (query.isEmpty) return;
      appliedQuery.value = query;
    }

    void clearSearch() {
      searchController.clear();
      searchText.value = '';
      appliedQuery.value = '';
    }

    return Scaffold(
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
          final filteredList = isSearchActive
              ? _filterSpecies(speciesList, appliedQuery.value)
              : speciesList;
          final totalCount = filteredList.length;

          return Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                color: theme.colorScheme.surfaceContainerHighest,
                child: Row(
                  children: [
                    Text('Species', style: theme.textTheme.titleLarge),
                    const Spacer(),
                    Text(
                      '$totalCount total',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              // Search
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isSearchActive
                    ? _ActiveSearchChip(
                        query: appliedQuery.value,
                        onClear: clearSearch,
                      )
                    : _SearchInput(
                        controller: searchController,
                        onSearch: performSearch,
                        onTextChanged: (text) => searchText.value = text,
                        searchText: searchText.value,
                        hintText: '${t.common.search}...',
                      ),
              ),

              // List
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.refresh(),
                  child: filteredList.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            const SizedBox(height: 80),
                            Icon(
                              Icons.pets_outlined,
                              size: 80,
                              color: theme.colorScheme.outlineVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isSearchActive
                                  ? 'No species match "${appliedQuery.value}"'
                                  : 'No species yet',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isSearchActive
                                  ? 'Try a different search term'
                                  : 'Tap + to add a species',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final species = filteredList[index];
                            final isSelected = species.id == selectedId;

                            return _SpeciesListTile(
                              species: species,
                              isSelected: isSelected,
                              onTap: () =>
                                  SpeciesDetailRoute(id: species.id).go(context),
                            );
                          },
                        ),
                ),
              ),
            ],
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

class _ActiveSearchChip extends StatelessWidget {
  const _ActiveSearchChip({
    required this.query,
    required this.onClear,
  });

  final String query;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"$query"',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: onClear,
                  borderRadius: BorderRadius.circular(12),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({
    required this.controller,
    required this.onSearch,
    required this.onTextChanged,
    required this.searchText,
    required this.hintText,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;
  final ValueChanged<String> onTextChanged;
  final String searchText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onTextChanged,
            onSubmitted: (_) => onSearch(),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        onTextChanged('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}

List<PatientSpecies> _filterSpecies(List<PatientSpecies> species, String query) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) {
    return species;
  }

  return species.where((s) {
    return s.name.toLowerCase().contains(normalizedQuery);
  }).toList();
}
