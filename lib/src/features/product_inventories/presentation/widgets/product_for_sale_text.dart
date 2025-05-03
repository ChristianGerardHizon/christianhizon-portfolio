import 'package:flutter/material.dart';

class ProductForSaleText extends StatelessWidget {
  final bool forSale;

  const ProductForSaleText({super.key, required this.forSale});

  @override
  Widget build(BuildContext context) {
    final text = forSale ? 'For Sale' : 'Not For Sale';
    final color = forSale ? Colors.green : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
