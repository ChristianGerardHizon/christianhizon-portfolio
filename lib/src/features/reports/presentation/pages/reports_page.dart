import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/report_period_selector.dart';
import '../widgets/views/appointment_report_view.dart';
import '../widgets/views/inventory_report_view.dart';
import '../widgets/views/patient_report_view.dart';
import '../widgets/views/sales_report_view.dart';
import '../widgets/views/treatment_plan_report_view.dart';

/// Main reports page with tabbed navigation for different report types.
class ReportsPage extends HookConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(
              icon: Icon(Icons.attach_money),
              text: 'Sales',
            ),
            Tab(
              icon: Icon(Icons.pets),
              text: 'Patients',
            ),
            Tab(
              icon: Icon(Icons.calendar_today),
              text: 'Appointments',
            ),
            Tab(
              icon: Icon(Icons.inventory_2),
              text: 'Inventory',
            ),
            Tab(
              icon: Icon(Icons.assignment),
              text: 'Treatment Plans',
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const ReportPeriodSelector(),
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          SalesReportView(),
          PatientReportView(),
          AppointmentReportView(),
          InventoryReportView(),
          TreatmentPlanReportView(),
        ],
      ),
    );
  }
}
