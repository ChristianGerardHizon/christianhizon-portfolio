/// Enum for user detail page tabs.
enum UserTab {
  overview,
  details,
  permissions;

  /// Parse a tab name string to UserTab, defaults to overview.
  static UserTab fromString(String? name) {
    return UserTab.values.firstWhere(
      (tab) => tab.name == name,
      orElse: () => UserTab.overview,
    );
  }
}
