import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../dashboard/presentation/widgets/kpi_card.dart';
import '../../../domain/treatment_plan_report.dart';
import '../../controllers/treatment_plan_report_controller.dart';
import '../charts/bar_chart_widget.dart';
import '../charts/pie_chart_widget.dart';

/// View displaying the treatment plan report with charts and tables.
class TreatmentPlanReportView extends ConsumerWidget {
  const TreatmentPlanReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(treatmentPlanReportProvider);

    return reportAsync.when(
      data: (report) => _buildContent(context, report),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading treatment plan report: $error'),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TreatmentPlanReport report) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI Cards
          _buildKpiSection(context, report),
          const SizedBox(height: 24),

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
                      title: 'Plans by Status',
                      data: report.plansByStatus.map(
                        (k, v) => MapEntry(k, v),
                      ),
                      height: 220,
                      colors: const [
                        Color(0xFF2196F3), // Active - Blue
                        Color(0xFF4CAF50), // Completed - Green
                        Color(0xFF9E9E9E), // Abandoned - Grey
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Treatment Type Bar Chart
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BarChartWidget(
                      title: 'Plans by Treatment Type',
                      data: report.plansByTreatmentType.map(
                        (k, v) => MapEntry(k, v),
                      ),
                      height: 220,
                      barColor: Colors.cyan,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Rates Card
          _buildRatesCard(context, report),
        ],
      ),
    );
  }

  Widget _buildKpiSection(BuildContext context, TreatmentPlanReport report) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        KpiCard(
          title: 'Total Plans',
          value: report.totalPlans.toString(),
          icon: Icons.assignment,
          color: Colors.cyan,
          compact: true,
        ),
        KpiCard(
          title: 'Active',
          value: report.activePlans.toString(),
          icon: Icons.play_circle,
          color: Colors.blue,
          compact: true,
        ),
        KpiCard(
          title: 'Completed',
          value: report.completedPlans.toString(),
          icon: Icons.check_circle,
          color: Colors.green,
          compact: true,
        ),
        KpiCard(
          title: 'Abandoned',
          value: report.abandonedPlans.toString(),
          icon: Icons.cancel,
          color: Colors.grey,
          compact: true,
        ),
        KpiCard(
          title: 'Overdue Items',
          value: report.overdueItemsCount.toString(),
          icon: Icons.warning,
          color: Colors.orange,
          compact: true,
        ),
      ],
    );
  }

  Widget _buildRatesCard(BuildContext context, TreatmentPlanReport report) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Treatment Plan Rates',
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
              'Abandonment Rate',
              report.abandonmentRate,
              Colors.grey,
            ),
            const SizedBox(height: 12),
            _buildRateRow(
              context,
              'Average Progress',
              report.averageProgressPercentage,
              Colors.blue,
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
