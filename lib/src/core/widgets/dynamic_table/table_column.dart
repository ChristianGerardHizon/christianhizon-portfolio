import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';

part 'table_column.mapper.dart';

@MappableClass()
class TableColumn<T> with TableColumnMappable {
  final String header;
  final double width;
  final String? sortKey;

  final Alignment? alignment;

  final EdgeInsets? padding;

  final TextStyle? style;

  final Widget Function(
    BuildContext context,
    T data,
    int row,
    int column,
  )? builder;

  const TableColumn({
    this.sortKey,
    required this.header,
    this.width = 100,
    this.builder,
    this.style,
    this.alignment,
    this.padding,
  });
}
