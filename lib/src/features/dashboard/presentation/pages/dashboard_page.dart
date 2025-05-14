import 'package:flutter/material.dart';
import 'package:gym_system/src/core/controllers/scaffold_controller.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/widgets/appointment_schedule_today_view.dart';
import 'package:gym_system/src/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:gym_system/src/features/dashboard/presentation/widgets/kpis/dashboard_kpis.dart';
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
              SliverPadding(
                padding: const EdgeInsets.only(left: 18, top: 30, right: 18),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                        icon: Icon(MIcons.menu),
                      ),
                      Text(
                        'Welcome ${name}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              ),
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
                  child: AppointmentScheduleTodayView(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
