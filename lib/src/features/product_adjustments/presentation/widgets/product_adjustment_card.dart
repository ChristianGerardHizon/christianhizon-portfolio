import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/features/product_adjustments/domain/product_adjustment.dart';

class ProductAdjustmentCard extends StatelessWidget {
  const ProductAdjustmentCard({
    super.key,
    required this.productAdjustment,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final ProductAdjustment productAdjustment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: selected
          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
          : null,
      child: ListTile(
        onLongPress: onLongPress,
        onTap: onTap,
        selected: selected,
        title: Text(productAdjustment.reason.optional(),
            style: Theme.of(context).textTheme.titleMedium),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
