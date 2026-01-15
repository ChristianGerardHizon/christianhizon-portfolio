import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/appointments/presentation/controllers/appointments_controller.dart';
import '../../../features/dashboard/presentation/widgets/tablet_dashboard_layout.dart';
import '../../../features/dashboard/presentation/widgets/today_appointments_section.dart';
import '../../utils/breakpoints.dart';

part 'dashboard.routes.g.dart';

/// Dashboard/home page route.
@TypedGoRoute<DashboardRoute>(path: DashboardRoute.path)
class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardPage();
  }
}

/// Dashboard page content.
///
/// This is rendered within the [AppRoot] shell which provides
/// the AppBar and navigation. Only the body content is defined here.
///
/// On tablet: Shows two-pane layout with list and quick summary
/// On mobile: Shows single-column list
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = Breakpoints.isTabletOrLarger(context);

    if (isTablet) {
      return const Scaffold(
        body: TabletDashboardLayout(),
      );
    }

    // Mobile: Single column layout
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(appointmentsControllerProvider.notifier).refresh(),
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16),
          child: TodayAppointmentsSection(),
        ),
      ),
    );
  }
}
