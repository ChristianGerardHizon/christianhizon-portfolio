import 'package:flutter/material.dart';

import '../../../../core/utils/breakpoints.dart';
import '../widgets/tablet_patients_layout.dart';

/// Adaptive shell for patients list/detail layout.
///
/// - Mobile: Passes through the child (list or detail page)
/// - Tablet: Shows two-pane layout with list and detail side by side
class PatientsShell extends StatelessWidget {
  const PatientsShell({
    super.key,
    required this.child,
  });

  /// The child widget from the router (detail page or placeholder).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isTablet = Breakpoints.isTabletOrLarger(context);

    if (isTablet) {
      // Tablet: Two-pane layout with list always visible
      return TabletPatientsLayout(detailChild: child);
    }

    // Mobile: Just show the routed child (list or detail)
    return child;
  }
}
