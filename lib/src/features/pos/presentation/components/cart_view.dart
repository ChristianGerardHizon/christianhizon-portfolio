import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../cart_controller.dart';
import 'checkout_sheet.dart';

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant
                                .withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Cart is empty',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add products from the grid',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withOpacity(0.7),
                            ),
                          ),
                        ],
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
                            child: Row(
                              children: [
                                // Product info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: theme.textTheme.titleSmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₱${product.price.toStringAsFixed(2)} each',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color:
                                              theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Quantity controls
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      iconSize: 20,
                                      onPressed: isSyncing
                                          ? null
                                          : () {
                                              ref
                                                  .read(cartControllerProvider
                                                      .notifier)
                                                  .updateQuantity(
                                                    product,
                                                    item.quantity.toInt() - 1,
                                                  );
                                            },
                                    ),
                                    SizedBox(
                                      width: 32,
                                      child: Text(
                                        '${item.quantity.toInt()}',
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      iconSize: 20,
                                      onPressed: isSyncing
                                          ? null
                                          : () {
                                              ref
                                                  .read(cartControllerProvider
                                                      .notifier)
                                                  .updateQuantity(
                                                    product,
                                                    item.quantity.toInt() + 1,
                                                  );
                                            },
                                    ),
                                  ],
                                ),

                                // Item total
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    '₱${item.total.toStringAsFixed(2)}',
                                    textAlign: TextAlign.right,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // Delete button
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: theme.colorScheme.error,
                                  ),
                                  iconSize: 20,
                                  onPressed: isSyncing
                                      ? null
                                      : () {
                                          ref
                                              .read(
                                                  cartControllerProvider.notifier)
                                              .removeFromCart(product);
                                        },
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
                      Text(
                        'Total (${cartItems.length} items)',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        '₱${total.toStringAsFixed(2)}',
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
                              : () => showCheckoutSheet(context),
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
