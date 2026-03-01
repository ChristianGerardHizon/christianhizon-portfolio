import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/state/error_state.dart';
import '../../../portfolio/presentation/controllers/projects_controller.dart';
import 'project_list_panel.dart';

/// Two-pane layout for admin projects on tablet/desktop.
///
/// Left pane (320px): project list with search.
/// Right pane (expanded): detail content from router or empty state.
class TabletProjectsLayout extends ConsumerWidget {
  const TabletProjectsLayout({super.key, required this.detailContent});

  final Widget detailContent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsControllerProvider);
    final selectedId = GoRouterState.of(context).pathParameters['id'];

    return projectsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorState(
        message: 'Failed to load projects',
        onRetry: () => ref.invalidate(projectsControllerProvider),
      ),
      data: (projects) => Row(
        children: [
          SizedBox(
            width: 320,
            child: ProjectListPanel(
              projects: projects,
              selectedId: selectedId,
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: selectedId != null
                ? detailContent
                : const _EmptyProjectState(),
          ),
        ],
      ),
    );
  }
}

class _EmptyProjectState extends StatelessWidget {
  const _EmptyProjectState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Select a project to view details',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
