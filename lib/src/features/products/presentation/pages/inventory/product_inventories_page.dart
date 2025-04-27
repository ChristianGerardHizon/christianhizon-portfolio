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
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product_inventory.dart';
import 'package:gym_system/src/features/products/presentation/controllers/inventory/product_inventory_table_controller.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_inventory_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductInventoriesPage extends HookConsumerWidget {
  const ProductInventoriesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.productInventory;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = productInventoryTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(ProductInventory productInventory) {
      ProductPageRoute(productInventory.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(productInventoryTableControllerProvider);
      ref.invalidate(provider);
      // controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<ProductInventory> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(productInventoryTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      ProductFormPageRoute().push(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('ProductInventorys'),
          actions: [
            RefreshButton(
              onPressed: onRefresh,
            ),
          ],
        ),
        body: DynamicTableView<ProductInventory>(
          tableKey: TableControllerKeys.productInventory,
          error: null,
          items: listState.maybeWhen(
            skipError: true,
            skipLoadingOnRefresh: false,
            skipLoadingOnReload: true,
            data: (items) => items,
            orElse: () => [],
          ),
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
                    '${data.expand.product.name}',
                  ),
                );
              },
            ),
            TableColumn(
              header: 'Branch',
              alignment: Alignment.centerLeft,
              builder: (context, productInventory, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text((productInventory.expand.branch?.name).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
            TableColumn(
              header: 'Date Created',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, productInventory, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      (productInventory.created?.yyyyMMddHHmmA()).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
            TableColumn(
              header: 'Actions',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, productInventory, row, column) {
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
          mobileBuilder: (context, index, productInventory, selected) {
            return ProductInventoryCard(
              productInventory: productInventory,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(productInventory);
              },
              selected: selected,
              onLongPress: () {
                notifier.toggleRow(index);
              },
            );
          },
        ));
  }
}
