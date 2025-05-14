export 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_base_column.dart'
    show DynamicTableBaseColumn;
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_base_column.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:responsive_builder/responsive_builder.dart'
    show getValueForScreenType;

class DynamicTableBase extends HookConsumerWidget {
  final int itemCount;
  final List<DynamicTableBaseColumn> columns;
  final double tableRowHeight;
  final Widget? Function(
    BuildContext context,
    _DynamicTableBuilderValue value,
    bool showCheckbox,
  ) tableRowBuilder;
  final Widget Function(
    BuildContext context,
    _DynamicTableBuilderValue value,
  ) mobileBuilder;
  final String tableKey;
  final Function(int index)? onTableRowTap;
  final bool showCheckbox;
  final ScrollPhysics? physics;
  final bool shrinkWrapHorizontal;
  final bool shrinkWrapVertical;

  const DynamicTableBase({
    super.key,
    this.showCheckbox = true,
    required this.itemCount,
    required this.columns,
    required this.tableRowHeight,
    required this.tableRowBuilder,
    required this.mobileBuilder,
    required this.tableKey,
    this.onTableRowTap,
    this.physics,
    this.shrinkWrapHorizontal = false,
    this.shrinkWrapVertical = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = tableControllerProvider(tableKey);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final selectedRows = state.selected;

    final isMobile = getValueForScreenType(
      context: context,
      mobile: true,
      desktop: false,
      tablet: false,
      watch: true,
    );

    final tableColumns = [
      if (showCheckbox)
        DynamicTableBaseColumn.sticky(
          width: 60,
          freezePriority: 1,
          builder: (context, index) => Checkbox(
            tristate: true,
            value: selectedRows.isNotEmpty
                ? selectedRows.length == itemCount
                    ? true
                    : null
                : false,
            onChanged: (x) {
              if (x == true) {
                notifier.selectAll();
              } else {
                notifier.clearSelection();
              }
            },
          ),
        ),
      ...columns
    ];

    if (isMobile) {
      return ListView.builder(
        itemCount: itemCount,
        physics: physics,
        shrinkWrap: shrinkWrapVertical,
        itemBuilder: (context, index) {
          return mobileBuilder(
            context,
            _DynamicTableBuilderValue(
              row: index,
              column: 0,
              isSelected: selectedRows.contains(index),
            ),
          );
        },
      );
    }

    return TableView.builder(
      rowCount: itemCount,
      rowHeight: tableRowHeight,
      columns: tableColumns
          .map(
            (col) => TableColumn(
              width: col.width,
              flex: col.flex,
              maxResizeWidth: col.maxResizeWidth,
              minResizeWidth: col.minResizeWidth,
              freezePriority: col.freezePriority,
              translation: col.translation,
              sticky: col.sticky,
            ),
          )
          .toList(),
      rowBuilder: (context, rowIndex, builder) {
        return InkWell(
          onTap: () => onTableRowTap?.call(rowIndex),
          child: builder(context, (_, columnIndex) {
            if (columnIndex == 0 && showCheckbox) {
              return Checkbox(
                value: selectedRows.contains(rowIndex),
                onChanged: (_) => notifier.toggleRow(rowIndex),
              );
            }

            final widget = tableRowBuilder(
                context,
                _DynamicTableBuilderValue(
                  row: rowIndex,
                  column: columnIndex,
                  isSelected: selectedRows.contains(rowIndex),
                ),
                showCheckbox);

            return widget ?? const SizedBox();
          }),
        );
      },
      headerBuilder: (context, contentBuilder) {
        return contentBuilder(
          context,
          (context, index) => tableColumns[index].builder(context, index),
        );
      },
      physics: physics,
      shrinkWrapHorizontal: shrinkWrapHorizontal,
      shrinkWrapVertical: shrinkWrapVertical,
    );
  }
}

class _DynamicTableBuilderValue {
  final int row;
  final int column;
  final bool isSelected;

  _DynamicTableBuilderValue({
    required this.row,
    required this.column,
    this.isSelected = false,
  });
}
