import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/report_period.dart';

part 'report_period_controller.g.dart';

/// Manages the currently selected report period across all reports.
@Riverpod(keepAlive: true)
class ReportPeriodController extends _$ReportPeriodController {
  @override
  ReportPeriod build() => ReportPeriod.monthly;

  void setPeriod(ReportPeriod period) {
    state = period;
  }
}
