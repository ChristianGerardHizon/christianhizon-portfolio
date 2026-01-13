import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../domain/patient.dart';
import '../controllers/patient_search_controller.dart';
import '../controllers/patients_controller.dart';
import 'sheets/search_fields_sheet.dart';

/// Patient list panel with search header.
///
/// Used in both mobile list page and tablet two-pane layout.
class PatientListPanel extends HookConsumerWidget {
  const PatientListPanel({
    super.key,
    required this.patients,
    required this.selectedId,
    required this.onPatientTap,
    this.onRefresh,
  });

  final List<Patient> patients;
  final String? selectedId;
  final ValueChanged<Patient> onPatientTap;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Local state using hooks
    final searchController = useTextEditingController();
    final searchText = useState('');
    final activeQuery = useState<String?>(null);

    // Watch providers
    final searchFields = ref.watch(patientSearchFieldsProvider);
    final activeFieldCount = searchFields.length;

    // Search is active if we have a query
    final isSearchActive = activeQuery.value != null;

    void performSearch() {
      final query = searchController.text.trim();
      if (query.isEmpty) return;

      final fields = ref.read(patientSearchFieldsProvider).toList();
      ref
          .read(patientsControllerProvider.notifier)
          .search(query, fields: fields);

      activeQuery.value = query;
    }

    void clearSearch() {
      searchController.clear();
      searchText.value = '';
      activeQuery.value = null;
      ref.read(patientSearchFieldsProvider.notifier).reset();
      ref.read(patientsControllerProvider.notifier).refresh();
    }

    void editSearch() {
      searchController.text = activeQuery.value ?? '';
      searchText.value = activeQuery.value ?? '';
      activeQuery.value = null;
    }

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Text(t.navigation.patients, style: theme.textTheme.titleLarge),
                const Spacer(),
                Text(
                  '${patients.length} total',
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
                    query: activeQuery.value!,
                    fieldCount: activeFieldCount,
                    onClear: clearSearch,
                    onEdit: editSearch,
                  )
                : _SearchInput(
                    controller: searchController,
                    fieldCount: activeFieldCount,
                    onSearch: performSearch,
                    onTextChanged: (text) => searchText.value = text,
                    searchText: searchText.value,
                  ),
          ),

          // Patient list
          Expanded(
            child: RefreshIndicator(
              onRefresh: onRefresh ?? () async {},
              notificationPredicate:
                  onRefresh != null ? (_) => true : (_) => false,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  final isSelected = patient.id == selectedId;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: patient.species == 'Dog'
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.tertiaryContainer,
                      child: Icon(
                        patient.species == 'Dog'
                            ? Icons.pets
                            : Icons.catching_pokemon,
                        color: patient.species == 'Dog'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.tertiary,
                      ),
                    ),
                    title: Text(
                      patient.name,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text('${patient.species} - ${patient.breed}'),
                    selected: isSelected,
                    selectedTileColor: theme.colorScheme.primaryContainer,
                    trailing:
                        isSelected ? const Icon(Icons.chevron_right) : null,
                    onTap: () => onPatientTap(patient),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveSearchChip extends StatelessWidget {
  const _ActiveSearchChip({
    required this.query,
    required this.fieldCount,
    required this.onClear,
    required this.onEdit,
  });

  final String query;
  final int fieldCount;
  final VoidCallback onClear;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

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
                if (fieldCount > 1) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$fieldCount fields',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
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
        const SizedBox(width: 8),
        IconButton.filledTonal(
          icon: const Icon(Icons.edit),
          onPressed: onEdit,
          tooltip: t.common.edit,
        ),
      ],
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({
    required this.controller,
    required this.fieldCount,
    required this.onSearch,
    required this.onTextChanged,
    required this.searchText,
  });

  final TextEditingController controller;
  final int fieldCount;
  final VoidCallback onSearch;
  final ValueChanged<String> onTextChanged;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onTextChanged,
            onSubmitted: (_) => onSearch(),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '${t.common.search}...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        onTextChanged('');
                      },
                      tooltip: t.common.cancel,
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
        const SizedBox(width: 8),
        Badge(
          isLabelVisible: fieldCount > 1,
          label: Text('$fieldCount'),
          child: IconButton.filledTonal(
            icon: const Icon(Icons.tune),
            onPressed: () => showSearchFieldsSheet(context),
            tooltip: t.common.filter,
          ),
        ),
        const SizedBox(width: 4),
        IconButton.filled(
          icon: const Icon(Icons.search),
          onPressed: onSearch,
          tooltip: t.common.search,
        ),
      ],
    );
  }
}
