import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/admin.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../../core/widgets/state/empty_state.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../../../portfolio/presentation/controllers/projects_controller.dart';
import '../widgets/project_form_dialog.dart';
import '../widgets/project_list_tile.dart';

/// Admin page for managing portfolio projects.
///
/// On tablet+, returns [SizedBox.shrink] since the shell handles the list.
/// On mobile, shows the full project list.
class AdminProjectsPage extends ConsumerWidget {
  const AdminProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On tablet, the shell's TabletProjectsLayout handles the list panel.
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }

    final projectsAsync = ref.watch(projectsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProjectForm(context),
        child: const Icon(Icons.add),
      ),
      body: projectsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorState(
          message: 'Failed to load projects',
          onRetry: () => ref.invalidate(projectsControllerProvider),
        ),
        data: (projects) {
          if (projects.isEmpty) {
            return EmptyState(
              icon: Icons.folder_open,
              title: 'No projects yet',
              subtitle: 'Add your first project to get started.',
              action: FilledButton.icon(
                onPressed: () => _showProjectForm(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Project'),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectListTile(
                project: project,
                onTap: () =>
                    AdminProjectDetailRoute(id: project.id).go(context),
                onEdit: () => _showProjectForm(context, project: project),
                onDelete: () => _confirmDelete(context, ref, project.id),
              );
            },
          );
        },
      ),
    );
  }

  void _showProjectForm(
    BuildContext context, {
    dynamic project,
  }) {
    showDialog(
      context: context,
      builder: (context) => ProjectFormDialog(project: project),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: const Text(
          'Are you sure you want to delete this project?',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              context.pop();
              await ref
                  .read(projectsControllerProvider.notifier)
                  .delete(id);
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
