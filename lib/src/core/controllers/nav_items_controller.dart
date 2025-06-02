import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sannjosevet/src/core/models/custom_navbar_item.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/routing/main.routes.dart';

part 'nav_items_controller.g.dart';

@riverpod
class NavItemsController extends _$NavItemsController {
  @override
  FutureOr<List<CustomNavigationBarItem>> build() {
    return [
        CustomNavigationBarItem(
          isRoot: true,
          route: RootRoute.path,
          icon: Icon(MIcons.viewDashboardOutline),
          selectedIcon: Icon(MIcons.viewDashboard),
          label: 'Dashboard',
          onTap: (context) {
            RootRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: PatientsPageRoute.path,
          icon: Icon(MIcons.dog),
          selectedIcon: Icon(MIcons.dog),
          label: 'Patients',
          onTap: (context) {
            PatientsPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: AppointmentSchedulesPageRoute.path,
          icon: Icon(MIcons.calendarAccount),
          selectedIcon: Icon(MIcons.calendarAccountOutline),
          label: 'Appointments',
          onTap: (context) {
            AppointmentSchedulesPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: CalendarAppointmentSchedulesPageRoute.path,
          icon: Icon(MIcons.calendarOutline),
          selectedIcon: Icon(MIcons.calendar),
          label: 'Calendar',
          onTap: (context) {
            CalendarAppointmentSchedulesPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: ProductInventoriesPageRoute.path,
          icon: Icon(MIcons.shoppingOutline),
          selectedIcon: Icon(MIcons.shopping),
          label: 'Products',
          onTap: (context) {
            ProductInventoriesPageRoute().go(context);
          },
        ),
        CustomNavigationBarItem(
          route: SalesCashierPageRoute.path,
          icon: Icon(MIcons.cashRegister),
          selectedIcon: Icon(MIcons.cashRegister),
          label: 'Cashier',
          onTap: (context) {
            SalesCashierPageRoute().go(context);
          },
        ),
      ];
  }
}