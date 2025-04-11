import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/responsive_row_column.dart';
import 'package:gym_system/src/features/dashboard/presentation/widgets/kpis/kpi_card.dart';

class DashboardKpis extends StatelessWidget {
  const DashboardKpis({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponsiveRowColumn(
          first: KpiCard(
            title: 'Total Patients',
            value: '100',
            icon: Icon(Icons.person),
          ),
          second: KpiCard(
            title: 'Total Expired Products',
            value: '10',
            icon: Icon(Icons.warning),
          ),
        ),
        ResponsiveRowColumn(
          first: KpiCard(
            title: 'Total Patients',
            value: '100',
            icon: Icon(Icons.person),
          ),
          second: KpiCard(
            title: 'Total Expired Products',
            value: '10',
            icon: Icon(Icons.warning),
          ),
        ),
      ],
    );
  }
}
