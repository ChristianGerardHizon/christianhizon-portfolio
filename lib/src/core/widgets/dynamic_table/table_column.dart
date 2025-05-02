import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';

part 'table_column.mapper.dart';

@MappableClass()
class TableColumn<T> with TableColumnMappable {
  final String? sortKey;
  final String header;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final TextStyle? style;

  /// Width of a column in a logical pixels.
  final double width;

  /// Priority of a column to be frozen on a screen instead of scrolling off.
  /// The larger the priority the more likely this column is to remain frozen
  /// in case of lacking space to freeze all the required columns. If zero,
  /// the column will never be frozen.
  final int freezePriority;

  /// When set to true, frozen column will be scrolled of the edge of the screen
  /// but will come back upon scrolling in the other direction.
  final bool sticky;

  /// When set higher than zero, column will expand to fill the remaining
  /// width in proportion to the total flex of all columns.
  final int flex;

  /// Horizontal (x) translation of the column. Does not affect the layout
  /// of other columns. Primarily used for animations.
  final double translation;

  /// Minimum width the column is allowed to resize to.
  final double? minResizeWidth;

  /// Maximum width the column is allowed to resize to.
  final double? maxResizeWidth;

  final Widget Function(
    BuildContext context,
    T data,
    int row,
    int column,
  )? builder;

  const TableColumn({
    this.sticky = false,
    this.flex = 0,
    this.translation = 0,
    this.minResizeWidth,
    this.maxResizeWidth,
    this.freezePriority = 0,
    this.sortKey,
    required this.header,
    this.width = 100,
    this.builder,
    this.style,
    this.alignment,
    this.padding,
  });
}
