import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/admin.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../../../portfolio/domain/project.dart';
import '../../../portfolio/presentation/controllers/projects_controller.dart';
import '../widgets/project_form_dialog.dart';

/// Admin detail page for a single project.
///
/// Used as the right pane on tablet or a full page on mobile.
class AdminProjectDetailPage extends ConsumerWidget {
  const AdminProjectDetailPage({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectByIdProvider(projectId));
    final isTablet = Breakpoints.isTabletOrLarger(context);
    final theme = Theme.of(context);

    return projectAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: ErrorState(
          message: 'Failed to load project',
          onRetry: () => ref.invalidate(projectByIdProvider(projectId)),
        ),
      ),
      data: (project) {
        if (project == null) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: !isTablet,
            ),
            body: const Center(child: Text('Project not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: !isTablet,
            title: Text(project.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditDialog(context, project),
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmDelete(context, ref, project.id),
                tooltip: 'Delete',
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () =>
                    ref.invalidate(projectByIdProvider(projectId)),
                tooltip: 'Refresh',
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Status & Featured
              Row(
                children: [
                  Chip(
                    label: Text(project.status.name),
                    avatar: Icon(
                      Icons.circle,
                      size: 12,
                      color: project.status.name == 'active'
                          ? Colors.green
                          : theme.colorScheme.outline,
                    ),
                  ),
                  if (project.featured) ...[
                    const SizedBox(width: 8),
                    const Chip(
                      label: Text('Featured'),
                      avatar: Icon(Icons.star, size: 16, color: Colors.amber),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              // Description
              if (project.description.isNotEmpty) ...[
                Text('Description', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Text(project.description),
                const SizedBox(height: 16),
              ],
              // Long Description
              if (project.longDescription.isNotEmpty) ...[
                Text('Long Description', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Text(project.longDescription),
                const SizedBox(height: 16),
              ],
              // Project Info
              _buildInfoSection(theme, project),
              const SizedBox(height: 16),
              // Tech Stack
              if (project.techStack.isNotEmpty) ...[
                Text('Tech Stack', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techStack
                      .map((t) => Chip(label: Text(t)))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],
              // URLs
              if (project.projectUrl.isNotEmpty) ...[
                _buildUrlRow(theme, 'Live URL', project.projectUrl),
                const SizedBox(height: 8),
              ],
              if (project.sourceUrl.isNotEmpty) ...[
                _buildUrlRow(theme, 'Source URL', project.sourceUrl),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(ThemeData theme, Project project) {
    final items = <MapEntry<String, String>>[
      if (project.category.isNotEmpty)
        MapEntry('Category', project.category),
      if (project.client.isNotEmpty)
        MapEntry('Client', project.client),
      if (project.role.isNotEmpty) MapEntry('Role', project.role),
      if (project.timeline.isNotEmpty)
        MapEntry('Timeline', project.timeline),
      MapEntry('Sort Order', project.sortOrder.toString()),
    ];

    if (items.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Project Info', style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            ...items.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          e.key,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                      Expanded(child: Text(e.value)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlRow(ThemeData theme, String label, String url) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
        Expanded(
          child: Text(
            url,
            style: TextStyle(color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (_) => ProjectFormDialog(project: project),
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
              if (context.mounted) {
                const AdminProjectsRoute().go(context);
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
