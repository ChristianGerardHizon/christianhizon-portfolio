class PocketbaseFilter {
  final String? baseFilter;

  PocketbaseFilter({this.baseFilter});

  String? searchName(String? query, {String field = 'name'}) {
    final result =
        query != null && query.isNotEmpty ? '$field ~ "$query"' : null;
    return _combineFilter(result, baseFilter: baseFilter);
  }

  String? searchFields(String query, {required List<String> fields}) {
    final result = fields.map((f) => '$f == "$query"').join(' || ');
    return _combineFilter(result, baseFilter: baseFilter);
  }

  String? _combineFilter(String? filter, {String? baseFilter}) {
    if (filter == null || filter.isEmpty) return baseFilter;
    if (baseFilter == null || baseFilter.isEmpty) return filter;
    return '$filter && $baseFilter';
  }
}
