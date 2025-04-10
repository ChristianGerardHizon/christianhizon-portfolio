import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patients_controller.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/product_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailsView extends HookConsumerWidget {
  const ProductDetailsView(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// onDelete
    ///
    onDelete(Product product) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productRepositoryProvider);
      repo.softDeleteMulti([product.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(patientsControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                if (context.canPop()) context.pop();
              },
            );
          });
    }

    ///
    /// Refresh
    ///
    refresh() async {
      ref.invalidate(productsControllerProvider);
    }

    return CustomScrollView(
      slivers: [
        ///
        /// Content
        ///
        SliverList.list(
          children: [
            SizedBox(height: 20),

            ///
            /// Product General Info
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                child: CollapsingCard(
                  header: Text(
                    'Product Info',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  child: Column(
                    children: [
                      ///
                      /// name
                      ///
                      DynamicListTile.divider(
                        title: Text('Name: '),
                        content: Text(product.name),
                      ),

                      DynamicListTile.divider(
                        title: Text('Branch: '),
                        content: Text((product.expand.branch?.name).optional()),
                      ),

                      ///
                      /// name
                      ///
                      DynamicListTile(
                        title: Text('Description: '),
                        content: Text(product.description.optional()),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///
            /// System Details
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                child: CollapsingCard(
                  header: Text(
                    'Other Info',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  child: Column(
                    children: [
                      DynamicListTile(
                        title: Text('Created At: '),
                        content: Text(
                            (product.created?.toLocal().yyyyMMddHHmmA())
                                .optional()),
                      ),
                      Divider(),
                      DynamicListTile(
                        title: Text('Updated At: '),
                        content: Text(
                            (product.updated?.toLocal().yyyyMMddHHmmA())
                                .optional()),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CardGroup(
                header: 'Actions',
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('Edit Product Information'),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      size: 24,
                    ),
                    onTap: () =>
                        ProductFormPageRoute(id: product.id).push(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_outlined),
                    title: const Text('Delete Product Permanently'),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      size: 24,
                    ),
                    onTap: () => onDelete(product),
                  ),
                ],
              ),
            ),

            ///
            /// Spacer
            ///
            SizedBox(height: 50),
          ],
        )
      ],
    );
  }
}
