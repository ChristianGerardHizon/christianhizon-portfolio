import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';

class ProductStockCard extends StatelessWidget {
  const ProductStockCard({
    super.key,
    required this.productStock,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final ProductStock productStock;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text(productStock.toJson())],
      ),
    );
  }
}
