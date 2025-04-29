import 'package:flutter/material.dart';

class ProductTotalQuantity extends StatelessWidget {
  const ProductTotalQuantity(
      {super.key, required this.quantity, required this.total});

  final num quantity;
  final num total;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$quantity',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextSpan(
            text: ' / $total',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
