import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/pages/appointment_schedules_by_date_page.dart';
import 'package:sannjosevet/src/features/dashboard/presentation/widgets/kpis/kpi_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardKpis extends StatelessWidget {
  const DashboardKpis({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = [
      KpiCard(
        onTap: () => AppointmentSchedulesByDatePageRoute(
          date: DateTime.now().startOfDay,
        ).push(context),
        title: "Today's Appointments ",
        value: '5',
        icon: MIcons.clockOutline,
      ),
      KpiCard(
        title: "New Patients Today",
        value: '10',
        icon: MIcons.accountOutline,
      ),
      KpiCard(
        title: 'Products Near Expiration',
        value: '10',
        icon: MIcons.alertOutline,
      ),
      KpiCard(
        title: "Today's Sales",
        value: '-',
        icon: MIcons.walletOutline,
      ),
    ];

    return getValueForScreenType(
      context: context,
      mobile: Column(children: widgets),
      tablet: Column(
        children: [
          Row(
            children: widgets
                .sublist(0, (widgets.length / 2).ceil())
                .map((el) => Expanded(child: el))
                .toList(),
          ),
          Row(
            children: widgets
                .sublist((widgets.length / 2).ceil())
                .map((el) => Expanded(child: el))
                .toList(),
          ),
        ],
      ),
    );
  }
}
