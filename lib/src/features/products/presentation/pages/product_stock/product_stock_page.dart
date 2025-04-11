import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_stock/product_stock_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_stock/product_stocks_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStockPage extends HookConsumerWidget {
  const ProductStockPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productStockControllerProvider(id));

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
                ref.invalidate(productStocksControllerProvider);
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
      ref.invalidate(productStocksControllerProvider);
    }

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: state.when(
        error: (error, stack) => Scaffold(
          appBar: AppBar(
            title: Text('Something Went Wrong'),
          ),
          body: Center(child: Text(error.toString())),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (stock) {
          return SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  ///
                  /// AppBar
                  ///
                  SliverAppBar(
                    title: Text(stock.lotNo.optional()),
                    actions: [
                      RefreshButton(onPressed: () {
                        refresh();
                      })
                    ],
                  ),

                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: PinnedHeaderSliver(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        child: TabBar(
                          isScrollable: false,
                          tabs: [
                            Tab(
                              icon: Icon(MIcons.accountOutline),
                              child: Text('Details'),
                            ),
                            Tab(
                              icon: Icon(MIcons.informationOutline),
                              child: Text('Stocks'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
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
                                /// name
                                ///
                                DynamicListTile.divider(
                                  title: Text('Lot: '),
                                  content: Text(stock.lotNo.optional()),
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
                              onTap: () => ProductStockFormPageRoute(
                                      id: stock.id, productId: stock.product)
                                  .push(context),
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete_outlined),
                              title: const Text('Delete Product Permanently'),
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
            ),
          );
        },
      ),
    );
  }
}
