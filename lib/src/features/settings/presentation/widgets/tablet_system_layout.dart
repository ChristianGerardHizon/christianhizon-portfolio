import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'branch_list_panel.dart';
import 'empty_system_detail_state.dart';
import 'product_category_list_panel.dart';
import 'species_list_panel.dart';

/// Two-pane tablet layout for system/settings.
///
/// Left pane: Context-aware list panel based on current route section
/// Right pane: Detail panel from router or empty state
class TabletSystemLayout extends ConsumerWidget {
  const TabletSystemLayout({
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

    // Detect which section we're in and build appropriate list panel
    final listPanel = _buildListPanelForSection(path, selectedId);

    // Check if we're in a sub-section that has a list
    final isInSubSection = path.contains('/branches') ||
        path.contains('/species') ||
        path.contains('/product-categories');

    // If we're at the root system page, just show the settings page content
    if (!isInSubSection) {
      return detailChild;
    }

    return Row(
      children: [
        // List panel
        SizedBox(
          width: 320,
          child: listPanel,
        ),
        const VerticalDivider(width: 1),
        // Detail panel from router
        Expanded(
          child: selectedId != null
              ? detailChild
              : const EmptySystemDetailState(),
        ),
      ],
    );
  }

  Widget _buildListPanelForSection(String path, String? selectedId) {
    if (path.contains('/branches')) {
      return BranchListPanel(selectedId: selectedId);
    } else if (path.contains('/species')) {
      return SpeciesListPanel(selectedId: selectedId);
    } else if (path.contains('/product-categories')) {
      return ProductCategoryListPanel(selectedId: selectedId);
    }

    // Default fallback - shouldn't reach here
    return const SizedBox.shrink();
  }
}
