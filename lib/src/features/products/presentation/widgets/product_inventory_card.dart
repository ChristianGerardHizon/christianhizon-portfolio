import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/responsive_row_column.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/products/domain/product_inventory.dart';

class ProductInventoryCard extends StatelessWidget {
  const ProductInventoryCard({
    super.key,
    required this.productInventory,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final ProductInventory productInventory;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(MIcons.abacus),
            title: Text(productInventory.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(productInventory.name),
                Text(productInventory.category.optional()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveRowColumn(
              breakpoint: 100,
              first: TextButton(
                onPressed: () {},
                child: Text(
                  'Add Stocks',
                ),
              ),
              second: SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
