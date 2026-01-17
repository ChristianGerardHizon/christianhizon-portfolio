/// Utility extensions and functions for DateTime handling with PocketBase.
///
/// PocketBase stores all dates in UTC. This module provides consistent
/// conversion between local time (used in the UI) and UTC (stored in DB).

/// Extension methods for DateTime to handle UTC/local conversions.
extension PocketBaseDateExtensions on DateTime {
  /// Converts to UTC and returns ISO8601 string for PocketBase storage.
  ///
  /// Use this when sending dates to the server in create/update operations.
  /// Example: `patient.dateOfBirth.toUtcIso8601()`
  String toUtcIso8601() => toUtc().toIso8601String();
}

/// Extension methods for nullable DateTime.
extension PocketBaseDateExtensionsNullable on DateTime? {
  /// Converts to UTC ISO8601 string, or returns null if DateTime is null.
  ///
  /// Safe to use with optional date fields.
  /// Example: `product.expiration.toUtcIso8601OrNull()`
  String? toUtcIso8601OrNull() => this?.toUtc().toIso8601String();
}

/// Parses a date string from PocketBase and converts to local time.
///
/// PocketBase returns dates in UTC format. This function parses the string
/// and converts it to the device's local timezone for display.
///
/// Returns null if the input is null or parsing fails.
///
/// Example:
/// ```dart
/// final localDate = parseToLocal(json['dateOfBirth'] as String?);
/// ```
DateTime? parseToLocal(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return null;
  return DateTime.tryParse(dateStr)?.toLocal();
}

/// Parses a date string and converts to local, with a fallback default value.
///
/// Use when a non-null DateTime is required.
///
/// Example:
/// ```dart
/// final date = parseToLocalOrDefault(json['visitDate'], DateTime.now());
/// ```
DateTime parseToLocalOrDefault(String? dateStr, DateTime defaultValue) {
  return parseToLocal(dateStr) ?? defaultValue;
}
