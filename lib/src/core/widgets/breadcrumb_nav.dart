import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes/admin.routes.dart';

/// A breadcrumb item representing a navigation point.
class BreadcrumbItem {
  const BreadcrumbItem({
    required this.label,
    required this.path,
    this.onTap,
  });

  final String label;
  final String path;
  final VoidCallback? onTap;
}

/// A breadcrumb navigation bar that generates items from the current GoRouter state.
class BreadcrumbNav extends StatelessWidget {
  const BreadcrumbNav({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final items = _buildBreadcrumbs(context, state);

    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) _buildSeparator(context),
            _buildBreadcrumbItem(context, items[i],
                isLast: i == items.length - 1),
          ],
        ],
      ),
    );
  }

  Widget _buildSeparator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.chevron_right,
        size: 18,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildBreadcrumbItem(
    BuildContext context,
    BreadcrumbItem item, {
    required bool isLast,
  }) {
    final theme = Theme.of(context);

    if (isLast) {
      return Text(
        item.label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return InkWell(
      onTap: item.onTap ?? () => context.go(item.path),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          item.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  List<BreadcrumbItem> _buildBreadcrumbs(
      BuildContext context, GoRouterState state) {
    final location = state.uri.path;
    final items = <BreadcrumbItem>[];

    if (location.startsWith('/admin/profile')) {
      items.add(BreadcrumbItem(
        label: 'Profile',
        path: AdminProfileRoute.path,
        onTap: () => const AdminProfileRoute().go(context),
      ));
    } else if (location.startsWith('/admin/projects')) {
      items.add(BreadcrumbItem(
        label: 'Projects',
        path: AdminProjectsRoute.path,
        onTap: () => const AdminProjectsRoute().go(context),
      ));
    }

    return items;
  }
}

/// Extension to easily add breadcrumbs to a page.
extension BreadcrumbNavExtension on Widget {
  Widget withBreadcrumbs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: BreadcrumbNav(),
        ),
        Expanded(child: this),
      ],
    );
  }
}
