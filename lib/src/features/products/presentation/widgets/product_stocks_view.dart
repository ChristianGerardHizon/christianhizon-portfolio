import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:gym_system/src/features/products/presentation/pages/stock/product_stock_table_controller.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_stock_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStocksView extends HookConsumerWidget {
  final Product product;
  const ProductStocksView(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.productStock;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = productStockTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(ProductStock productStock) {
      ProductStockPageRoute(productStock.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<ProductStock> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productStockRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(productStockTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      ProductStockFormPageRoute(productId: product.id).push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ProductStocks'),
        actions: [
          RefreshButton(
            onPressed: onRefresh,
          ),
        ],
      ),
      body: listState.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        error: (error, stack) => Center(
          child: Text(error.toString()),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        data: (items) => DynamicTableView<ProductStock>(
          tableKey: TableControllerKeys.productStock,
          error: null,
          items: items,
          onDelete: onDelete,
          onRowTap: onTap,

          ///
          /// Search Features
          ///
          searchCtrl: searchCtrl,
          onCreate: onCreate,

          ///
          /// Table Data
          ///
          columns: [
            TableColumn(
              header: 'Name',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.lotNo.optional(),
                  ),
                );
              },
            ),
            TableColumn(
              header: 'Date Created',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, productStock, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      (productStock.created?.yyyyMMddHHmmA()).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
            TableColumn(
              header: 'Actions',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, productStock, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(onPressed: () {}, child: Text('Add Stock')),
                );
              },
            ),
          ],

          ///
          /// Builder for mobile
          ///
          mobileBuilder: (context, index, productStock, selected) {
            return ProductStockCard(
              productStock: productStock,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(productStock);
              },
              selected: selected,
              onLongPress: () {
                notifier.toggleRow(index);
              },
            );
          },
        ),
      ),
    );
  }
}
