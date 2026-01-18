import 'package:flutter/material.dart';

import '../../../../core/utils/breakpoints.dart';
import '../widgets/tablet_messages_layout.dart';

/// Adaptive shell for messages list/detail layout.
///
/// - Mobile: Passes through the child (list or detail page)
/// - Tablet: Shows two-pane layout with list and detail side by side
class MessagesShell extends StatelessWidget {
  const MessagesShell({
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
      return TabletMessagesLayout(detailChild: child);
    }

    // Mobile: Just show the routed child (list or detail)
    return child;
  }
}
