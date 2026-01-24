import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../dashboard/presentation/widgets/kpi_card.dart';
import '../../../domain/appointment_report.dart';
import '../../controllers/appointment_report_controller.dart';
import '../charts/bar_chart_widget.dart';
import '../charts/line_chart_widget.dart';
import '../charts/pie_chart_widget.dart';

/// View displaying the appointment report with charts and tables.
class AppointmentReportView extends ConsumerWidget {
  const AppointmentReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(appointmentReportProvider);

    return reportAsync.when(
      data: (report) => _buildContent(context, report),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading appointment report: $error'),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppointmentReport report) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI Cards
          _buildKpiSection(context, report),
          const SizedBox(height: 24),

          // Appointments Trend Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LineChartWidget(
                title: 'Appointments per Day',
                spots: report.appointmentsByDay.asMap().entries.map((entry) {
                  return FlSpot(
                    entry.key.toDouble(),
                    entry.value.count.toDouble(),
                  );
                }).toList(),
                xLabels: report.appointmentsByDay.map((r) {
                  return DateFormat('MMM d').format(r.date);
                }).toList(),
                height: 250,
                lineColor: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Charts Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Pie Chart
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: PieChartWidget(
                      title: 'Appointments by Status',
                      data: report.appointmentsByStatus.map(
                        (k, v) => MapEntry(k, v),
                      ),
                      height: 200,
                      colors: const [
                        Color(0xFF4CAF50), // Completed - Green
                        Color(0xFF2196F3), // Scheduled - Blue
                        Color(0xFFF44336), // Missed - Red
                        Color(0xFF9E9E9E), // Cancelled - Grey
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Purpose Bar Chart
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BarChartWidget(
                      title: 'Appointments by Purpose',
                      data: report.appointmentsByPurpose.map(
                        (k, v) => MapEntry(k, v),
                      ),
                      height: 200,
                      barColor: Colors.indigo,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Completion Rate Card
          _buildCompletionRateCard(context, report),
        ],
      ),
    );
  }

  Widget _buildKpiSection(BuildContext context, AppointmentReport report) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        KpiCard(
          title: 'Total Appointments',
          value: report.totalAppointments.toString(),
          icon: Icons.calendar_today,
          color: Colors.indigo,
          compact: true,
        ),
        KpiCard(
          title: 'Completed',
          value: report.completedCount.toString(),
          icon: Icons.check_circle,
          color: Colors.green,
          compact: true,
        ),
        KpiCard(
          title: 'Scheduled',
          value: report.scheduledCount.toString(),
          icon: Icons.schedule,
          color: Colors.blue,
          compact: true,
        ),
        KpiCard(
          title: 'Missed',
          value: report.missedCount.toString(),
          icon: Icons.cancel,
          color: Colors.red,
          compact: true,
        ),
      ],
    );
  }

  Widget _buildCompletionRateCard(
      BuildContext context, AppointmentReport report) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Rates',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            _buildRateRow(
              context,
              'Completion Rate',
              report.completionRate,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildRateRow(
              context,
              'Miss Rate',
              report.missRate,
              Colors.red,
            ),
            const SizedBox(height: 12),
            _buildRateRow(
              context,
              'Cancellation Rate',
              report.cancellationRate,
              Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRateRow(
    BuildContext context,
    String label,
    double rate,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: rate / 100,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 50,
          child: Text(
            '${rate.toStringAsFixed(1)}%',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
