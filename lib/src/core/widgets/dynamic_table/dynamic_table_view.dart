import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_base.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_sort.dart';
import 'package:gym_system/src/core/widgets/page_actions.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/core/widgets/text_search_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicTableView<T> extends HookConsumerWidget {
  final String tableKey;
  final Widget? emptyWidget;

  final List<T> items;
  final Widget? error;
  final Function(int, TableSort?)? onChange;
  final Function(T)? onRowTap;
  final Function(List<T>)? onRowDelete;

  final TextEditingController searchCtrl;
  final Function()? onSearch;
  final Function()? onClear;
  final Function()? onCreate;
  final Function(List<T>)? onDelete;

  final List<TableColumn<T>> columns;
  final TextStyle? headerTextStyle;
  final Widget Function(
    BuildContext context,
    int index,
    T data,
    bool selected,
  ) mobileBuilder;

  const DynamicTableView({
    super.key,
    this.onRowTap,
    required this.tableKey,
    required this.items,
    this.error,
    this.onChange,
    this.onRowDelete,
    required this.searchCtrl,
    this.onSearch,
    this.onClear,
    this.onCreate,
    this.headerTextStyle,
    required this.columns,
    required this.mobileBuilder,
    this.emptyWidget,
    this.onDelete,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = tableControllerProvider(tableKey);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    useEffect(() {
      return null;

      // set the base filter before the first fetch
      // notifier.changeFilter(searchCtrl.text, baseFilter: baseFilter);
    }, []);

    final isLoading = state.isLoading;
    final selected = state.selected;
    final sort = state.sort;
    final currentPage = state.page;

    onSearch() {
      notifier.changePage(1);
      notifier.changeFilter(searchCtrl.text);
    }

    ///
    /// Table Controller
    ///
    return StackLoader(
      opacity: .1,
      isLoading: isLoading,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ///
              /// Serch Bar
              ///
              SliverToBoxAdapter(
                child: TextSearchBar(
                  controller: searchCtrl,
                  onClear: onClear,
                  onSearch: onSearch,
                  onCreate: onCreate,
                ),
              ),

              ///
              /// on error
              ///
              if (error != null) SliverToBoxAdapter(child: error),

              ///
              /// Empty
              ///
              if (items.isEmpty && isLoading == false)
                SliverToBoxAdapter(
                  child: emptyWidget ??
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'We could not find any results',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Theme.of(context).disabledColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),

              ///
              ///  Content
              ///
              if (items.isNotEmpty && isLoading == false)
                SliverDynamicBase(
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
                          builder: (ctxt, _) => InkWell(
                            onTap: () {
                              if (column.sortKey == null) return;
                              notifier.toogleTableSort(column.sortKey!);
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
                                  alignment:
                                      column.alignment ?? Alignment.center,
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
                                          padding:
                                              const EdgeInsets.only(left: 4),
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
                  tableRowBuilder: (context, value) {
                    final offset = value.column - 1;

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

              ///
              /// Page Selector
              ///
              SliverPadding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: PageSelector(
                    totalPages: state.totalPages,
                    page: state.page,
                    onPageChange: (newPage) {
                      notifier..changePage(newPage);
                    },
                    hasNext: state.hasNext,
                  ),
                ),
              )
            ],
          ),

          ///
          /// Delete Hover Actions
          ///
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selected.isNotEmpty
                  ? PageActions(
                      size: selected.length,
                      onDelete: () =>
                          onDelete?.call(pickByIndex(selected, items)),
                      onReset: notifier.clearSelection,
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}

List<T> pickByIndex<T>(List<int> indices, List<T> items) {
  return indices
      .where((i) => i >= 0 && i < items.length)
      .map((i) => items[i])
      .toList();
}
