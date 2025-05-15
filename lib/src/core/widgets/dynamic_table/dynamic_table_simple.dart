import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_base.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_sort.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef MobileBuilderFunc<T> = Widget Function(
  BuildContext context,
  int index,
  T data,
  bool selected,
);

class DynamicTableSimple<T> extends HookConsumerWidget {
  final String tableKey;
  final List<T> items;
  final Widget? error;
  final Function(int, TableSort?)? onChange;
  final Function(T)? onRowTap;
  final List<DynamicTableColumn<T>> columns;
  final TextStyle? headerTextStyle;
  final MobileBuilderFunc<T> mobileBuilder;
  final bool hidePageController;
  final bool showMore;
  final Function()? onShowMore;

  const DynamicTableSimple({
    super.key,
    required this.tableKey,
    required this.items,
    this.error,
    this.onChange,
    this.onRowTap,
    required this.columns,
    this.headerTextStyle,
    required this.mobileBuilder,
    this.hidePageController = false,
    this.showMore = false,
    this.onShowMore,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = tableControllerProvider(tableKey);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    useEffect(() {
      return null;
    }, []);

    final selected = state.selected;
    final sort = state.sort;
    final currentPage = state.page;

    return Column(
      children: [
        ///
        /// on error
        ///
        if (error is Widget) error!,

        ///
        ///  Content
        ///
        if (error == null && items.isNotEmpty)
          DynamicTableBase(
            showCheckbox: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrapVertical: true,
            tableKey: tableKey,
            itemCount: items.length,

            onTableRowTap: (index) {
              final isSelected = selected.contains(index);
              if (!isSelected && selected.isNotEmpty) {
                notifier.toggleRow(index);
                return;
              }
              if (isSelected) {
                notifier.toggleRow(index);
                return;
              }

              onRowTap?.call(items[index]);
            },

            ///
            /// Table Columns
            ///
            columns: columns
                .map(
                  (column) => DynamicTableBaseColumn(
                    key: column.sortKey,
                    width: column.width,
                    flex: column.flex,
                    maxResizeWidth: column.maxResizeWidth,
                    minResizeWidth: column.minResizeWidth,
                    sticky: column.sticky,
                    freezePriority: column.freezePriority,
                    translation: column.translation,
                    builder: (ctxt, _) => InkWell(
                      onTap: () {
                        if (column.sortKey == null) return;
                        notifier.toggleTableSort(column.sortKey!);
                        onChange?.call(currentPage, sort);
                      },
                      child: Padding(
                        padding: column.padding ??
                            const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: column.alignment ?? Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  column.header,
                                  style: column.style ?? headerTextStyle,
                                ),

                                ///
                                /// Sort Arrows
                                ///
                                if (sort?.key == column.sortKey)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (sort?.isAscending == true)
                                          Icon(MIcons.chevronUp),
                                        if (sort?.isAscending == false)
                                          Icon(MIcons.chevronDown),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),

            ///
            /// Table Rows
            ///
            tableRowHeight: 50,
            tableRowBuilder: (context, value, showCheckbox) {
              final offset = showCheckbox ? value.column - 1 : value.column;

              final result = columns[offset].builder?.call(
                    context,
                    items[value.row],
                    value.row,
                    value.column,
                  );

              if (result is Widget)
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: result,
                );

              return SizedBox();
            },

            ///
            /// Mobile Builder
            ///
            mobileBuilder: (context, value) => mobileBuilder(
              context,
              value.row,
              items[value.row],
              value.isSelected,
            ),
          ),

        if (!hidePageController)
          if (error == null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: showMore
                  ? TextButton(
                      onPressed: onShowMore,
                      child: const Text('Show More'),
                    )
                  : PageSelector(
                      totalPages: state.totalPages,
                      page: state.page,
                      enabled: !state.isLoading,
                      onPageChange: (newPage) {
                        notifier..changePage(newPage);
                      },
                      hasNext: state.hasNext,
                    ),
            )
      ],
    );
  }
}
