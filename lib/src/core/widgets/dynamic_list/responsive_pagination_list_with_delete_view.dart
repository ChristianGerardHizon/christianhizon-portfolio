import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/core/widgets/page_actions.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/core/widgets/text_search_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TableColumn<T> {
  final String header;
  final String? headerKey;
  final double width;
  final Widget Function(
    BuildContext context,
    T data,
    DynamicTableBuilderValue extra,
  )? builder;

  TableColumn({
    required this.header,
    this.headerKey,
    this.width = 100,
    this.builder,
  });
}

class ResponsivePaginationListWithDeleteView<T> extends HookConsumerWidget {
  final bool isLoading;
  final PageResults<T>? results;
  final String? errorMessage;
  final Function(int page)? onPageChange;
  final Function(List<T> item)? onDelete;
  final DynamicTableController controller;

  final TextEditingController searchCtrl;
  final Function() onSearch;
  final Function() onClear;
  final Function() onCreate;

  final Function(String? headerKey)? onHeaderTap;
  final Function(T data)? onTap;
  final String? headerKey;
  final List<TableColumn<T>> data;
  final Widget Function(
    BuildContext context,
    int index,
    T data,
    bool selected,
  ) mobileBuilder;

  const ResponsivePaginationListWithDeleteView({
    super.key,
    required this.controller,
    this.results,
    this.errorMessage,
    this.onPageChange,
    this.onDelete,
    this.isLoading = false,
    required this.searchCtrl,
    required this.onSearch,
    required this.onClear,
    required this.onCreate,
    this.headerKey,
    this.onHeaderTap,
    required this.data,
    this.onTap,
    required this.mobileBuilder,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useListenable(controller);

    ///
    /// Table Controller
    ///
    return Stack(
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
            if (errorMessage != null)
              SliverToBoxAdapter(
                child: SizedBox(height: 200, child: Text(errorMessage!)),
              ),

            ///
            ///  Content
            ///
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

  Widget buildHeader(BuildContext context, TableColumn<T> column) => InkWell(
        onTap: () => onHeaderTap?.call(column.headerKey),
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Center(
            child: Text(column.header),
          ),
        ),
      );

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
              builder: (context, _) => buildHeader(context, column),
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
              value,
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
