import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/header_key.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/sliver_dynamic_base_list.dart';

part 'table_column.mapper.dart';

@MappableClass()
class TableColumn<T> with TableColumnMappable {
  final String header;
  final double width;

  final Alignment? alignment;

  final EdgeInsets? padding;

  final TextStyle? style;

  final Widget Function(
    BuildContext context,
    T data,
    DynamicTableBuilderValue extra,
  )? builder;

  const TableColumn({
    required this.header,
    this.width = 100,
    this.builder,
    this.style,
    this.alignment,
    this.padding,
  });
}
