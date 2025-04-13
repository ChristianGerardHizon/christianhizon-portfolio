import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/header_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DynamicTableColumn {
  final double width;
  final int freezePriority;
  final Widget Function(BuildContext context, int row) builder;

  DynamicTableColumn({
    required this.width,
    this.freezePriority = 0,
    required this.builder,
  });
}

class DynamicTableBuilderValue {
  final int row;
  final int column;
  final bool isSelected;

  DynamicTableBuilderValue({
    required this.row,
    required this.column,
    this.isSelected = false,
  });
}

class DynamicTableController extends ChangeNotifier {
  List<int> _selected = [];

  List<int> get selected => _selected;

  HeaderKey? _headerKey;

  set updateHeaderKey(HeaderKey? value) {
    _headerKey = value;
    notifyListeners();
  }

  tooggleHeaderKey(HeaderKey? value) {
    final isAsc = !(value?.isAscending ?? false);
    _headerKey = HeaderKey(key: value!.key, isAscending: isAsc);
    notifyListeners();
  }

  HeaderKey? get headerKey => _headerKey;

  set selected(List<int> value) {
    _selected = value;
    notifyListeners();
  }

  void toggle(int index) {
    if (_selected.contains(index)) {
      _selected.remove(index);
    } else {
      _selected.add(index);
    }
    notifyListeners();
  }

  void clear() {
    _selected = [];
    notifyListeners();
  }

  void selectAll(int itemCount) {
    _selected = List.generate(itemCount, (index) => index);
    notifyListeners();
  }

  void select(int index) {
    if (!_selected.contains(index)) {
      _selected.add(index);
      notifyListeners();
    }
  }

  bool isSelected(int index) => _selected.contains(index);

  /// NEW: Call this whenever itemCount changes
  void trimSelection(int itemCount) {
    final trimmed = _selected.where((i) => i < itemCount).toList();
    if (trimmed.length != _selected.length) {
      _selected = trimmed;
      notifyListeners();
    }
  }
}

class SliverDynamicBaseList extends HookConsumerWidget {
  final int itemCount;
  final List<DynamicTableColumn> columns;
  final double tableRowHeight;
  final Widget? Function(
    BuildContext context,
    DynamicTableBuilderValue value,
  ) tableRowBuilder;
  final Widget Function(BuildContext context, DynamicTableBuilderValue value)
      mobileBuilder;
  final DynamicTableController controller;
  final Function(int index)? onTableRowTap;

  const SliverDynamicBaseList({
    super.key,
    required this.itemCount,
    required this.columns,
    required this.tableRowHeight,
    required this.tableRowBuilder,
    required this.mobileBuilder,
    required this.controller,
    this.onTableRowTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.trimSelection(itemCount); // Keep selection valid
    useListenable(controller);

    final isMobile = getValueForScreenType(
      context: context,
      mobile: true,
      desktop: false,
      tablet: false,
      watch: true,
    );

    final tableColumns = [
      DynamicTableColumn(
        width: 60,
        freezePriority: 1,
        builder: (context, index) => Checkbox(
            tristate: true,
            value: itemCount == 0
                ? false
                : controller.selected.length == itemCount
                    ? true
                    : controller.selected.isNotEmpty
                        ? null
                        : false,
            onChanged: (x) {
              if (x == true) {
                controller.selectAll(itemCount);
              } else {
                controller.clear();
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
              DynamicTableBuilderValue(
                row: index,
                column: 0,
                isSelected: controller.isSelected(index),
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
                  value: controller.isSelected(rowIndex),
                  onChanged: (x) => controller.toggle(rowIndex),
                );
              final widget = tableRowBuilder(
                context,
                DynamicTableBuilderValue(
                  row: rowIndex,
                  column: columnIndex,
                  isSelected: controller.isSelected(rowIndex),
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
