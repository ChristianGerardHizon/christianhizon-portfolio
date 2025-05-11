class PocketbaseFilter {
  final String? _baseFilter;
  final String? _filter;

  // private ctor
  const PocketbaseFilter._(this._baseFilter, this._filter);

  /// Start a chain, optionally with an existing base filter.
  factory PocketbaseFilter({String? baseFilter}) =>
      PocketbaseFilter._(baseFilter, null);

  /// name ~ "query"
  PocketbaseFilter searchName(String? query, {String field = 'name'}) {
    final clause =
        (query != null && query.isNotEmpty) ? '$field ~ "$query"' : null;
    return PocketbaseFilter._(_baseFilter, _combine(_filter, clause));
  }

  /// field = "query"
  PocketbaseFilter equal(String query, {String field = 'name'}) {
    final clause = '$field = "$query"';
    return PocketbaseFilter._(_baseFilter, _combine(_filter, clause));
  }

  /// f1 == "query" || f2 == "query" || …
  PocketbaseFilter searchFields(String? query, {required List<String> fields}) {
    if (query == null || query.isEmpty) return this;
    final clause = fields.map((f) => '$f = "$query"').join(' || ');
    return PocketbaseFilter._(_baseFilter, _combine(_filter, clause));
  }

  /// f1 == "query" || f2 == "query" || …
  PocketbaseFilter wildCardFields(String? query,
      {required List<String> fields}) {
    if (query == null || query.isEmpty) return this;
    final clause = fields.map((f) => '$f  ~ "$query"').join(' || ');
    return PocketbaseFilter._(_baseFilter, _combine(_filter, clause));
  }

  PocketbaseFilter searchField(String query, {required String field}) {
    final clause = '$field = "$query"';
    return PocketbaseFilter._(_baseFilter, _combine(_filter, clause));
  }

  /// Produce the final filter string (or null if nothing).
  String? build() => _combine(_filter, _baseFilter)?.trim();

  @override
  String toString() => build() ?? '';

  /// Helper to join two clauses with '&&' if both exist.
  static String? _combine(String? a, String? b) {
    if (a == null || a.isEmpty) return b;
    if (b == null || b.isEmpty) return a;
    return '$a && $b';
  }
}
