import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/int.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/responsive_pagination_list_with_delete_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/table_column.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:gym_system/src/features/products/domain/product_stock_search.dart';
import 'package:gym_system/src/features/products/presentation/controllers/stock/product_stocks_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/stock/product_stocks_page_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStocksView extends HookConsumerWidget {
  final Product product;
  const ProductStocksView(this.product, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => DynamicTableController());
    final searchCtrl = useTextEditingController();
    final notifier = ref.read(productStocksPageControllerProvider.notifier);
    final provider = ref.watch(productStocksControllerProvider);
    final searchNotifier =
        ref.read(productStockSearchControllerProvider.notifier);
    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(int index, ProductStock stock, bool selected) {
      if (!selected && controller.selected.isNotEmpty) {
        controller.toggle(index);
        return;
      }
      if (selected) {
        controller.toggle(index);
        return;
      }
      ProductStockPageRoute(stock.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(productStocksControllerProvider);
      controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<ProductStock> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productStockRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          controller.clear();
          ref.invalidate(productStocksControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    bool buildIsLoading() {
      if (isLoading.value) return true;
      return provider.maybeWhen(
        skipError: true,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => true,
        orElse: () => false,
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      ProductStockFormPageRoute(productId: product.id).push(context);
    }

    ///
    /// onSearch
    ///
    onSearch() {
      final query = searchCtrl.text.trim();
      searchNotifier.updateParams(ProductStockSearch(name: query));
    }

    ///
    /// Handle Clear
    ///
    onClear() {
      searchCtrl.clear();
      searchNotifier.updateParams(ProductStockSearch(name: ''));
    }

    return ResponsivePaginationListWithDeleteView<ProductStock>(
      controller: controller,
      onPageChange: notifier.changePage,

      error: provider.maybeWhen(
        skipError: false,
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        error: (error, stackTrace) {
          print(error);
          return Center(
            child: Text(error.toString()),
          );
        },
        orElse: () => null,
      ),
      isLoading: buildIsLoading(),
      results: provider.when(
        skipError: true,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        data: (x) => x,
        error: (error, stackTrace) => null,
        loading: () => null,
      ),
      onDelete: onDelete,

      ///
      /// Search Features
      ///
      searchCtrl: searchCtrl,
      onClear: onClear,
      onCreate: onCreate,
      onSearch: onSearch,

      ///
      /// Table Data
      ///
      onHeaderTap: (headerKey) {
        print(headerKey?.toJson());
      },
      onTap: (x) => onTap(0, x, false),
      data: [
        TableColumn(
          header: 'Lot No.',
          width: 200,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                '${data.lotNo.optional()}',
              ),
            );
          },
        ),
        TableColumn(
          header: 'Used Quantity',
          width: 150,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                data.usedQuantity.optional(),
              ),
            );
          },
        ),
        TableColumn(
          header: 'Quantity',
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                data.quantity.optional(),
              ),
            );
          },
        ),
        TableColumn(
          header: 'Expiration',
          width: 200,
          alignment: Alignment.centerLeft,
          builder: (context, data, row, column) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                '${(data.expiration?.yyyyMMdd()).optional()}',
              ),
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
              child: Text(
                (product.created?.yyyyMMddHHmmA()).optional(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
      ],

      ///
      /// Builder for mobile
      ///
      mobileBuilder: (context, index, product, selected) {
        return Text(product.toJson());
      },
    );
  }
}
