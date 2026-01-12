import 'package:flutter/material.dart';

import '../../../domain/patient.dart';

/// Details tab content showing patient and owner information.
class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: patient.species == 'Dog'
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.tertiaryContainer,
                    child: Icon(
                      patient.species == 'Dog' ? Icons.pets : Icons.catching_pokemon,
                      size: 40,
                      color: patient.species == 'Dog'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(patient.name, style: theme.textTheme.headlineMedium),
                        const SizedBox(height: 4),
                        Text(
                          '${patient.species} - ${patient.breed}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Age: ${patient.age}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Owner section
          Text('Owner Information', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(patient.ownerName),
                  subtitle: const Text('Owner'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(patient.ownerPhone),
                  subtitle: const Text('Phone'),
                  trailing: IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Actions
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Details'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today),
                label: const Text('Book Appointment'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
