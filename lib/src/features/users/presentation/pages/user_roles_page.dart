import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/routing/routes/users.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../domain/user_role.dart';
import '../controllers/user_roles_controller.dart';
import '../widgets/sheets/create_role_sheet.dart';
import '../widgets/sheets/edit_role_sheet.dart';

/// User roles management page.
///
/// Shows a list of all roles with their permissions count and allows CRUD operations.
class UserRolesPage extends ConsumerWidget {
  const UserRolesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(userRolesControllerProvider);
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isTablet = Breakpoints.isTabletOrLarger(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isTablet,
        leading: isTablet
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => const UsersRoute().go(context),
              ),
        title: const Text('User Roles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(userRolesControllerProvider.notifier).refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateRoleSheet(context),
        tooltip: 'Add Role',
        child: const Icon(Icons.add),
      ),
      body: rolesAsync.when(
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
                    ref.read(userRolesControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (roles) {
          if (roles.isEmpty) {
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
                    'No roles found',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a role to get started',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: roles.length,
            itemBuilder: (context, index) {
              final role = roles[index];
              return _RoleListTile(
                role: role,
                onEdit: () => showEditRoleSheet(context, role),
                onDelete: () => _showDeleteConfirmation(context, ref, role),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, UserRole role) {
    final t = Translations.of(context);

    if (role.isSystem) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('System roles cannot be deleted')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.common.delete),
        content: Text('Are you sure you want to delete the "${role.name}" role?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(userRolesControllerProvider.notifier)
                  .deleteRole(role.id);
              if (context.mounted) {
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Role deleted')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete role')),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
  }
}

class _RoleListTile extends StatelessWidget {
  const _RoleListTile({
    required this.role,
    required this.onEdit,
    required this.onDelete,
  });

  final UserRole role;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final permissionCount = role.permissions.length;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: role.isAdmin
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.secondaryContainer,
          child: Icon(
            role.isAdmin ? Icons.admin_panel_settings : Icons.person,
            color: role.isAdmin
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSecondaryContainer,
          ),
        ),
        title: Row(
          children: [
            Text(role.name),
            if (role.isSystem) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
        subtitle: Text(
          role.description ?? '$permissionCount permission${permissionCount == 1 ? '' : 's'}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            if (!role.isSystem)
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: theme.colorScheme.error),
                    const SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: theme.colorScheme.error)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
