import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/organization.routes.dart';
import '../../../settings/domain/branch.dart';
import '../../../settings/presentation/controllers/branches_controller.dart';
import '../../../users/presentation/controllers/paginated_users_controller.dart';
import '../../../users/presentation/controllers/user_roles_controller.dart';
import '../../../users/presentation/widgets/sheets/edit_role_sheet.dart';
import '../../../users/presentation/widgets/user_list_panel.dart';
import '../../../users/presentation/widgets/user_role_list_panel.dart';
import 'empty_organization_state.dart';
import 'organization_nav_panel.dart';

/// Three-panel tablet layout for organization management.
///
/// Panel 1 (72px): Navigation rail for Users/Roles mode selection
/// Panel 2 (320px): List panel (users or roles based on current mode)
/// Panel 3 (expanded): Detail panel from router or empty state
class TabletOrganizationLayout extends ConsumerWidget {
  const TabletOrganizationLayout({
    super.key,
    required this.detailChild,
  });

  /// The detail panel content from the router.
  final Widget detailChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerState = GoRouterState.of(context);
    final path = routerState.uri.path;
    final selectedId = routerState.pathParameters['id'];

    // Determine current mode from path
    final OrganizationMode currentMode;
    if (path.contains('/roles')) {
      currentMode = OrganizationMode.roles;
    } else if (path.contains('/branches')) {
      currentMode = OrganizationMode.branches;
    } else {
      currentMode = OrganizationMode.users;
    }

    return Row(
      children: [
        // Panel 1: Navigation
        OrganizationNavPanel(
          currentMode: currentMode,
          onModeChanged: (mode) {
            switch (mode) {
              case OrganizationMode.users:
                const OrganizationUsersRoute().go(context);
              case OrganizationMode.roles:
                const OrganizationRolesRoute().go(context);
              case OrganizationMode.branches:
                const OrganizationBranchesRoute().go(context);
            }
          },
        ),
        const VerticalDivider(width: 1),

        // Panel 2: List
        SizedBox(
          width: 320,
          child: switch (currentMode) {
            OrganizationMode.users => _UsersListWrapper(selectedId: selectedId),
            OrganizationMode.roles => _RolesListWrapper(selectedId: selectedId),
            OrganizationMode.branches =>
              _BranchesListWrapper(selectedId: selectedId),
          },
        ),
        const VerticalDivider(width: 1),

        // Panel 3: Detail
        Expanded(
          child: selectedId != null
              ? detailChild
              : EmptyOrganizationState(mode: currentMode),
        ),
      ],
    );
  }
}

/// Wrapper for UserListPanel with organization-specific navigation.
class _UsersListWrapper extends ConsumerWidget {
  const _UsersListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(paginatedUsersControllerProvider);
    final usersController = ref.read(paginatedUsersControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'user_fab',
        onPressed: () =>
            const OrganizationUserDetailRoute(id: 'new').go(context),
        child: const Icon(Icons.add),
      ),
      body: usersAsync.when(
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
                onPressed: () => usersController.refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (paginatedState) => UserListPanel(
          paginatedState: paginatedState,
          selectedId: selectedId,
          onUserTap: (user) {
            OrganizationUserDetailRoute(id: user.id).go(context);
          },
          onRefresh: () => usersController.refresh(),
          onLoadMore: () => usersController.loadMore(),
        ),
      ),
    );
  }
}

/// Wrapper for UserRoleListPanel with organization-specific navigation.
class _RolesListWrapper extends ConsumerWidget {
  const _RolesListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(userRolesControllerProvider);
    final rolesController = ref.read(userRolesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'role_fab',
        onPressed: () =>
            const OrganizationRoleDetailRoute(id: 'new').go(context),
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
                onPressed: () => rolesController.refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (roles) => UserRoleListPanel(
          roles: roles,
          selectedId: selectedId,
          onRefresh: () => rolesController.refresh(),
          onEdit: (role) => showEditRoleSheet(context, role),
          onDelete: (role) => _confirmDeleteRole(context, ref, role),
          onRoleTap: (role) {
            OrganizationRoleDetailRoute(id: role.id).go(context);
          },
        ),
      ),
    );
  }

  void _confirmDeleteRole(BuildContext context, WidgetRef ref, role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role'),
        content:
            Text('Are you sure you want to delete the "${role.name}" role?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(userRolesControllerProvider.notifier)
                  .deleteRole(role.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? 'Role deleted' : 'Failed to delete role',
                    ),
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Wrapper for BranchListPanel with organization-specific navigation.
class _BranchesListWrapper extends ConsumerWidget {
  const _BranchesListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final branchesAsync = ref.watch(branchesControllerProvider);
    final controller = ref.read(branchesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Branches'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'branch_fab',
        onPressed: () =>
            const OrganizationBranchDetailRoute(id: 'new').go(context),
        child: const Icon(Icons.add),
      ),
      body: branchesAsync.when(
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
        data: (branches) {
          if (branches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No branches yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a branch',
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
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                final isSelected = branch.id == selectedId;

                return _BranchListTile(
                  branch: branch,
                  isSelected: isSelected,
                  onTap: () =>
                      OrganizationBranchDetailRoute(id: branch.id).go(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _BranchListTile extends StatelessWidget {
  const _BranchListTile({
    required this.branch,
    required this.isSelected,
    required this.onTap,
  });

  final Branch branch;
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
          Icons.store_outlined,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(branch.name),
      subtitle: branch.address != null
          ? Text(
              branch.address!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
