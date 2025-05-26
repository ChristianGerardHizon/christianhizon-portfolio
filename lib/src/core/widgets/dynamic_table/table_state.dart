import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_sort.dart';

part 'table_state.mapper.dart';

@MappableClass()
class TableState with TableStateMappable {
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final bool hasNext;
  final bool isLoading;
  final List<int> selected;
  final bool isMobile;
  final TableSort? sort;
  final String? filter;
  final String key;

  TableState({
    required this.key,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.isLoading,
    required this.selected,
    required this.isMobile,
    this.sort,
    this.filter,
  });

  static fromMap(Map<String, dynamic> raw) {
    return TableStateMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = TableStateMapper.fromMap;
}
