import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../services/data/repositories/service_repository.dart';
import '../../../services/domain/service.dart';
import '../cart_controller.dart';
import 'quantity_prompt_dialog.dart';
import 'variable_price_dialog.dart';

class ServiceGrid extends ConsumerWidget {
  const ServiceGrid({
    super.key,
    this.searchQuery = '',
  });

  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: _fetchServices(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final result = snapshot.data;
        if (result == null) {
          return const Center(child: Text('No services loaded'));
        }

        return result.fold(
          (failure) => Center(child: Text('Error: ${failure.message}')),
          (services) {
            if (services.isEmpty) {
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
                          ? 'No services found'
                          : 'No services match "$searchQuery"',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount = width < 400
                    ? 3
                    : width < 600
                        ? 4
                        : width < 900
                            ? 5
                            : 6;

                // Adjust aspect ratio based on column count
                // More columns = wider cards, fewer columns = taller cards
                final childAspectRatio = crossAxisCount <= 3 ? 0.9 : 1.3;

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _ServiceCard(service: service);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<Either<Failure, List<Service>>> _fetchServices(WidgetRef ref) async {
    final repository = ref.read(serviceRepositoryProvider);

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

class _ServiceCard extends ConsumerWidget {
  const _ServiceCard({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _handleServiceTap(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service name
              Expanded(
                child: Text(
                  service.name,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              // Price
              Text(
                service.isVariablePrice
                    ? 'Variable'
                    : service.price.toCurrency(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: service.isVariablePrice
                      ? theme.colorScheme.tertiary
                      : theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleServiceTap(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    if (service.isVariablePrice) {
      // Variable price services always show price dialog
      showVariablePriceDialog(
        context,
        productName: service.name,
      ).then((price) {
        if (price != null) {
          if (service.showPrompt) {
            // Also prompt for quantity after price
            showQuantityPromptDialog(
              context,
              serviceName: service.name,
              maxQuantity: service.maxQuantity,
            ).then((quantity) {
              if (quantity != null) {
                cartNotifier.addServiceToCart(
                  service,
                  customPrice: price,
                  quantity: quantity,
                );
              }
            });
          } else {
            cartNotifier.addServiceToCart(service, customPrice: price);
          }
        }
      });
    } else if (service.showPrompt) {
      // Show quantity prompt for non-variable price services
      showQuantityPromptDialog(
        context,
        serviceName: service.name,
        maxQuantity: service.maxQuantity,
      ).then((quantity) {
        if (quantity != null) {
          cartNotifier.addServiceToCart(service, quantity: quantity);
        }
      });
    } else {
      cartNotifier.addServiceToCart(service);
    }
  }
}
