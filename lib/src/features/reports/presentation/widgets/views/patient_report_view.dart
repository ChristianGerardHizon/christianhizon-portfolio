import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../dashboard/presentation/widgets/kpi_card.dart';
import '../../../domain/patient_report.dart';
import '../../controllers/patient_report_controller.dart';
import '../charts/line_chart_widget.dart';
import '../charts/pie_chart_widget.dart';

/// View displaying the patient report with charts and tables.
class PatientReportView extends ConsumerWidget {
  const PatientReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(patientReportProvider);

    return reportAsync.when(
      data: (report) => _buildContent(context, report),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading patient report: $error'),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PatientReport report) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI Cards
          _buildKpiSection(context, report),
          const SizedBox(height: 24),

          // Registration Trend Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LineChartWidget(
                title: 'New Registrations',
                spots: report.registrationsByDay.asMap().entries.map((entry) {
                  return FlSpot(
                    entry.key.toDouble(),
                    entry.value.count.toDouble(),
                  );
                }).toList(),
                xLabels: report.registrationsByDay.map((r) {
                  return DateFormat('MMM d').format(r.date);
                }).toList(),
                height: 250,
                lineColor: Colors.teal,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Charts Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Species Pie Chart
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: PieChartWidget(
                      title: 'Patients by Species',
                      data: report.patientsBySpecies.map(
                        (k, v) => MapEntry(k, v),
                      ),
                      height: 200,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Sex Pie Chart
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: PieChartWidget(
                      title: 'Patients by Sex',
                      data: report.patientsBySex.map(
                        (k, v) => MapEntry(k, v),
                      ),
                      height: 200,
                      colors: const [
                        Color(0xFF2196F3), // Male - Blue
                        Color(0xFFE91E63), // Female - Pink
                        Color(0xFF9E9E9E), // Unknown - Grey
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiSection(BuildContext context, PatientReport report) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        KpiCard(
          title: 'Total Patients',
          value: report.totalPatients.toString(),
          icon: Icons.pets,
          color: Colors.teal,
          compact: true,
        ),
        KpiCard(
          title: 'New in Period',
          value: report.newPatientsInPeriod.toString(),
          icon: Icons.person_add,
          color: Colors.blue,
          compact: true,
        ),
        KpiCard(
          title: 'Species Count',
          value: report.patientsBySpecies.length.toString(),
          icon: Icons.category,
          color: Colors.purple,
          compact: true,
        ),
      ],
    );
  }
}
