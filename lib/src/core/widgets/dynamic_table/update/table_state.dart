import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/table_sort.dart';

part 'table_state.mapper.dart';

@MappableClass()
class TableState<T> with TableStateMappable {
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

  TableState({
    this.page = 1,
    this.pageSize = 10,
    this.totalItems = 0,
    this.totalPages = 1,
    this.hasNext = false,
    this.isLoading = false,
    this.selected = const [],
    this.isMobile = false,
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
