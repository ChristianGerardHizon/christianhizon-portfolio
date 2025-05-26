import 'package:flutter/material.dart';
import 'package:sannjosevet/src/features/product_inventories/domain/product_inventory.dart';

class ProductStatusText extends StatelessWidget {
  final ProductInventory product;

  const ProductStatusText({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final status = product.status;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getStatusText(status),
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }

  Color _getStatusColor(ProductStatus status) {
    switch (status) {
      case ProductStatus.inStock:
        return Colors.green;
      case ProductStatus.lowStock:
        return Colors.orange;
      case ProductStatus.noThreshold:
        return Colors.grey;
      case ProductStatus.outOfStock:
        return Colors.red;
    }
  }

  String _getStatusText(ProductStatus status) {
    switch (status) {
      case ProductStatus.inStock:
        return '${product.totalQuantity} remaining';
      case ProductStatus.lowStock:
        return '${product.totalQuantity} remaining | Low Stock';
      case ProductStatus.noThreshold:
        return 'Not Tracking';
      case ProductStatus.outOfStock:
        return 'Out of Stock';
    }
  }
}
