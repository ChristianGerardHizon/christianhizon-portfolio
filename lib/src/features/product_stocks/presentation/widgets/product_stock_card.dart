import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:gym_system/src/features/product_stocks/presentation/widgets/expiration_text.dart';

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
      child: ListTile(
        title: Text(productStock.lotNo.optional()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: 'Quantity: ',
                      style: Theme.of(context).textTheme.labelMedium),
                  TextSpan(
                    text: (productStock.quantity?.toString()).optional(),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (_) {
                final expiration = productStock.expiration;
                if (expiration is DateTime) {
                  return ExpirationStatusText(expirationDate: expiration);
                }
                return Text('-');
              },
            )
          ],
        ),
      ),
    );
  }
}
