import 'package:flutter/material.dart';

class ProductTotalQuantity extends StatelessWidget {
  const ProductTotalQuantity(
      {super.key, required this.quantity, required this.total});

  final num quantity;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Text(
      quantity.toString(),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
