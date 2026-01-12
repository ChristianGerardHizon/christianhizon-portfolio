import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../domain/patient.dart';

/// Patient list panel with search header.
///
/// Used in both mobile list page and tablet two-pane layout.
class PatientListPanel extends StatelessWidget {
  const PatientListPanel({
    super.key,
    required this.patients,
    required this.selectedId,
    required this.onPatientTap,
  });

  final List<Patient> patients;
  final String? selectedId;
  final ValueChanged<Patient> onPatientTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

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
            child: TextField(
              decoration: InputDecoration(
                hintText: '${t.common.search}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
                filled: true,
              ),
            ),
          ),

          // Patient list
          Expanded(
            child: ListView.builder(
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
                  trailing: isSelected ? const Icon(Icons.chevron_right) : null,
                  onTap: () => onPatientTap(patient),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
