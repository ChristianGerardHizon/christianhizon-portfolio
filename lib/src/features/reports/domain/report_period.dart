import 'package:dart_mappable/dart_mappable.dart';

part 'report_period.mapper.dart';

/// Time period options for reports.
@MappableEnum()
enum ReportPeriod {
  weekly,
  monthly,
  yearly,
  allTime;

  /// Display name for the period.
  String get displayName {
    switch (this) {
      case ReportPeriod.weekly:
        return 'Week';
      case ReportPeriod.monthly:
        return 'Month';
      case ReportPeriod.yearly:
        return 'Year';
      case ReportPeriod.allTime:
        return 'All Time';
    }
  }

  /// Returns the start date for this period relative to now.
  DateTime get startDate {
    final now = DateTime.now();
    switch (this) {
      case ReportPeriod.weekly:
        return DateTime(now.year, now.month, now.day - 7);
      case ReportPeriod.monthly:
        return DateTime(now.year, now.month - 1, now.day);
      case ReportPeriod.yearly:
        return DateTime(now.year - 1, now.month, now.day);
      case ReportPeriod.allTime:
        return DateTime(2000);
    }
  }

  /// Returns the end date (now).
  DateTime get endDate => DateTime.now();

  /// Returns the number of days in this period.
  int get dayCount {
    switch (this) {
      case ReportPeriod.weekly:
        return 7;
      case ReportPeriod.monthly:
        return 30;
      case ReportPeriod.yearly:
        return 365;
      case ReportPeriod.allTime:
        return DateTime.now().difference(DateTime(2000)).inDays;
    }
  }
}
