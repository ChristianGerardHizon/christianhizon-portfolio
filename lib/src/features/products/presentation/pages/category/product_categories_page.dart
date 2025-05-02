import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/breeds/patient_breeds_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/species/patient_species_controller.dart';
import 'package:gym_system/src/features/products/data/product_category_repository.dart';
import 'package:gym_system/src/features/products/domain/product_category.dart';
import 'package:gym_system/src/features/products/presentation/controllers/category/product_category_table_controller.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_category_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCategoriesPage extends HookConsumerWidget {
  const ProductCategoriesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.productCategory;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = productCategoryTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ref.watch(patientBreedsControllerProvider);
    ref.watch(patientSpeciesControllerProvider);

    ///
    /// onTap
    ///
    onTap(ProductCategory productCategory) {
      ProductCategoryPageRoute(productCategory.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(productCategoryTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<ProductCategory> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productCategoryRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(productCategoryTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      ProductCategoryFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ProductCategorys'),
        actions: [
          RefreshButton(
            onPressed: onRefresh,
          ),
        ],
      ),
      body: DynamicTableView<ProductCategory>(
        tableKey: TableControllerKeys.productCategory,
        error: listState.maybeWhen(
          skipError: false,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          orElse: () => null,
          error: (error, stackTrace) => FailureMessage(error, stackTrace),
        ),
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
                  data.name,
                ),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, productCategory, selected) {
          return ProductCategoryCard(
            productCategory: productCategory,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(productCategory);
            },
            selected: selected,
            onLongPress: () {
              notifier.toggleRow(index);
            },
          );
        },
      ),
    );
  }
}
