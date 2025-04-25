import 'package:dart_mappable/dart_mappable.dart';

part 'table_sort.mapper.dart';

@MappableClass()
class TableSort with TableSortMappable {
  final String key;
  final bool isAscending;

  TableSort({
    required this.key,
    required this.isAscending,
  });

  TableSort reverse() => TableSort(key: key, isAscending: !isAscending);

  String get value => '$key${isAscending ? '+' : '-'}';

  static fromMap(Map<String, dynamic> raw) {
    return TableSortMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = TableSortMapper.fromMap;
}
