extension OptionalStringExtension on String? {
  String optional({String placeholder = '-', bool checkNullString = false}) {
    if(checkNullString) {
      if(this == '') return placeholder;
      if(this == 'null') return placeholder;
      if(this == null) return placeholder;
    }
    if (this == null) return placeholder;
    if (this!.isEmpty) return placeholder;
    return this!;
  }

  String capitalize() => '${this![0].toUpperCase()}${this!.substring(1)}';

  String toProperCase() {
    if (this == null) return '';
    return this!.split(' ').map((e) => e.capitalize()).join(' ');
  }

  ///
  /// Enclose [this] with [open] and [close]
  ///
  String enclose(
    String open, {
    String? close,
    bool skipIfEmpty = false,
  }) {
    if (this == null) return '';
    final value = this!;

    if (skipIfEmpty && value.isEmpty) {
      return '';
    }

    final end = close ?? open;
    return '$open$value$end';
  }
}

extension StringExtension on String {
  /// Combines [initial] with any number of additional values in [others],
  /// separated by commas.  If any entry is `null` or empty, it’s skipped.
  String combine({String separator = ',', List<String?>? others}) {
    // start with the initial value if it’s non-empty
    final parts = <String>[];
    if (this.isNotEmpty) parts.add(this);

    // append each non-null, non-empty other
    for (final other in (others ?? [])) {
      if (other != null && other.isNotEmpty) {
        parts.add(other);
      }
    }

    return parts.join(separator);
  }
}
