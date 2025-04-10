import 'package:flutter/material.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStocksView extends HookConsumerWidget {
  final Product product;
  const ProductStocksView(this.product, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
