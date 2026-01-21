import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../products/data/repositories/product_repository.dart';
import '../../../products/domain/product.dart';
import '../../../products/domain/product_status.dart';
import '../cart_controller.dart';
import '../providers/pos_product_stock_provider.dart';
import 'lot_selection_sheet.dart';

class ProductGrid extends ConsumerWidget {
  const ProductGrid({
    super.key,
    this.searchQuery = '',
  });

  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: _fetchProducts(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final result = snapshot.data;
        if (result == null) {
          return const Center(child: Text('No products loaded'));
        }

        return result.fold(
          (failure) => Center(child: Text('Error: ${failure.message}')),
          (products) {
            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      searchQuery.isEmpty
                          ? 'No products found'
                          : 'No products match "$searchQuery"',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _ProductCard(product: product);
              },
            );
          },
        );
      },
    );
  }

  Future<Either<Failure, List<Product>>> _fetchProducts(WidgetRef ref) async {
    final repository = ref.read(productRepositoryProvider);

    final Either<Failure, List<Product>> result;
    if (searchQuery.trim().isEmpty) {
      result = await repository.fetchAll();
    } else {
      result = await repository.search(
        searchQuery.trim(),
        fields: ['name', 'description'],
      );
    }

    // Filter to only show products that are for sale
    return result.map(
      (products) => products.where((p) => p.forSale).toList(),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final stockStatusAsync = ref.watch(posProductStockProvider(product));

    return stockStatusAsync.when(
      loading: () => _buildCard(
        context,
        ref,
        theme,
        stockStatus: null,
        isLoading: true,
      ),
      error: (_, __) => _buildCard(
        context,
        ref,
        theme,
        stockStatus: ProductStatus.noThreshold,
      ),
      data: (stockStatus) => _buildCard(
        context,
        ref,
        theme,
        stockStatus: stockStatus,
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme, {
    required ProductStatus? stockStatus,
    bool isLoading = false,
  }) {
    final isOutOfStock = stockStatus == ProductStatus.outOfStock;
    final isLowStock = stockStatus == ProductStatus.lowStock;
    final isDisabled = isOutOfStock && product.requireStock;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isDisabled
            ? () => _showOutOfStockMessage(context)
            : () => _handleProductTap(context, ref),
        child: Stack(
          children: [
            // Main content
            Opacity(
              opacity: isDisabled ? 0.5 : 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: product.image != null && product.image!.isNotEmpty
                          ? Image.network(
                              product.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.inventory_2_outlined,
                                size: 48,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            )
                          : Icon(
                              Icons.inventory_2_outlined,
                              size: 48,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.price.toCurrency(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stock status badge
            if (!isLoading && (isOutOfStock || isLowStock))
              Positioned(
                top: 8,
                right: 8,
                child: _StockBadge(
                  isOutOfStock: isOutOfStock,
                  isLowStock: isLowStock,
                ),
              ),

            // Loading indicator
            if (isLoading)
              Positioned(
                top: 8,
                right: 8,
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleProductTap(BuildContext context, WidgetRef ref) {
    // Capture notifier before async operation to avoid using ref after widget unmount
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    if (product.trackByLot) {
      // Show lot selection sheet for lot-tracked products
      showLotSelectionSheet(
        context,
        product: product,
        onLotSelected: (lot, quantity) {
          cartNotifier.addToCartWithLot(
            product,
            lot,
            quantity,
          );
        },
      );
    } else {
      // Regular add to cart for non-lot products
      cartNotifier.addToCart(product);
    }
  }

  void _showOutOfStockMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} is out of stock'),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({
    required this.isOutOfStock,
    required this.isLowStock,
  });

  final bool isOutOfStock;
  final bool isLowStock;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color color;
    final IconData icon;

    if (isOutOfStock) {
      color = theme.colorScheme.error;
      icon = Icons.cancel_outlined;
    } else if (isLowStock) {
      color = Colors.orange;
      icon = Icons.warning_amber_outlined;
    } else {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
