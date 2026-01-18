import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Empty state shown in the detail pane when no item is selected.
///
/// Displays context-aware message based on the current section.
class EmptySystemDetailState extends StatelessWidget {
  const EmptySystemDetailState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final path = GoRouterState.of(context).uri.path;

    // Determine section from path
    final (icon, message) = _getSectionInfo(path);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  (IconData, String) _getSectionInfo(String path) {
    if (path.contains('/branches')) {
      return (Icons.store_outlined, 'Select a branch to view details');
    } else if (path.contains('/species')) {
      return (Icons.pets_outlined, 'Select a species to view details');
    } else if (path.contains('/product-categories')) {
      return (
        Icons.inventory_2_outlined,
        'Select a category to view details'
      );
    }
    return (Icons.info_outline, 'Select an item to view details');
  }
}
