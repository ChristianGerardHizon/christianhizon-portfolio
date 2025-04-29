extension StringExtension on String? {
  String optional({String placeholder = '-'}) {
    if (this == null) return placeholder;
    if (this!.isEmpty) return placeholder;
    return this!;
  }

  String capitalize() => '${this![0].toUpperCase()}${this!.substring(1)}';

  String toProperCase() {
    if (this == null) return '';
    return this!.split(' ').map((e) => e.capitalize()).join(' ');
  }
}
