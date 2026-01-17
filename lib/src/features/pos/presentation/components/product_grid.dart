import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../products/data/repositories/product_repository.dart';
import '../../../products/domain/product.dart';
import '../cart_controller.dart';

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
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
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

  Future<Either<Failure, List<Product>>> _fetchProducts(WidgetRef ref) {
    final repository = ref.read(productRepositoryProvider);

    if (searchQuery.trim().isEmpty) {
      return repository.fetchAll();
    } else {
      return repository.search(
        searchQuery.trim(),
        fields: ['name', 'description'],
      );
    }
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ref.read(cartControllerProvider.notifier).addToCart(product);
        },
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
    );
  }
}
