import 'package:flutter/material.dart';

import '../../../../core/utils/breakpoints.dart';
import '../widgets/tablet_organization_layout.dart';

/// Adaptive shell for organization 3-panel layout.
///
/// - Mobile: Passes through the child (list or detail page)
/// - Tablet: Shows 3-panel layout (nav + list + detail)
class OrganizationShell extends StatelessWidget {
  const OrganizationShell({
    super.key,
    required this.child,
  });

  /// The child widget from the router (detail page or placeholder).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isTablet = Breakpoints.isTabletOrLarger(context);

    if (isTablet) {
      // Tablet: 3-panel layout
      return TabletOrganizationLayout(detailChild: child);
    }

    // Mobile: Just show the routed child (list or detail)
    return child;
  }
}
