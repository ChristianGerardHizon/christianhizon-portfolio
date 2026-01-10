import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';

part 'dynamic_table_column.mapper.dart';

@MappableClass()
class DynamicTableColumn<T> with DynamicTableColumnMappable {
  final String? sortKey;
  final String header;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final TextStyle? style;

  /// Width of a column in logical pixels.
  final double width;

  /// Flex grow of column.
  final int flex;

  /// X translation of the column.
  final double translation;

  /// Minimum resizable width.
  final double? minResizeWidth;

  /// Maximum resizable width.
  final double? maxResizeWidth;

  /// Optional cell builder.
  final Widget Function(
    BuildContext context,
    T data,
    int row,
    int column,
  )? builder;

  // Private internal state
  final bool _isSticky;
  final int? _freezePriority;

  /// Read-only access to sticky state
  bool get sticky => _isSticky;

  /// Read-only freeze priority (0 if not sticky)
  int get freezePriority => _freezePriority ?? 0;

  /// Default non-sticky constructor
  const DynamicTableColumn({
    required this.header,
    this.sortKey,
    this.alignment,
    this.padding,
    this.style,
    this.width = 100,
    this.flex = 0,
    this.translation = 0,
    this.minResizeWidth,
    this.maxResizeWidth,
    this.builder,
  })  : _isSticky = false,
        _freezePriority = null;

  /// Named constructor for sticky columns
  factory DynamicTableColumn.sticky({
    required String header,
    required int freezePriority,
    double width = 100,
    int flex = 0,
    double translation = 0,
    double? minResizeWidth,
    double? maxResizeWidth,
    String? sortKey,
    Alignment? alignment,
    EdgeInsets? padding,
    TextStyle? style,
    Widget Function(BuildContext context, T data, int row, int column)? builder,
  }) {
    assert(
      freezePriority > 0,
      'Sticky columns must have freezePriority greater than 0. '
      'Use the default constructor if sticky behavior is not required.',
    );

    return DynamicTableColumn._internal(
      header: header,
      isSticky: true,
      freezePriority: freezePriority,
      sortKey: sortKey,
      alignment: alignment,
      padding: padding,
      style: style,
      width: width,
      flex: flex,
      translation: translation,
      minResizeWidth: minResizeWidth,
      maxResizeWidth: maxResizeWidth,
      builder: builder,
    );
  }

  /// Internal constructor shared by sticky
  const DynamicTableColumn._internal({
    required this.header,
    required bool isSticky,
    required int? freezePriority,
    this.sortKey,
    this.alignment,
    this.padding,
    this.style,
    this.width = 100,
    this.flex = 0,
    this.translation = 0,
    this.minResizeWidth,
    this.maxResizeWidth,
    this.builder,
  })  : _isSticky = isSticky,
        _freezePriority = freezePriority;
}
