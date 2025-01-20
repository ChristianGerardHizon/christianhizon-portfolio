extension StringExtension on String? {
  String optional({String placeholder = '-'}) {
    if (this == null) return placeholder;
    if (this!.isEmpty) return placeholder;
    return this!;
  }
}
