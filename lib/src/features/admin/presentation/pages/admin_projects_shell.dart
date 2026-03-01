import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/breakpoints.dart';
import '../widgets/tablet_projects_layout.dart';

/// Adaptive shell for admin projects.
///
/// - Mobile: shows child directly (list or detail from router)
/// - Tablet+: wraps child in two-pane layout
class AdminProjectsShell extends ConsumerWidget {
  const AdminProjectsShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!Breakpoints.isTabletOrLarger(context)) {
      return child;
    }

    return TabletProjectsLayout(detailContent: child);
  }
}
