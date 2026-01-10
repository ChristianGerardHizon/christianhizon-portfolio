import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/products/adjustments/presentation/pages/product_adjustments_page.dart';
import 'package:sannjosevet/src/features/products/stocks/presentation/pages/product_stocks_page.dart';
import 'package:sannjosevet/src/features/products/core/presentation/controllers/product_controller.dart';
import 'package:sannjosevet/src/features/products/core/presentation/widgets/product_details_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductPage extends HookConsumerWidget {
  const ProductPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = productControllerProvider(id);
    final state = ref.watch(provider);

    refresh() async {
      ref.invalidate(provider);
    }

    return state.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: Text('Something Went Wrong'),
        ),
        body: FailureMessage(error, stack),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (productState) {
        final product = productState.product;
        return DefaultTabController(
          length: product.trackByLot ? 3 : 2,
          child: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  ///
                  /// AppBar
                  ///
                  SliverAppBar(
                    leading: BackButton(),
                    title: Text(product.name),
                    actions: [
                      RefreshButton(onPressed: () {
                        refresh();
                      })
                    ],
                  ),

                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
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
                            if (product.trackByLot)
                              Tab(
                                icon: Icon(MIcons.informationOutline),
                                child: Text('Stocks'),
                              ),
                            Tab(
                              icon: Icon(MIcons.informationOutline),
                              child: Text('Adjustments'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.only(top: 75),
                child: TabBarView(
                  children: [
                    ProductDetailsView(product),
                    if (product.trackByLot)
                      ProductStocksPage(product, showAppBar: false),
                    ProductAdjustmentsPage(productId: product.id)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
