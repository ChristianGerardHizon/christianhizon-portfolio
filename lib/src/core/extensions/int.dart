extension IntOptionalExtension on int? {
  int orZero() => this ?? 0;
  String optional({String placeholder = ''}) {
    if (this == null) return placeholder;
    return this!.toString();
  }
}
