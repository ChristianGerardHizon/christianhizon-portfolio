import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/user.dart';
import '../../../domain/user_role.dart';
import '../../controllers/user_role_provider.dart';

/// Permissions tab showing user's role and associated permissions.
class UserPermissionsTab extends ConsumerWidget {
  const UserPermissionsTab({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // If user has no role, show empty state
    if (user.roleId == null) {
      return _buildNoRoleState(context, theme);
    }

    // Fetch the role details
    final roleAsync = ref.watch(userRoleProvider(user.roleId!));

    return roleAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Error loading role: ${error.toString()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(userRoleProvider(user.roleId!)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (role) {
        if (role == null) {
          return _buildNoRoleState(context, theme);
        }
        return _buildRoleContent(context, theme, role);
      },
    );
  }

  Widget _buildNoRoleState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.admin_panel_settings_outlined,
            size: 80,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No Role Assigned',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This user has not been assigned a role yet',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleContent(BuildContext context, ThemeData theme, UserRole role) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Role info card
          _buildRoleCard(context, theme, role),
          const SizedBox(height: 24),

          // Permissions by category
          _buildPermissionsSection(context, theme, role),
        ],
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, ThemeData theme, UserRole role) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: role.isAdmin
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.secondaryContainer,
              child: Icon(
                role.isAdmin ? Icons.admin_panel_settings : Icons.person,
                size: 32,
                color: role.isAdmin
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        role.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (role.isSystem) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'System',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (role.description != null &&
                      role.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      role.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${role.permissions.length} permission${role.permissions.length == 1 ? '' : 's'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsSection(
    BuildContext context,
    ThemeData theme,
    UserRole role,
  ) {
    if (role.permissions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.lock_outlined,
                  size: 48,
                  color: theme.colorScheme.outlineVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  'No permissions assigned',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Group permissions by category
    final groupedPermissions = <String, List<String>>{};
    for (final permission in role.permissions) {
      final parts = permission.split('.');
      final category = parts.isNotEmpty ? parts[0] : 'other';
      groupedPermissions.putIfAbsent(category, () => []).add(permission);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.security,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Permissions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...groupedPermissions.entries.map((entry) {
          return _buildPermissionCategory(
            context,
            theme,
            category: entry.key,
            permissions: entry.value,
          );
        }),
      ],
    );
  }

  Widget _buildPermissionCategory(
    BuildContext context,
    ThemeData theme, {
    required String category,
    required List<String> permissions,
  }) {
    final categoryLabel = _formatCategoryName(category);
    final categoryIcon = _getCategoryIcon(category);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(categoryIcon, color: theme.colorScheme.primary),
        title: Text(
          categoryLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${permissions.length} permission${permissions.length == 1 ? '' : 's'}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        children: permissions.map((permission) {
          final permissionLabel = _formatPermissionName(permission);
          return ListTile(
            leading: Icon(
              Icons.check_circle,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            title: Text(
              permissionLabel,
              style: theme.textTheme.bodyMedium,
            ),
            subtitle: Text(
              permission,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
                fontFamily: 'monospace',
              ),
            ),
            dense: true,
          );
        }).toList(),
      ),
    );
  }

  String _formatCategoryName(String category) {
    return category
        .split('_')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1)
            : word)
        .join(' ');
  }

  String _formatPermissionName(String permission) {
    final parts = permission.split('.');
    if (parts.length < 2) return permission;

    final action = parts.last;
    return action
        .split('_')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1)
            : word)
        .join(' ');
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'system':
        return Icons.settings;
      case 'users':
        return Icons.people;
      case 'patients':
        return Icons.pets;
      case 'appointments':
        return Icons.calendar_today;
      case 'products':
        return Icons.inventory;
      case 'sales':
        return Icons.point_of_sale;
      case 'reports':
        return Icons.analytics;
      case 'messages':
        return Icons.message;
      default:
        return Icons.key;
    }
  }
}
