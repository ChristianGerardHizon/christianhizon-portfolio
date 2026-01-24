import 'package:dart_mappable/dart_mappable.dart';

part 'treatment_plan_report.mapper.dart';

/// Aggregated treatment plan data for a time period.
@MappableClass()
class TreatmentPlanReport with TreatmentPlanReportMappable {
  const TreatmentPlanReport({
    required this.totalPlans,
    required this.activePlans,
    required this.completedPlans,
    required this.abandonedPlans,
    required this.averageProgressPercentage,
    required this.plansByStatus,
    required this.plansByTreatmentType,
    required this.overdueItemsCount,
  });

  final int totalPlans;
  final int activePlans;
  final int completedPlans;
  final int abandonedPlans;

  /// Average progress across all active plans (0-100).
  final double averageProgressPercentage;

  /// Plans by status (for pie chart).
  final Map<String, int> plansByStatus;

  /// Plans by treatment type (for bar chart).
  final Map<String, int> plansByTreatmentType;

  /// Number of overdue treatment plan items.
  final int overdueItemsCount;

  /// Completion rate.
  double get completionRate {
    if (totalPlans == 0) return 0;
    return (completedPlans / totalPlans) * 100;
  }

  /// Abandonment rate.
  double get abandonmentRate {
    if (totalPlans == 0) return 0;
    return (abandonedPlans / totalPlans) * 100;
  }

  /// Empty report for initial/error states.
  static const empty = TreatmentPlanReport(
    totalPlans: 0,
    activePlans: 0,
    completedPlans: 0,
    abandonedPlans: 0,
    averageProgressPercentage: 0,
    plansByStatus: {},
    plansByTreatmentType: {},
    overdueItemsCount: 0,
  );
}
