import 'package:flutter/material.dart';

/// Bottom navigation bar for mobile admin layout.
///
/// Displays admin navigation destinations:
/// - Profile
/// - Projects
/// - More (opens drawer)
class MobileBottomNav extends StatelessWidget {
  const MobileBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.onMoreTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback? onMoreTap;

  static const _bottomNavToAppIndex = [0, 1];

  int _getBottomNavIndex() {
    final localIndex = _bottomNavToAppIndex.indexOf(selectedIndex);
    if (localIndex >= 0) return localIndex;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _getBottomNavIndex(),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 60,
      onDestinationSelected: (index) {
        if (index == 2) {
          onMoreTap?.call();
        } else {
          onDestinationSelected(_bottomNavToAppIndex[index]);
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.person_outlined),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.work_outlined),
          selectedIcon: Icon(Icons.work),
          label: 'Projects',
        ),
        NavigationDestination(
          icon: Icon(Icons.more_horiz),
          selectedIcon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }
}
