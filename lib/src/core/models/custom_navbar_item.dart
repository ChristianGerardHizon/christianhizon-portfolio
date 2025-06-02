import 'package:flutter/material.dart';

class CustomNavigationBarItem extends BottomNavigationBarItem {
  final Function(BuildContext context)? onTap;
  final String route;
  final Icon? selectedIcon;
  final bool isRoot;
  final bool isMobile;

  CustomNavigationBarItem({
    required super.icon,
    required this.route,
    super.label = '',
    super.activeIcon,
    super.backgroundColor,
    super.tooltip,
    this.onTap,
    this.selectedIcon,
    this.isRoot = false,
    this.isMobile = true,
  });

  NavigationRailDestination get navRail {
    Widget widget = Text(super.label ?? '');

    if (super.label == '') {
      widget = const SizedBox();
    }

    return NavigationRailDestination(
      icon: super.icon,
      label: widget,
    );
  }
}
