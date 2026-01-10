import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';
import 'package:sannjosevet/src/core/models/custom_navbar_item.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';

class MobileBottomNav extends StatelessWidget {
  final List<CustomNavigationBarItem> list;
  final GoRouterState state;
  final int index;

  const MobileBottomNav({
    super.key,
    required this.list,
    required this.index,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final routes = <String>[
      DashboardPageRoute.path,
      PatientsPageRoute.path,
      AppointmentSchedulesPageRoute.path,
      ProductsPageRoute.path,
      MorePageRoute.path,
    ];

    final moreWidget = CustomNavigationBarItem(
      route: MorePageRoute.path,
      icon: Icon(MIcons.dotsHorizontal),
      label: 'More',
      onTap: (context) {
        MorePageRoute().push(context);
      },
    );

    final finalList = list
        .mapWithIndex((item, index) {
          if (routes.contains(item.route)) return item;
          return null;
        })
        .whereType<CustomNavigationBarItem>()
        .toList()
      ..add(moreWidget);

    onRouteChanged(int index, List<CustomNavigationBarItem> list) {
      final item = list[index];
      if (index == 4) {
        moreWidget.onTap?.call(context);
        return;
      }
      item.onTap?.call(context);
    }

    int bottomNavIndexCalculator(int index, String? path) {
      if (path == null) return 0;
      if (path == '/') return 0;
      if (path.startsWith('/patients')) return 1;
      if (path.startsWith('/appointments')) return 2;
      if (path.startsWith('/products')) return 3;
      // Default to "More" for all other routes (organization, system, sales, etc.)
      return 4;
    }

    // Always show bottom nav on mobile
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0),
        BottomNavigationBar(
          items: finalList,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 0,
          currentIndex: bottomNavIndexCalculator(index, state.fullPath),
          selectedFontSize: 13,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
          selectedItemColor: theme.colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => onRouteChanged(index, finalList),
        )
      ],
    );
  }
}
