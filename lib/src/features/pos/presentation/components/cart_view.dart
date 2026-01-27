import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/currency_format.dart';
import '../../../products/domain/product_lot.dart';
import '../cart_controller.dart';
import 'checkout_dialog.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartAsync = ref.watch(cartControllerProvider);

    return cartAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (cartState) {
        final cartItems = cartState.items;
        final total = cartState.total;
        final isSyncing = cartState.isSyncing;

        return Column(
          children: [
            // Sync indicator
            if (isSyncing)
              LinearProgressIndicator(
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),

            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 48,
                                color: theme.colorScheme.onSurfaceVariant
                                    .withOpacity(0.5),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Cart is empty',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Add products from the grid',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant
                                      .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final product = item.product;
                        if (product == null) return const SizedBox.shrink();

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Row 1: Product name + delete button
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // Show lot number if item is from a specific lot
                                          if (item.hasLot &&
                                              item.lotNumber != null) ...[
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.inventory_2_outlined,
                                                  size: 12,
                                                  color:
                                                      theme.colorScheme.primary,
                                                ),
                                                const SizedBox(width: 4),
                                                Flexible(
                                                  child: Text(
                                                    'Lot: ${item.lotNumber}',
                                                    style: theme
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                      color: theme
                                                          .colorScheme.primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    // Delete button - aligned to top right
                                    SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                          size: 16,
                                        ),
                                        padding: EdgeInsets.zero,
                                        onPressed: isSyncing
                                            ? null
                                            : () {
                                                ref
                                                    .read(cartControllerProvider
                                                        .notifier)
                                                    .removeFromCart(product);
                                              },
                                        tooltip: 'Remove item',
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Row 2: Unit price, quantity controls, and total
                                Row(
                                  children: [
                                    // Unit price (flexible to allow shrinking)
                                    Expanded(
                                      child: Text(
                                        '${product.price.toCurrency()} each',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color:
                                              theme.colorScheme.onSurfaceVariant,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // Quantity controls - styled stepper
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              theme.colorScheme.outlineVariant,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Minus button
                                          InkWell(
                                            onTap: isSyncing
                                                ? null
                                                : () {
                                                    ref
                                                        .read(
                                                            cartControllerProvider
                                                                .notifier)
                                                        .updateQuantity(
                                                          product,
                                                          item.quantity
                                                                  .toInt() -
                                                              1,
                                                        );
                                                  },
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                              left: Radius.circular(7),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                                color: isSyncing
                                                    ? theme.colorScheme
                                                        .onSurfaceVariant
                                                        .withValues(alpha: 0.5)
                                                    : theme.colorScheme
                                                        .onSurfaceVariant,
                                              ),
                                            ),
                                          ),

                                          // Quantity display (tappable to edit)
                                          InkWell(
                                            onTap: isSyncing
                                                ? null
                                                : () async {
                                                    final newQuantity =
                                                        await _showQuantityDialog(
                                                      context,
                                                      item.quantity.toInt(),
                                                    );
                                                    if (newQuantity != null &&
                                                        newQuantity !=
                                                            item.quantity
                                                                .toInt()) {
                                                      if (item.hasLot) {
                                                        // Create minimal ProductLot for lookup
                                                        final lot = ProductLot(
                                                          id: item.productLotId!,
                                                          productId:
                                                              item.productId,
                                                          lotNumber:
                                                              item.lotNumber ??
                                                                  '',
                                                        );
                                                        ref
                                                            .read(
                                                                cartControllerProvider
                                                                    .notifier)
                                                            .updateQuantityWithLot(
                                                              product,
                                                              lot,
                                                              newQuantity,
                                                            );
                                                      } else {
                                                        ref
                                                            .read(
                                                                cartControllerProvider
                                                                    .notifier)
                                                            .updateQuantity(
                                                              product,
                                                              newQuantity,
                                                            );
                                                      }
                                                    }
                                                  },
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  minWidth: 32),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                '${item.quantity.toInt()}',
                                                textAlign: TextAlign.center,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      theme.colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Plus button
                                          InkWell(
                                            onTap: isSyncing
                                                ? null
                                                : () {
                                                    ref
                                                        .read(
                                                            cartControllerProvider
                                                                .notifier)
                                                        .updateQuantity(
                                                          product,
                                                          item.quantity
                                                                  .toInt() +
                                                              1,
                                                        );
                                                  },
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                              right: Radius.circular(7),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                                color: isSyncing
                                                    ? theme.colorScheme
                                                        .onSurfaceVariant
                                                        .withValues(alpha: 0.5)
                                                    : theme.colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // Item total - right aligned with min width
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 80,
                                      ),
                                      child: Text(
                                        item.total.toCurrency(),
                                        style:
                                            theme.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.primary,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Footer with total and checkout
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Cart summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Total (${cartItems.length} items)',
                          style: theme.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        total.toCurrency(),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      // Clear cart button
                      if (cartItems.isNotEmpty)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isSyncing
                                ? null
                                : () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Clear Cart'),
                                        content: const Text(
                                          'Are you sure you want to clear all items from the cart?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancel'),
                                          ),
                                          FilledButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Clear'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      ref
                                          .read(cartControllerProvider.notifier)
                                          .clearCart();
                                    }
                                  },
                            child: const Text('Clear'),
                          ),
                        ),
                      if (cartItems.isNotEmpty) const SizedBox(width: 12),

                      // Checkout button
                      Expanded(
                        flex: 2,
                        child: FilledButton.icon(
                          onPressed: cartItems.isEmpty || isSyncing
                              ? null
                              : () => showCheckoutDialog(context),
                          icon: const Icon(Icons.shopping_cart_checkout),
                          label: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Shows a dialog to edit the quantity of a cart item.
Future<int?> _showQuantityDialog(BuildContext context, int currentQuantity) async {
  final formKey = GlobalKey<FormBuilderState>();

  return showDialog<int>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit Quantity'),
      content: FormBuilder(
        key: formKey,
        child: FormBuilderTextField(
          name: 'quantity',
          initialValue: currentQuantity.toString(),
          decoration: const InputDecoration(
            labelText: 'Quantity',
            hintText: 'Enter quantity',
          ),
          keyboardType: TextInputType.number,
          autofocus: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
            FormBuilderValidators.min(0),
          ]),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState?.saveAndValidate() ?? false) {
              final quantity = int.tryParse(
                formKey.currentState?.fields['quantity']?.value ?? '',
              );
              Navigator.pop(context, quantity);
            }
          },
          child: const Text('Update'),
        ),
      ],
    ),
  );
}
