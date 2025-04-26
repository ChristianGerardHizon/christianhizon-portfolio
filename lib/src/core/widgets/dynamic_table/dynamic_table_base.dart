import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SliverDynamicBase extends HookConsumerWidget {
  final int itemCount;
  final List<DynamicTableBaseColumn> columns;
  final double tableRowHeight;
  final Widget? Function(
    BuildContext context,
    _DynamicTableBuilderValue value,
  ) tableRowBuilder;
  final Widget Function(
    BuildContext context,
    _DynamicTableBuilderValue value,
  ) mobileBuilder;
  final String tableKey;
  final Function(int index)? onTableRowTap;

  const SliverDynamicBase({
    super.key,
    required this.itemCount,
    required this.columns,
    required this.tableRowHeight,
    required this.tableRowBuilder,
    required this.mobileBuilder,
    required this.tableKey,
    this.onTableRowTap,
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
      DynamicTableBaseColumn(
        width: 60,
        freezePriority: 1,
        builder: (context, index) => Checkbox(
            tristate: true,
            value: itemCount == 0
                ? false
                : selectedRows.length == itemCount
                    ? true
                    : selectedRows.isNotEmpty
                        ? null
                        : false,
            onChanged: (x) {
              if (x == true) {
                notifier.toggleRow(itemCount);
              } else {
                notifier.clearSelection();
              }
            }),
      ),
      ...columns
    ];

    ///
    /// Mobile View
    ///
    if (isMobile) {
      return SliverMainAxisGroup(slivers: [
        SliverList.builder(
          itemCount: itemCount,
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
        )
      ]);
    }

    ///
    /// Table
    ///
    return SliverTableView.builder(
      rowHeight: tableRowHeight,
      rowCount: itemCount,
      rowBuilder: (context, rowIndex, builder) {
        return InkWell(
          onTap: () => onTableRowTap?.call(rowIndex),
          child: builder(
            context,
            (_, columnIndex) {
              if (columnIndex == 0)
                return Checkbox(
                  value: selectedRows.contains(rowIndex),
                  onChanged: (x) => notifier.toggleRow(rowIndex),
                );
              final widget = tableRowBuilder(
                context,
                _DynamicTableBuilderValue(
                  row: rowIndex,
                  column: columnIndex,
                  isSelected: selectedRows.contains(rowIndex),
                ),
              );

              return widget ?? SizedBox();
            },
          ),
        );
      },
      headerBuilder: (context, contentBuilder) {
        return contentBuilder(
          context,
          (context, index) => tableColumns[index].builder(context, index),
        );
      },
      columns: tableColumns
          .map(
            (col) => TableColumn(
              width: col.width,
              freezePriority: col.freezePriority,
            ),
          )
          .toList(),
    );
  }
}

class DynamicTableBaseColumn {
  final double width;
  final String? key;
  final int freezePriority;
  final Widget Function(BuildContext context, int row) builder;

  DynamicTableBaseColumn({
    required this.width,
    this.key,
    this.freezePriority = 0,
    required this.builder,
  });
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
