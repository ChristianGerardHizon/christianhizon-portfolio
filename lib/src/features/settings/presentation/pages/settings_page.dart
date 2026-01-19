import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';

/// Settings hub page with navigation cards to reference data management.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Reference Data',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _SettingsCard(
            icon: Icons.store_outlined,
            title: 'Branches',
            description: 'Manage business locations and branches',
            onTap: () => const BranchesRoute().push(context),
          ),
          _SettingsCard(
            icon: Icons.pets_outlined,
            title: 'Species & Breeds',
            description: 'Manage patient species and their breeds',
            onTap: () => const SpeciesRoute().push(context),
          ),
          _SettingsCard(
            icon: Icons.inventory_2_outlined,
            title: 'Product Categories',
            description: 'Manage product category hierarchy',
            onTap: () => const ProductCategoriesRoute().push(context),
          ),
          _SettingsCard(
            icon: Icons.chat_bubble_outline,
            title: 'Message Templates',
            description: 'Manage SMS message templates with placeholders',
            onTap: () => const MessageTemplatesRoute().push(context),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(title),
        subtitle: Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
