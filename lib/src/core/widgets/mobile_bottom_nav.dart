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
      ProductInventoriesPageRoute.path,
      YourAccountPageRoute.path,
    ];

    final moreWidget = CustomNavigationBarItem(
      route: YourAccountPageRoute.path,
      icon: Icon(MIcons.homeCircleOutline),
      label: 'Account',
      onTap: (context) {
        YourAccountPageRoute().push(context);
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

    ///
    ///
    ///
    bool shouldShowBottomNav(String? path) {
      if (path == null) return false;
      return routes.contains(path);
    }

    ///
    ///
    ///
    onRouteChanged(int index, List<CustomNavigationBarItem> list) {
      final item = list[index];
      if (index == 4) {
        moreWidget.onTap?.call(context);
        return;
      }
      item.onTap?.call(context);
    }

    ///
    ///
    ///
    int bottomNavIndeCalulator(int index, String? path) {
      if (path == null) return 0;
      if (path == (DashboardPageRoute.path)) return 0;
      if (path.contains(PatientsPageRoute.path)) return 1;
      if (path.contains(AppointmentSchedulesPageRoute.path)) return 2;
      if (path.contains(ProductInventoriesPageRoute.path)) return 3;
      if (path.contains(YourAccountPageRoute.path)) return 4;
      return 0;
    }

    ///
    ///
    ///
    if (shouldShowBottomNav(state.fullPath) == false) {
      return SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0),
        BottomNavigationBar(
          items: finalList,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          elevation: 0,
          currentIndex: bottomNavIndeCalulator(index, state.fullPath),
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
