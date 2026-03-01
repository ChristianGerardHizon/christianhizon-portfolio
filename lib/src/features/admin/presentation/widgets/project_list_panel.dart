import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/admin.routes.dart';
import '../../../portfolio/domain/project.dart';
import '../../../portfolio/presentation/controllers/projects_controller.dart';
import 'project_form_dialog.dart';

/// Left panel for the two-pane projects layout.
///
/// Shows a searchable list of projects with FAB for creating new ones.
class ProjectListPanel extends HookConsumerWidget {
  const ProjectListPanel({
    super.key,
    required this.projects,
    this.selectedId,
  });

  final List<Project> projects;
  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    useEffect(() {
      void listener() => searchQuery.value = searchController.text;
      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    final filteredProjects = searchQuery.value.isEmpty
        ? projects
        : projects.where((p) {
            final q = searchQuery.value.toLowerCase();
            return p.title.toLowerCase().contains(q) ||
                p.category.toLowerCase().contains(q);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(projectsControllerProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search projects...',
                border: const OutlineInputBorder(),
                isDense: true,
                suffixIcon: searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => searchController.clear(),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: filteredProjects.isEmpty
                ? Center(
                    child: Text(
                      searchQuery.value.isNotEmpty
                          ? 'No matching projects'
                          : 'No projects yet',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];
                      final isSelected = project.id == selectedId;

                      return ListTile(
                        selected: isSelected,
                        leading: Icon(
                          project.featured ? Icons.star : Icons.code,
                          color: project.featured
                              ? Colors.amber
                              : Theme.of(context).colorScheme.outline,
                        ),
                        title: Text(
                          project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          [
                            if (project.category.isNotEmpty) project.category,
                            project.status.name,
                          ].join(' \u2022 '),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        onTap: () => AdminProjectDetailRoute(id: project.id)
                            .go(context),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const ProjectFormDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
