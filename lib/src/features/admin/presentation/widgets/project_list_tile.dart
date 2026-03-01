import 'package:flutter/material.dart';

import '../../../portfolio/domain/project.dart';

/// List tile for a project in the admin list.
class ProjectListTile extends StatelessWidget {
  const ProjectListTile({
    super.key,
    required this.project,
    this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Project project;
  final VoidCallback? onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          project.featured ? Icons.star : Icons.code,
          color: project.featured
              ? Colors.amber
              : theme.colorScheme.outline,
        ),
        title: Text(project.title),
        subtitle: Text(
          [
            if (project.category.isNotEmpty) project.category,
            project.status.name,
          ].join(' \u2022 '),
          style: theme.textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
              tooltip: 'Edit',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
