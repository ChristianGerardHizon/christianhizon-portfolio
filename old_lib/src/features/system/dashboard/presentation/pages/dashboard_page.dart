import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/assets/i18n/strings.g.dart';
import 'package:sannjosevet/src/core/controllers/scaffold_controller.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/center_progress_indicator.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/widgets/appointment_schedule_by_date_view.dart';
import 'package:sannjosevet/src/features/system/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:sannjosevet/src/features/system/dashboard/presentation/widgets/kpis/dashboard_kpis.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);
    final scaffoldKey = ref.watch(scaffoldControllerProvider);

    return Scaffold(
      body: state.when(
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => CenteredProgressIndicator(),
        data: (dashboardState) {
          final auth = dashboardState.auth;

          final name = auth.map(
            (user) => user.record.name,
            (admin) => admin.record.name,
          );

          return CustomScrollView(
            slivers: [
              ///
              /// Welcome Message
              ///
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                leading: IconButton(
                  onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  icon: Icon(MIcons.menu),
                ),
                title: Text(
                  context.t.common.appName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                centerTitle: false,
              ),

              ///
              /// Welcome Message
              ///
              SliverPadding(
                padding: const EdgeInsets.only(left: 18, top: 20, right: 18),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Welcome, $name',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),

              ///
              /// KPIs
              ///
              SliverPadding(
                padding: const EdgeInsets.only(left: 18, top: 20, right: 18),
                sliver: SliverList.list(
                  children: [
                    DashboardKpis(),
                  ],
                ),
              ),

              ///
              ///
              ///
              SliverPadding(
                padding: const EdgeInsets.only(left: 18, top: 20, right: 18),
                sliver: SliverToBoxAdapter(
                  child: AppointmentScheduleByDateView(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
