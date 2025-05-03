import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/product_stocks/data/product_stock_repository.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_controller.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStockPage extends HookConsumerWidget {
  const ProductStockPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productStockControllerProvider(id));
    final theme = Theme.of(context);

    ///
    /// onDelete
    ///
    onDelete(ProductStock stock) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productStockRepositoryProvider);
      repo.softDeleteMulti([stock.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(productStockTableControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                if (context.canPop()) context.pop();
              },
            );
          });
    }

    return state.when(
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: Text('Something Went Wrong'),
        ),
        body: Center(child: Text(error.toString())),
      ),
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      data: (stock) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Product Stock'),
          ),
          body: CustomScrollView(
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
                          'Product Stock Info',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        child: Column(
                          children: [
                            ///
                            /// Lot
                            ///
                            DynamicListTile.divider(
                              title: Text('Lot: '),
                              content: Text(stock.lotNo.optional()),
                            ),

                            ///
                            /// Quantity
                            ///
                            DynamicListTile.divider(
                              title: Text('Quantity: '),
                              content:
                                  Text((stock.quantity.toString()).optional()),
                            ),

                            ///
                            /// Expiration
                            ///
                            DynamicListTile(
                              title: Text('Expiration: '),
                              content: Text(
                                  (stock.expiration?.yyyyMMdd()).optional()),
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
                          title: const Text('Edit Product Stock Details'),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            size: 24,
                          ),
                          onTap: () => ProductStockFormPageRoute(
                                  id: stock.id, productId: stock.product)
                              .push(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_outlined),
                          title: const Text('Delete Product Stock'),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            size: 24,
                          ),
                          onTap: () => onDelete(stock),
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
          ),
        );
      },
    );
  }
}
