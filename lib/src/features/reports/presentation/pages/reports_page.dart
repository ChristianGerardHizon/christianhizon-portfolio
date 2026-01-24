import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../controllers/appointment_report_controller.dart';
import '../controllers/inventory_report_controller.dart';
import '../controllers/patient_report_controller.dart';
import '../controllers/report_period_controller.dart';
import '../controllers/sales_report_controller.dart';
import '../controllers/treatment_plan_report_controller.dart';
import '../pdf/report_pdf_generator.dart';
import '../widgets/report_export_menu.dart';
import '../widgets/report_period_selector.dart';
import '../widgets/views/appointment_report_view.dart';
import '../widgets/views/inventory_report_view.dart';
import '../widgets/views/patient_report_view.dart';
import '../widgets/views/sales_report_view.dart';
import '../widgets/views/treatment_plan_report_view.dart';

/// Main reports page with tabbed navigation for different report types.
class ReportsPage extends HookConsumerWidget {
  const ReportsPage({super.key});

  static final _currencyFormat = NumberFormat.currency(symbol: '₱');

  static const _tabTitles = [
    'Sales Report',
    'Patient Report',
    'Appointments Report',
    'Inventory Report',
    'Treatment Plans Report',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 5);
    final currentTabIndex = useState(0);

    useEffect(() {
      void listener() {
        currentTabIndex.value = tabController.index;
      }

      tabController.addListener(listener);
      return () => tabController.removeListener(listener);
    }, [tabController]);

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
          ReportExportMenu(
            onPrint: () => _exportReport(context, ref, currentTabIndex.value, 'print'),
            onShare: () => _exportReport(context, ref, currentTabIndex.value, 'share'),
            onSave: () => _exportReport(context, ref, currentTabIndex.value, 'save'),
          ),
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

  Future<void> _exportReport(
    BuildContext context,
    WidgetRef ref,
    int tabIndex,
    String action,
  ) async {
    final period = ref.read(reportPeriodControllerProvider);
    final reportTitle = _tabTitles[tabIndex];

    try {
      final kpiData = await _getKpiData(ref, tabIndex);
      final tableData = await _getTableData(ref, tabIndex);

      final pdfData = ReportPdfData(
        reportTitle: reportTitle,
        period: period,
        generatedAt: DateTime.now(),
        kpiData: kpiData,
        tableHeaders: tableData.$1,
        tableRows: tableData.$2,
      );

      final generator = ReportPdfGenerator(pdfData);

      switch (action) {
        case 'print':
          await generator.printReport();
          break;
        case 'share':
          await generator.shareReport();
          break;
        case 'save':
          final result = await generator.saveReport();
          if (context.mounted && result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Report saved: $result.pdf')),
            );
          }
          break;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting report: $e')),
        );
      }
    }
  }

  Future<Map<String, String>> _getKpiData(WidgetRef ref, int tabIndex) async {
    switch (tabIndex) {
      case 0: // Sales
        final report = await ref.read(salesReportProvider.future);
        return {
          'Total Revenue': _currencyFormat.format(report.totalRevenue),
          'Transactions': report.transactionCount.toString(),
          'Avg Transaction': _currencyFormat.format(report.averageTransactionValue),
        };
      case 1: // Patients
        final report = await ref.read(patientReportProvider.future);
        return {
          'Total Patients': report.totalPatients.toString(),
          'New in Period': report.newPatientsInPeriod.toString(),
          'Species Count': report.patientsBySpecies.length.toString(),
        };
      case 2: // Appointments
        final report = await ref.read(appointmentReportProvider.future);
        return {
          'Total': report.totalAppointments.toString(),
          'Completed': report.completedCount.toString(),
          'Missed': report.missedCount.toString(),
          'Completion Rate': '${report.completionRate.toStringAsFixed(1)}%',
        };
      case 3: // Inventory
        final report = await ref.read(inventoryReportProvider.future);
        return {
          'Total Products': report.totalProducts.toString(),
          'In Stock': report.inStockCount.toString(),
          'Low Stock': report.lowStockCount.toString(),
          'Out of Stock': report.outOfStockCount.toString(),
          'Inventory Value': _currencyFormat.format(report.totalInventoryValue),
        };
      case 4: // Treatment Plans
        final report = await ref.read(treatmentPlanReportProvider.future);
        return {
          'Total Plans': report.totalPlans.toString(),
          'Active': report.activePlans.toString(),
          'Completed': report.completedPlans.toString(),
          'Completion Rate': '${report.completionRate.toStringAsFixed(1)}%',
        };
      default:
        return {};
    }
  }

  Future<(List<String>?, List<List<String>>?)> _getTableData(
    WidgetRef ref,
    int tabIndex,
  ) async {
    switch (tabIndex) {
      case 0: // Sales - Top Products
        final report = await ref.read(salesReportProvider.future);
        if (report.topSellingProducts.isEmpty) return (null, null);
        return (
          ['Product', 'Quantity', 'Revenue'],
          report.topSellingProducts
              .map((p) => [
                    p.productName,
                    p.quantity.toString(),
                    _currencyFormat.format(p.revenue),
                  ])
              .toList(),
        );
      case 3: // Inventory - Low Stock
        final report = await ref.read(inventoryReportProvider.future);
        if (report.lowStockItems.isEmpty) return (null, null);
        return (
          ['Product', 'Category', 'Stock', 'Threshold'],
          report.lowStockItems
              .map((i) => [
                    i.productName,
                    i.categoryName,
                    i.currentStock.toString(),
                    i.threshold.toString(),
                  ])
              .toList(),
        );
      default:
        return (null, null);
    }
  }
}
