import 'package:flutter/material.dart';
import 'package:sannjosevet/src/features/products/domain/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(
      {super.key, required this.product, this.showQuantity = false});
  final Product product;
  final bool showQuantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(product.name[0]),
      ),
      title: Text(product.name),
      subtitle:
          showQuantity ? Text('Quantity: ${product.quantity ?? '-'}') : null,
    );
  }
}
