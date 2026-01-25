import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/organization/presentation/pages/organization_shell.dart';
import '../../../features/settings/domain/branch.dart';
import '../../../features/settings/presentation/controllers/branches_controller.dart';
import '../../../features/users/domain/user_tab.dart';
import '../../../features/users/presentation/controllers/paginated_users_controller.dart';
import '../../../features/users/presentation/controllers/user_roles_controller.dart';
import '../../../features/users/presentation/pages/user_detail_page.dart';
import '../../../features/users/presentation/widgets/sheets/edit_role_sheet.dart';
import '../../../features/users/presentation/widgets/user_list_panel.dart';
import '../../../features/users/presentation/widgets/user_role_detail_panel.dart';
import '../../../features/users/presentation/widgets/user_role_list_panel.dart';
import '../../i18n/strings.g.dart';
import '../../utils/breakpoints.dart';

part 'organization.routes.g.dart';

/// Organization shell route for 3-panel layout.
///
/// On tablet: Shows nav rail + list + detail side-by-side
/// On mobile: Shows list, then navigates to detail
@TypedShellRoute<OrganizationShellRoute>(
  routes: [
    TypedGoRoute<OrganizationRoute>(
      path: OrganizationRoute.path,
      routes: [
        TypedGoRoute<OrganizationUsersRoute>(
          path: 'users',
          routes: [
            TypedGoRoute<OrganizationUserDetailRoute>(path: ':id'),
          ],
        ),
        TypedGoRoute<OrganizationRolesRoute>(
          path: 'roles',
          routes: [
            TypedGoRoute<OrganizationRoleDetailRoute>(path: ':id'),
          ],
        ),
        TypedGoRoute<OrganizationBranchesRoute>(
          path: 'branches',
          routes: [
            TypedGoRoute<OrganizationBranchDetailRoute>(path: ':id'),
          ],
        ),
      ],
    ),
  ],
)
class OrganizationShellRoute extends ShellRouteData {
  const OrganizationShellRoute();

  @override
  Widget builder(
      BuildContext context, GoRouterState state, Widget navigator) {
    return OrganizationShell(child: navigator);
  }
}

/// Organization root route.
///
/// On tablet: Redirects to /organization/users (3-panel layout)
/// On mobile: Shows landing page with Users/Roles options
class OrganizationRoute extends GoRouteData with $OrganizationRoute {
  const OrganizationRoute();

  static const path = '/organization';

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    // Only redirect on tablet - mobile shows landing page
    if (Breakpoints.isTabletOrLarger(context) && state.uri.path == path) {
      return '$path/users';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Mobile: Show landing page with Users/Roles options
    return const _MobileOrganizationLandingPage();
  }
}

/// Organization users list route.
class OrganizationUsersRoute extends GoRouteData with $OrganizationUsersRoute {
  const OrganizationUsersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show users list
    return const _OrganizationUsersListPage();
  }
}

/// Organization user detail route.
class OrganizationUserDetailRoute extends GoRouteData
    with $OrganizationUserDetailRoute {
  const OrganizationUserDetailRoute({required this.id, this.tab});

  final String id;
  final String? tab;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final tabName = state.uri.queryParameters['tab'];
    return UserDetailPage(
      userId: id,
      initialTab: UserTab.fromString(tabName),
    );
  }
}

/// Organization roles list route.
class OrganizationRolesRoute extends GoRouteData with $OrganizationRolesRoute {
  const OrganizationRolesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show roles list
    return const _OrganizationRolesListPage();
  }
}

/// Organization role detail route.
class OrganizationRoleDetailRoute extends GoRouteData
    with $OrganizationRoleDetailRoute {
  const OrganizationRoleDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _RoleDetailWrapper(roleId: id);
  }
}

/// Organization branches list route.
class OrganizationBranchesRoute extends GoRouteData
    with $OrganizationBranchesRoute {
  const OrganizationBranchesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show branches list
    return const _OrganizationBranchesListPage();
  }
}

/// Organization branch detail route.
class OrganizationBranchDetailRoute extends GoRouteData
    with $OrganizationBranchDetailRoute {
  const OrganizationBranchDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _BranchDetailWrapper(branchId: id);
  }
}

// ============================================================================
// Mobile Pages
// ============================================================================

/// Mobile landing page for organization with Users/Roles selection.
class _MobileOrganizationLandingPage extends StatelessWidget {
  const _MobileOrganizationLandingPage();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.navigation.organization),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _OrganizationOptionCard(
                icon: Icons.people,
                title: t.navigation.users,
                color: theme.colorScheme.primary,
                onTap: () => const OrganizationUsersRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _OrganizationOptionCard(
                icon: Icons.admin_panel_settings,
                title: t.navigation.roles,
                color: theme.colorScheme.secondary,
                onTap: () => const OrganizationRolesRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _OrganizationOptionCard(
                icon: Icons.store,
                title: t.navigation.branches,
                color: theme.colorScheme.tertiary,
                onTap: () => const OrganizationBranchesRoute().go(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for organization option selection.
class _OrganizationOptionCard extends StatelessWidget {
  const _OrganizationOptionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile users list page for organization.
class _OrganizationUsersListPage extends ConsumerWidget {
  const _OrganizationUsersListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginatedAsync = ref.watch(paginatedUsersControllerProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.navigation.users),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: t.navigation.roles,
            onPressed: () => const OrganizationRolesRoute().go(context),
          ),
        ],
      ),
      body: paginatedAsync.when(
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
                onPressed: () => ref
                    .read(paginatedUsersControllerProvider.notifier)
                    .refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (paginatedState) => UserListPanel(
          paginatedState: paginatedState,
          selectedId: null,
          onUserTap: (user) {
            OrganizationUserDetailRoute(id: user.id).push(context);
          },
          onRefresh: () =>
              ref.read(paginatedUsersControllerProvider.notifier).refresh(),
          onLoadMore: () =>
              ref.read(paginatedUsersControllerProvider.notifier).loadMore(),
        ),
      ),
    );
  }
}

/// Mobile roles list page for organization.
class _OrganizationRolesListPage extends ConsumerWidget {
  const _OrganizationRolesListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(userRolesControllerProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.navigation.roles),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            tooltip: t.navigation.users,
            onPressed: () => const OrganizationUsersRoute().go(context),
          ),
        ],
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
        data: (roles) => UserRoleListPanel(
          roles: roles,
          selectedId: null,
          onRefresh: () =>
              ref.read(userRolesControllerProvider.notifier).refresh(),
          onEdit: (role) => showEditRoleSheet(context, role),
          onDelete: (role) => _confirmDeleteRole(context, ref, role),
          onRoleTap: (role) {
            OrganizationRoleDetailRoute(id: role.id).push(context);
          },
        ),
      ),
    );
  }

  void _confirmDeleteRole(BuildContext context, WidgetRef ref, role) {
    if (role.isSystem) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('System roles cannot be deleted')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Role'),
        content:
            Text('Are you sure you want to delete the "${role.name}" role?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
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

/// Wrapper to fetch and display role detail.
class _RoleDetailWrapper extends ConsumerWidget {
  const _RoleDetailWrapper({required this.roleId});

  final String roleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(userRolesControllerProvider);

    return rolesAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
            ],
          ),
        ),
      ),
      data: (roles) {
        final role = roles.cast().firstWhere(
              (r) => r.id == roleId,
              orElse: () => null,
            );

        if (role == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Role not found'),
            ),
          );
        }

        return UserRoleDetailPanel(role: role);
      },
    );
  }
}

/// Mobile branches list page for organization.
class _OrganizationBranchesListPage extends ConsumerWidget {
  const _OrganizationBranchesListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(branchesControllerProvider);
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.navigation.branches),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            tooltip: t.navigation.users,
            onPressed: () => const OrganizationUsersRoute().go(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'branch_fab',
        onPressed: () =>
            const OrganizationBranchDetailRoute(id: 'new').push(context),
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
                onPressed: () =>
                    ref.read(branchesControllerProvider.notifier).refresh(),
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
            onRefresh: () =>
                ref.read(branchesControllerProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                return _MobileBranchListTile(
                  branch: branch,
                  onTap: () => OrganizationBranchDetailRoute(id: branch.id)
                      .push(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _MobileBranchListTile extends StatelessWidget {
  const _MobileBranchListTile({
    required this.branch,
    required this.onTap,
  });

  final Branch branch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(
          Icons.store_outlined,
          color: theme.colorScheme.onPrimaryContainer,
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

/// Wrapper to display branch detail with organization navigation.
class _BranchDetailWrapper extends HookConsumerWidget {
  const _BranchDetailWrapper({required this.branchId});

  final String branchId;

  bool get isCreating => branchId == 'new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final branchesAsync = ref.watch(branchesControllerProvider);

    // Find the branch from the list
    final branches = branchesAsync.value;
    final branch = branches?.cast<Branch?>().firstWhere(
          (b) => b?.id == branchId,
          orElse: () => null,
        );

    if (!isCreating && branchesAsync.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!isCreating && branch == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                'Branch not found',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _OrganizationBranchDetailPage(
      branch: branch,
      isCreating: isCreating,
    );
  }
}

/// Branch detail page for organization section.
class _OrganizationBranchDetailPage extends HookConsumerWidget {
  const _OrganizationBranchDetailPage({
    required this.branch,
    required this.isCreating,
  });

  final Branch? branch;
  final bool isCreating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final isDeleting = useState(false);

    // Reset form when branch changes
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.patchValue({
          'name': branch?.name ?? '',
          'address': branch?.address ?? '',
          'contactNumber': branch?.contactNumber ?? '',
        });
      });
      return null;
    }, [branch?.id]);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();
      if (!isValid) return;

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final branchData = Branch(
        id: isCreating ? '' : branch!.id,
        name: (values['name'] as String).trim(),
        address: (values['address'] as String).trim(),
        contactNumber: (values['contactNumber'] as String).trim(),
      );

      bool success;
      if (isCreating) {
        success = await ref
            .read(branchesControllerProvider.notifier)
            .createBranch(branchData);
      } else {
        success = await ref
            .read(branchesControllerProvider.notifier)
            .updateBranch(branchData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save branch. Please try again.'),
            ),
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isCreating
                ? 'Branch created successfully'
                : 'Branch updated successfully'),
          ),
        );

        if (isCreating) {
          context.pop();
        }
      }
    }

    Future<void> handleDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete Branch'),
          content: Text('Are you sure you want to delete "${branch?.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      isDeleting.value = true;
      final success = await ref
          .read(branchesControllerProvider.notifier)
          .deleteBranch(branch!.id);

      if (context.mounted) {
        isDeleting.value = false;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Branch deleted successfully')),
          );
          context.pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete branch. Please try again.'),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isCreating ? 'New Branch' : 'Edit Branch'),
        actions: [
          if (!isCreating)
            IconButton(
              icon: isDeleting.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              onPressed: isDeleting.value ? null : handleDelete,
            ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: isSaving.value ? null : handleSave,
            child: isSaving.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'name',
                initialValue: isCreating ? '' : branch?.name,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter branch name',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'address',
                initialValue: isCreating ? '' : branch?.address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter address',
                ),
                maxLines: 2,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'contactNumber',
                initialValue: isCreating ? '' : branch?.contactNumber,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  hintText: 'Enter contact number',
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
