/// Enum for patient detail page tabs.
enum PatientTab {
  details,
  records,
  treatments,
  appointments,
  files;

  /// Parse a tab name string to PatientTab, defaults to details.
  static PatientTab fromString(String? name) {
    return PatientTab.values.firstWhere(
      (tab) => tab.name == name,
      orElse: () => PatientTab.details,
    );
  }
}
