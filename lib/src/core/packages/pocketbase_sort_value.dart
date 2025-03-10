class PocketbaseSortValue {
  final String sortKey;
  final bool isAsc;

  PocketbaseSortValue({required this.sortKey, required this.isAsc});

  String get value => isAsc ? sortKey : '-$sortKey';
}
