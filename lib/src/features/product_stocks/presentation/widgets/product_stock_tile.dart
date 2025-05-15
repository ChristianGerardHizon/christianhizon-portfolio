import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';

class ProductStockTile extends StatelessWidget {
  const ProductStockTile(
      {super.key, required this.productStock, this.showQuantityUpdate = false});
  final ProductStock productStock;
  final bool showQuantityUpdate;

  @override
  Widget build(BuildContext context) {
    final lotNo = productStock.lotNo ?? '';
    final quantity = productStock.quantity ?? 0;
    return ListTile(
      leading: CircleAvatar(
        child: Text(lotNo.isNotEmpty ? lotNo[0] : '?'),
      ),
      title: Text(lotNo.optional()),
      subtitle: Text('Quantity: $quantity'),
    );
  }
}
