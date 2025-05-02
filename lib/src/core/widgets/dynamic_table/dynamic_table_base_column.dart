import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';

part 'dynamic_table_base_column.mapper.dart';

@MappableClass(ignoreNull: true)
class DynamicTableBaseColumn with DynamicTableBaseColumnMappable {
  final String? key;

  /// Width of a column in logical pixels.
  final double width;

  /// Priority of a column to be frozen.
  final int freezePriority;

  /// Whether frozen column is sticky (returns upon scroll back).
  final bool sticky;

  /// Column's flex growth.
  final int flex;

  /// Horizontal translation of the column.
  final double translation;

  /// Minimum resizable width.
  final double? minResizeWidth;

  /// Maximum resizable width.
  final double? maxResizeWidth;

  /// Cell builder.
  final Widget Function(BuildContext context, int row) builder;

  const DynamicTableBaseColumn({
    required this.width,
    this.key,
    this.freezePriority = 0,
    this.sticky = false,
    this.flex = 0,
    this.translation = 0,
    this.minResizeWidth,
    this.maxResizeWidth,
    required this.builder,
  }) : assert(
          freezePriority != 0 || !sticky,
          'A column can only be sticky if it is freezable',
        );

  /// Factory constructor for sticky columns with rule enforcement.
  factory DynamicTableBaseColumn.sticky({
    required double width,
    String? key,
    required int freezePriority,
    int flex = 0,
    double translation = 0,
    double? minResizeWidth,
    double? maxResizeWidth,
    required Widget Function(BuildContext context, int row) builder,
  }) {
    assert(
      freezePriority != 0,
      'Sticky columns must have freezePriority greater than 0. '
      'Use the regular constructor if you do not want the column to be freezable.',
    );
    return DynamicTableBaseColumn(
      width: width,
      key: key,
      freezePriority: freezePriority,
      sticky: true,
      flex: flex,
      translation: translation,
      minResizeWidth: minResizeWidth,
      maxResizeWidth: maxResizeWidth,
      builder: builder,
    );
  }
}
