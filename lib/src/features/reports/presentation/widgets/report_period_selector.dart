import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/report_period.dart';
import '../controllers/report_period_controller.dart';

/// Widget for selecting the report time period.
class ReportPeriodSelector extends ConsumerWidget {
  const ReportPeriodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(reportPeriodControllerProvider);

    return SegmentedButton<ReportPeriod>(
      segments: ReportPeriod.values.map((period) {
        return ButtonSegment<ReportPeriod>(
          value: period,
          label: Text(period.displayName),
        );
      }).toList(),
      selected: {selectedPeriod},
      onSelectionChanged: (Set<ReportPeriod> selection) {
        ref
            .read(reportPeriodControllerProvider.notifier)
            .setPeriod(selection.first);
      },
    );
  }
}
