import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/dashboard/presentation/widgets/kpis/kpi_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardKpis extends StatelessWidget {
  const DashboardKpis({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = [
      KpiCard(
        title: "Today's Appointments ",
        value: '10',
        icon: MIcons.clockOutline,
      ),
      KpiCard(
        title: 'Patients',
        value: '100',
        icon: MIcons.accountOutline,
      ),
      KpiCard(
        title: 'Products Near Expiration',
        value: '10',
        icon: MIcons.alertOutline,
      ),
      KpiCard(
        title: "Today's Sales Total",
        value: 'P100.00',
        icon: MIcons.walletOutline,
      ),
    ];

    return getValueForScreenType(
      context: context,
      mobile: Column(
        children: widgets,
      ),
      desktop: Row(
        children: widgets.map((el) => Expanded(child: el)).toList(),
      ),
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
