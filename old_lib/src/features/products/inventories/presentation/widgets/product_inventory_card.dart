import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/selectable_card.dart';
import 'package:sannjosevet/src/features/products/inventories/domain/product_inventory.dart';
import 'package:sannjosevet/src/features/products/core/presentation/widgets/product_status_text.dart';

class ProductInventoryCard extends StatelessWidget {
  const ProductInventoryCard({
    super.key,
    required this.productInventory,
    required this.onLongPress,
    required this.onTap,
    required this.onAdjustStocks,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final Function() onAdjustStocks;
  final bool selected;
  final ProductInventory productInventory;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
        isThreeLine: true,
        title: Text(
          productInventory.expand.product.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            ProductStatusText(product: productInventory),
            RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: 'Category: ',
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                    text: productInventory.expand.product.expand.category?.name
                        .optional(),
                  ),
                ],
              ),
            ),
            RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: 'Branch: ',
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                    text: productInventory.expand.product.expand.branch?.name
                        .optional(),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: PopoverWidget.icon(
          icon: Icon(MIcons.dotsHorizontal),
          bottomSheetHeader: const Text('Action'),
          items: [
            PopoverMenuItemData(
              name: 'Adjust Stocks',
              onTap: onAdjustStocks,
            ),
          ],
        ),
      ),
    );
  }
}
