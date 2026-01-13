/// Enum for patient detail page tabs.
enum PatientTab {
  overview,
  details,
  records,
  treatments,
  appointments,
  files;

  /// Parse a tab name string to PatientTab, defaults to overview.
  static PatientTab fromString(String? name) {
    return PatientTab.values.firstWhere(
      (tab) => tab.name == name,
      orElse: () => PatientTab.overview,
    );
  }
}
