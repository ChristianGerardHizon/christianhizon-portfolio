import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/responsive_pagination_list_with_delete_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
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
    final notifier = ref.read(productsPageControllerProvider.notifier);
    final provider = ref.watch(productsControllerProvider);
    final searchNotifier = ref.read(productSearchControllerProvider.notifier);
    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(Product product) {
      ProductPageRoute(product.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(productsControllerProvider);
      controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Product> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          controller.clear();
          ref.invalidate(productsControllerProvider);
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
      ProductCreatePageRoute().push(context);
    }

    ///
    /// onSearch
    ///
    onSearch() {
      final query = searchCtrl.text.trim();
      searchNotifier.updateParams(ProductSearch(name: query));
    }

    ///
    /// Handle Clear
    ///
    onClear() {
      searchCtrl.clear();
      searchNotifier.updateParams(ProductSearch(name: ''));
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
      body:

          ///
          /// Table
          ///
          ResponsivePaginationListWithDeleteView<Product>(
        controller: controller,
        onPageChange: notifier.changePage,
        errorMessage: provider.maybeWhen(
          skipError: false,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          error: (error, stackTrace) => 'generic error',
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
        onHeaderTap: (headerKey) {},
        onTap: onTap,
        data: [
          TableColumn(
            header: 'Name',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, extra) {
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
            header: 'Status',
            alignment: Alignment.centerLeft,
            builder: (context, product, extra) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(product.name, overflow: TextOverflow.ellipsis),
              );
            },
          ),
          TableColumn(
            header: 'Date Created',
            alignment: Alignment.centerLeft,
            width: 150,
            builder: (context, product, extra) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((product.created?.yyyyMMddHHmmA()).optional(),
                    overflow: TextOverflow.ellipsis),
              );
            },
          ),
          TableColumn(
            header: 'Date Updated',
            alignment: Alignment.centerLeft,
            width: 150,
            builder: (context, product, extra) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((product.updated?.yyyyMMddHHmmA()).optional(),
                    overflow: TextOverflow.ellipsis),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, value, selected) {
          return SelectableCard(
            margin: EdgeInsets.all(8),
            onLongPress: () {
              if (selected) {
                controller.select(index);
              } else {
                controller.toggle(index);
              }
            },
            onTap: () {
              final isSelecting = controller.selected.isNotEmpty;

              if (isSelecting) {
                controller.toggle(index);
                return;
              }

              onTap(value);
            },
            selected: selected,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value.name),
                  Text(value.category.optional()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
