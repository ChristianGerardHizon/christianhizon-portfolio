import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/product_controller.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_details_view.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_stocks_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductPage extends HookConsumerWidget {
  const ProductPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productControllerProvider(id));

    refresh() async {}
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: state.when(
        error: (error, stack) => Scaffold(
          appBar: AppBar(
            title: Text('Something Went Wrong'),
          ),
          body: FailureMessage(error, stack),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (productState) {
          final product = productState.product;
          return SafeArea(
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
              body: Padding(
                padding: const EdgeInsets.only(top: 75),
                child: TabBarView(
                  children: [
                    ProductDetailsView(product),
                    ProductStocksView(product),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
