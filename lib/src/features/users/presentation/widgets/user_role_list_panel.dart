import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../domain/user_role.dart';
import 'sheets/create_role_sheet.dart';

/// Role list panel with search and list selection.
class UserRoleListPanel extends HookConsumerWidget {
  const UserRoleListPanel({
    super.key,
    required this.roles,
    this.selectedId,
    required this.onRefresh,
    required this.onEdit,
    required this.onDelete,
    this.onRoleTap,
  });

  final List<UserRole> roles;
  final String? selectedId;
  final Future<void> Function() onRefresh;
  final void Function(UserRole) onEdit;
  final void Function(UserRole) onDelete;
  final void Function(UserRole)? onRoleTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final searchController = useTextEditingController();
    final searchText = useState('');
    final appliedQuery = useState('');

    final isSearchActive = appliedQuery.value.isNotEmpty;
    final filteredRoles =
        isSearchActive ? _filterRoles(roles, appliedQuery.value) : roles;
    final totalCount = filteredRoles.length;

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
        onPressed: () => showCreateRoleSheet(context),
        tooltip: 'Add Role',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Text(t.navigation.roles, style: theme.textTheme.titleLarge),
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
                  ),
          ),

          // Roles list
          Expanded(
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: filteredRoles.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 80),
                        Icon(
                          Icons.admin_panel_settings_outlined,
                          size: 80,
                          color: theme.colorScheme.outlineVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isSearchActive
                              ? 'No roles match "${appliedQuery.value}"'
                              : 'No roles found',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isSearchActive
                              ? 'Try a different search term'
                              : 'Create a role to get started',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: filteredRoles.length,
                      itemBuilder: (context, index) {
                        final role = filteredRoles[index];
                        final isSelected = role.id == selectedId;
                        return _RoleListTile(
                          role: role,
                          isSelected: isSelected,
                          onEdit: () => onEdit(role),
                          onDelete: () => onDelete(role),
                          onTap: () => onRoleTap?.call(role),
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

class _RoleListTile extends StatelessWidget {
  const _RoleListTile({
    required this.role,
    required this.isSelected,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  final UserRole role;
  final bool isSelected;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final permissionCount = role.permissions.length;

    return ListTile(
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primaryContainer,
      onTap: onTap,
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
          Text(
            role.name,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
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
        role.description ??
            '$permissionCount permission${permissionCount == 1 ? '' : 's'}',
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
                  SizedBox(width: 8),
                  Text(
                    'Delete',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ],
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
  });

  final TextEditingController controller;
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
      ],
    );
  }
}

List<UserRole> _filterRoles(List<UserRole> roles, String query) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) {
    return roles;
  }

  return roles.where((role) {
    final nameMatch = role.name.toLowerCase().contains(normalizedQuery);
    final description = role.description ?? '';
    final descriptionMatch =
        description.toLowerCase().contains(normalizedQuery);
    return nameMatch || descriptionMatch;
  }).toList();
}
