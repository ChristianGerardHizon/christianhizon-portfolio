import 'package:flutter/material.dart';

class CustomNavigationBarItem extends BottomNavigationBarItem {
  final Function()? onTap;
  final String route;
  final Icon? selectedIcon;
  final bool isRoot;

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
