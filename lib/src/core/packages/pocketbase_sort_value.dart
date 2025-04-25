import 'package:dart_mappable/dart_mappable.dart';

part 'pocketbase_sort_value.mapper.dart';

@MappableClass()
class PocketbaseSortValue with PocketbaseSortValueMappable {
  final String sortKey;
  final bool isAsc;

  PocketbaseSortValue({
    required this.sortKey,
    required this.isAsc,
  });

  String? get value => isAsc ? '$sortKey+' : '$sortKey-';

  PocketbaseSortValue reverse() =>
      PocketbaseSortValue(sortKey: sortKey, isAsc: !isAsc);

  static fromMap(Map<String, dynamic> raw) {
    return PocketbaseSortValueMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PocketbaseSortValueMapper.fromMap;
}
