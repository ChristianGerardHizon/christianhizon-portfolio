import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_ink_well.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/responsive_pagination_list_with_delete_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_search.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_page_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsPage extends HookConsumerWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => DynamicTableController());
    final searchCtrl = useTextEditingController();

    onTap(Product product) {
      ProductPageRoute(product.id).push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(productsControllerProvider),
          ),
        ],
      ),
      body:

          ///
          /// Table
          ///
          ResponsivePaginationListWithDeleteView<Product>(
        controller: controller,
        onPageChange:
            ref.read(productsPageControllerProvider.notifier).changePage,
        errorMessage: ref.watch(productsControllerProvider).maybeWhen(
            skipError: false,
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            error: (error, stackTrace) => 'generic error',
            orElse: () => null),
        results: ref.watch(productsControllerProvider).when(
              skipError: true,
              skipLoadingOnRefresh: false,
              skipLoadingOnReload: false,
              data: (x) => x,
              error: (error, stackTrace) => null,
              loading: () => null,
            ),
        onDelete: (items) async {
          final confirm = await ConfirmModal.show(context);
          if (confirm != true) return;
          final repo = ref.read(productRepositoryProvider);
          final ids = items.map((e) => e.id).toList();
          final result = await repo.softDeleteMulti(ids).run();
          result.fold(
            (l) => AppSnackBar.rootFailure(l),
            (r) {
              controller.clear();
              ref.invalidate(productsControllerProvider);
              AppSnackBar.root(message: 'Successfully Deleted');
              if (context.canPop()) context.pop();
            },
          );
        },

        ///
        /// Search Features
        ///
        searchCtrl: searchCtrl,
        onClear: () {},
        onCreate: () {
          ProductCreatePageRoute().push(context);
        },
        onSearch: () {
          final query = searchCtrl.text.trim();
          ref
              .read(productSearchControllerProvider.notifier)
              .updateParams(ProductSearch(name: query));
        },

        ///
        /// Table Data
        ///
        onHeaderTap: (headerKey) {},
        onTap: onTap,
        data: [
          TableColumn(
            header: 'Name',
            builder: (context, data, extra) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${data.name}'),
                  Text('${extra.row} ${extra.column} ${extra.isSelected}'),
                ],
              );
            },
          ),
          TableColumn(
            header: 'Status',
            builder: (context, product, extra) {
              return Text(product.name);
            },
          ),
          TableColumn(header: 'Date Created', width: 150),
          TableColumn(header: 'Date Updated', width: 150),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, value, selected) => Card(
          child: CardInkWell(
            onTap: () => onTap(value),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(value.name),
            ),
          ),
        ),
      ),
    );
  }
}
