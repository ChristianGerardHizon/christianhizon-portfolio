import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom ScrollBehavior that dismisses the keyboard when scrolling down,
/// unless one of the specified [focusNodesToPreserve] is currently focused.
class KeyboardDismissOnScrollBehavior extends MaterialScrollBehavior {
  final List<FocusNode> focusNodesToPreserve;

  const KeyboardDismissOnScrollBehavior({
    this.focusNodesToPreserve = const [],
  });

  /// Helper function to determine whether the keyboard should be dismissed.
  /// Returns true if none of the focus nodes in [focusNodesToPreserve] are focused.
  bool _shouldDismissKeyboard() {
    for (var node in focusNodesToPreserve) {
      if (node.hasFocus)
        return false; // Prevent dismissal if any node is focused
    }
    return true; // All nodes are unfocused; safe to dismiss keyboard
  }

  /// Overrides the overscroll indicator builder to include scroll notifications.
  /// This allows us to listen for scroll direction and dismiss the keyboard accordingly.
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        // Only act on scroll events that move content downward
        if (notification.scrollDelta != null && notification.scrollDelta! > 0) {
          if (_shouldDismissKeyboard()) {
            // Dismiss the keyboard by unfocusing the current focus
            FocusManager.instance.primaryFocus?.unfocus();
          }
        }
        return false; // Allow other listeners to continue receiving notifications
      },
      child: super.buildOverscrollIndicator(context, child, details),
    );
  }

  /// Ensures that both touch and mouse input devices can trigger scrolling
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // Add more device kinds if needed (e.g., stylus, trackpad)
      };
}
