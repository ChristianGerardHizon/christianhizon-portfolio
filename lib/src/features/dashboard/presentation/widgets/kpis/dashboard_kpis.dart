import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_system/src/features/dashboard/presentation/widgets/kpis/kpi_card.dart';

class DashboardKpis extends StatelessWidget {
  const DashboardKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KpiCard(
            title: 'Total Patients',
            value: '100',
            icon: Icon(Icons.person),
          ),
        ),
        Expanded(
          child: KpiCard(
            title: 'Total Expired Products',
            value: '10',
            icon: Icon(Icons.warning),
          ),
        ),
        Expanded(
          child: KpiCard(
            title: 'Total Available Products',
            value: '100',
            icon: Icon(Icons.inventory),
          ),
        ),
        Expanded(
          child: KpiCard(
            title: 'Monthly Visits',
            value: '100',
            icon: Icon(Icons.calendar_month),
          ),
        ),
      ],
    );
  }
}
