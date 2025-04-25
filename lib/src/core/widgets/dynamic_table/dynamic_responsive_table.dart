import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/header_key.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/table_column.dart';
import 'package:gym_system/src/core/widgets/page_actions.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/core/widgets/text_search_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicResponsiveTable<T> extends HookConsumerWidget {
  final bool isLoading;
  final Widget? emptyWidget;

  final PageResults<T>? results;
  final Widget? error;
  final Function(int page)? onPageChange;
  final Function(List<T> item)? onDelete;
  final DynamicTableController controller;

  final TextEditingController searchCtrl;
  final Function() onSearch;
  final Function() onClear;
  final Function() onCreate;

  final Function(HeaderKey? headerKey)? onHeaderTap;
  final Function(T data)? onTap;
  final List<TableColumn<T>> data;
  final TextStyle? headerTextStyle;
  final Widget Function(
    BuildContext context,
    int index,
    T data,
    bool selected,
  ) mobileBuilder;

  const DynamicResponsiveTable({
    super.key,
    required this.controller,
    this.results,
    this.error,
    this.onPageChange,
    this.onDelete,
    this.isLoading = false,
    required this.searchCtrl,
    required this.onSearch,
    required this.onClear,
    required this.onCreate,
    this.headerTextStyle,
    this.onHeaderTap,
    required this.data,
    this.onTap,
    required this.mobileBuilder,
    this.emptyWidget,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useListenable(controller);

    ///
    /// Table Controller
    ///
    final items = results?.items ?? [];
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
              if (error != null)
                SliverToBoxAdapter(
                  child: error,
                ),

              if (items.isEmpty && isLoading == false)
                SliverToBoxAdapter(
                  child: emptyWidget ??
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: emptyWidget ??
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'We could not find any results',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color:
                                              Theme.of(context).disabledColor,
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
              if (items.isNotEmpty)
                buildContent(
                  result: results,
                  columns: data,
                  tableController: controller,
                  onRowTap: onTap,
                ),

              ///
              /// Page Selector
              ///
              buildPageSelector(results),
            ],
          ),
          buildActions(controller, onDelete: () {
            onDelete?.call(
              controller.selected.map((e) => results!.items[e]).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget buildActions(
    DynamicTableController tableController, {
    Function()? onDelete,
  }) {
    final selected = tableController.selected;
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: selected.isNotEmpty
            ? PageActions(
                size: selected.length,
                onDelete: onDelete?.call,
                onReset: () {
                  tableController.clear();
                },
              )
            : SizedBox(),
      ),
    );
  }

  Widget buildPageSelector(PageResults? results) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10, bottom: 30),
      sliver: SliverToBoxAdapter(
        child: PageSelector(
          page: results?.page ?? 0,
          onPageChange: (x) {
            controller.clear();
            onPageChange?.call(x);
          },
          hasNext: results?.hasNext ?? false,
        ),
      ),
    );
  }

  Widget buildHeader(
    BuildContext context,
    TableColumn<T> column,
    HeaderKey? headerKey,
  ) {
    final isAscending = headerKey?.isAscending == false;
    final columnKey = HeaderKey(key: column.header, isAscending: isAscending);
    return InkWell(
      onTap: onHeaderTap != null
          ? () {
              final newKey = columnKey.reverse();
              controller.tooggleHeaderKey(newKey);
              onHeaderTap?.call(newKey);
            }
          : null,
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
                if (columnKey.key == controller.headerKey?.key)
                  headerKeyBuilder(columnKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerKeyBuilder(HeaderKey? hKey) {
    if (hKey == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hKey.isAscending == true) Icon(MIcons.chevronUp),
          if (hKey.isAscending == false) Icon(MIcons.chevronDown),
        ],
      ),
    );
  }

  Widget buildContent({
    required PageResults? result,
    required List<TableColumn<T>> columns,
    required DynamicTableController tableController,
    Function(T)? onRowTap,
  }) {
    final items = result?.items ?? [];

    ///
    /// show loading if null
    ///
    if (result == null) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return SliverDynamicBaseList(
      controller: tableController,
      itemCount: items.length,
      onTableRowTap: (index) => onRowTap?.call(items[index]),

      ///
      /// Table Columns
      ///
      columns: columns
          .map(
            (column) => DynamicTableColumn(
              width: column.width,
              builder: (ctxt, _) =>
                  buildHeader(ctxt, column, controller.headerKey),
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

        if (result is Widget) return result;

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
    );
  }
}
