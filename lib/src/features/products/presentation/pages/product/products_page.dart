import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/table_controller.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/product_table_controller.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsPage extends HookConsumerWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.product;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = productTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ref.listen(listProvider, (curr, next) {
      if (next.isLoading || next.isRefreshing || next.isReloading) {
        notifier.startLoading();
      }

      if (next is AsyncError) {
        // notifier.fetchFailed();
      }

      if (next.hasValue) {
        notifier.stopLoading();
      }
    });

    ///
    /// onTap
    ///
    onTap(int index, Product product, bool selected) {
      // if (!selected && controller.selected.isNotEmpty) {
      //   controller.toggle(index);
      //   return;
      // }
      // if (selected) {
      //   controller.toggle(index);
      //   return;
      // }
      ProductPageRoute(product.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(productTableControllerProvider);
      ref.invalidate(provider);
      // controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Product> items) async {
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
          // controller.clear();
          ref.invalidate(productTableControllerProvider);
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
        title: Text('Products'),
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
        data: (items) => DynamicTableView<Product>(
          tableKey: TableControllerKeys.product,
          error: null,
          results: items,
          onDelete: onDelete,

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
                    '${data.name}',
                  ),
                );
              },
            ),
            TableColumn(
              header: 'Branch',
              alignment: Alignment.centerLeft,
              builder: (context, product, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text((product.expand.branch?.name).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
            TableColumn(
              header: 'Date Created',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, product, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text((product.created?.yyyyMMddHHmmA()).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
            TableColumn(
              header: 'Actions',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, product, row, column) {
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
          mobileBuilder: (context, index, product, selected) {
            return ProductCard(
              product: product,
              onTap: () => onTap(index, product, selected),
              selected: selected,
              onLongPress: () {
                // controller.toggle(index);
              },
            );
          },
        ),
      ),
    );
  }
}
