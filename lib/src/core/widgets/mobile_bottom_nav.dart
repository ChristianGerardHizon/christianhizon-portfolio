import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/widgets/custom_navbar_item.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';

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

    final moreWidget = CustomNavigationBarItem(
      route: YourAccountPageRoute.path,
      icon: Icon(MIcons.homeCircleOutline),
      label: 'Account',
      onTap: () {
        YourAccountPageRoute().push(context);
      },
    );

    final finalList = list
        .mapWithIndex((item, index) {
          if (index >= 3) return null;
          return item;
        })
        .whereType<CustomNavigationBarItem>()
        .toList()
      ..add(moreWidget);

    ///
    ///
    ///
    bool shouldShowBottomNav(String? path) {
      if (path == null) return false;
      final routes = <String>[
        DashboardPageRoute.path,
        PatientsPageRoute.path,
        ProductsPageRoute.path,
        ProductInventoriesPageRoute.path,
        YourAccountPageRoute.path,
      ];
      return routes.contains(path);
    }

    ///
    ///
    ///
    onRouteChanged(int index, List<CustomNavigationBarItem> list) {
      final item = list[index];
      if (index == 3) {
        moreWidget.onTap?.call();
        return;
      }
      item.onTap?.call();
    }

    ///
    ///
    ///
    int bottomNavIndeCalulator(int index, String? path) {
      if (path == null) return 0;
      if (path == (DashboardPageRoute.path)) return 0;
      if (path.contains(PatientPageRoute.path)) return 1;
      if (path.contains(ProductInventoriesPageRoute.path)) return 2;
      if (path.contains(YourAccountPageRoute.path)) return 3;
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
