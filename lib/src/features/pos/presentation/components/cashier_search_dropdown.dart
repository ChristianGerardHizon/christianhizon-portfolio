import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/currency_format.dart';
import '../../../products/data/repositories/product_repository.dart';
import '../../../products/domain/product.dart';
import '../../../services/data/repositories/service_repository.dart';
import '../../../services/domain/service.dart';
import '../cart_controller.dart';
import 'lot_selection_dialog.dart';
import 'variable_price_dialog.dart';

/// A search field with a dropdown overlay that shows matching products/services.
///
/// Used in the grouped cashier view to search across all items.
/// Tapping a result adds it to the cart directly.
class CashierSearchDropdown extends HookConsumerWidget {
  const CashierSearchDropdown({
    super.key,
    this.isDense = false,
  });

  final bool isDense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final layerLink = useMemoized(() => LayerLink());
    final overlayEntry = useState<OverlayEntry?>(null);
    final focusNode = useFocusNode();

    // Debounce search
    useEffect(() {
      void listener() => searchQuery.value = searchController.text;
      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    // Show/hide overlay based on search query and focus
    useEffect(() {
      if (searchQuery.value.trim().isNotEmpty && focusNode.hasFocus) {
        _showOverlay(
          context,
          ref,
          layerLink,
          overlayEntry,
          searchQuery.value,
          searchController,
        );
      } else {
        _removeOverlay(overlayEntry);
      }
      return null;
    }, [searchQuery.value]);

    // Clean up overlay on dispose
    useEffect(() {
      return () => _removeOverlay(overlayEntry);
    }, []);

    return CompositedTransformTarget(
      link: layerLink,
      child: TextField(
        controller: searchController,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search products & services...',
          border: const OutlineInputBorder(),
          isDense: isDense,
          suffixIcon: searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    _removeOverlay(overlayEntry);
                  },
                )
              : null,
        ),
        onTap: () {
          if (searchQuery.value.trim().isNotEmpty) {
            _showOverlay(
              context,
              ref,
              layerLink,
              overlayEntry,
              searchQuery.value,
              searchController,
            );
          }
        },
      ),
    );
  }

  void _showOverlay(
    BuildContext context,
    WidgetRef ref,
    LayerLink layerLink,
    ValueNotifier<OverlayEntry?> overlayEntry,
    String query,
    TextEditingController searchController,
  ) {
    _removeOverlay(overlayEntry);

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => _SearchDropdownOverlay(
        link: layerLink,
        query: query,
        ref: ref,
        onItemSelected: () {
          searchController.clear();
          _removeOverlay(overlayEntry);
        },
        onDismiss: () {
          _removeOverlay(overlayEntry);
        },
      ),
    );

    overlayEntry.value = entry;
    overlay.insert(entry);
  }

  void _removeOverlay(ValueNotifier<OverlayEntry?> overlayEntry) {
    overlayEntry.value?.remove();
    overlayEntry.value = null;
  }
}

class _SearchDropdownOverlay extends StatelessWidget {
  const _SearchDropdownOverlay({
    required this.link,
    required this.query,
    required this.ref,
    required this.onItemSelected,
    required this.onDismiss,
  });

  final LayerLink link;
  final String query;
  final WidgetRef ref;
  final VoidCallback onItemSelected;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dismiss barrier
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ),
        // Dropdown
        CompositedTransformFollower(
          link: link,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 4),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
                maxWidth: 500,
              ),
              child: _SearchResultsList(
                query: query,
                ref: ref,
                onItemSelected: onItemSelected,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({
    required this.query,
    required this.ref,
    required this.onItemSelected,
  });

  final String query;
  final WidgetRef ref;
  final VoidCallback onItemSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _searchAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final results = snapshot.data ?? [];

        if (results.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'No results for "$query"',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return item.when(
              product: (product) => _ProductResultTile(
                product: product,
                ref: ref,
                onSelected: onItemSelected,
              ),
              service: (service) => _ServiceResultTile(
                service: service,
                ref: ref,
                onSelected: onItemSelected,
              ),
            );
          },
        );
      },
    );
  }

  Future<List<_SearchResult>> _searchAll() async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final productRepo = ref.read(productRepositoryProvider);
    final serviceRepo = ref.read(serviceRepositoryProvider);

    final results = await Future.wait([
      productRepo.search(trimmed, fields: ['name', 'description']),
      serviceRepo.search(trimmed, fields: ['name', 'description']),
    ]);

    final items = <_SearchResult>[];

    results[0].fold(
      (_) {},
      (products) {
        for (final product in (products as List<Product>)) {
          if (product.forSale && !product.isDeleted) {
            items.add(_SearchResult.product(product));
          }
        }
      },
    );

    results[1].fold(
      (_) {},
      (services) {
        for (final service in (services as List<Service>)) {
          if (!service.isDeleted) {
            items.add(_SearchResult.service(service));
          }
        }
      },
    );

    return items;
  }
}

class _ProductResultTile extends StatelessWidget {
  const _ProductResultTile({
    required this.product,
    required this.ref,
    required this.onSelected,
  });

  final Product product;
  final WidgetRef ref;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      leading: Icon(Icons.inventory_2, color: theme.colorScheme.primary),
      title: Text(product.name),
      subtitle: Text(
        product.isVariablePrice
            ? 'Variable price'
            : product.price.toCurrency(),
      ),
      trailing: Text(
        'Product',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
      onTap: () {
        _handleTap(context);
        onSelected();
      },
    );
  }

  void _handleTap(BuildContext context) {
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    if (product.trackByLot) {
      showLotSelectionDialog(
        context,
        product: product,
        onLotSelected: (lot, quantity) {
          if (product.isVariablePrice) {
            showVariablePriceDialog(context, productName: product.name)
                .then((price) {
              if (price != null) {
                cartNotifier.addToCartWithLot(product, lot, quantity,
                    customPrice: price);
              }
            });
          } else {
            cartNotifier.addToCartWithLot(product, lot, quantity);
          }
        },
      );
    } else if (product.isVariablePrice) {
      showVariablePriceDialog(context, productName: product.name)
          .then((price) {
        if (price != null) {
          cartNotifier.addToCart(product, customPrice: price);
        }
      });
    } else {
      cartNotifier.addToCart(product);
    }
  }
}

class _ServiceResultTile extends StatelessWidget {
  const _ServiceResultTile({
    required this.service,
    required this.ref,
    required this.onSelected,
  });

  final Service service;
  final WidgetRef ref;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      leading:
          Icon(Icons.miscellaneous_services, color: theme.colorScheme.tertiary),
      title: Text(service.name),
      subtitle: Text(
        service.hasVariablePrice
            ? 'Variable price'
            : service.price.toCurrency(),
      ),
      trailing: Text(
        'Service',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
      onTap: () {
        _handleTap(context);
        onSelected();
      },
    );
  }

  void _handleTap(BuildContext context) {
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    if (service.hasVariablePrice) {
      showVariablePriceDialog(context, productName: service.name)
          .then((price) {
        if (price != null) {
          cartNotifier.addServiceToCart(service, customPrice: price);
        }
      });
    } else {
      cartNotifier.addServiceToCart(service);
    }
  }
}

/// A union type for search results.
class _SearchResult {
  final Product? _product;
  final Service? _service;

  const _SearchResult.product(Product product)
      : _product = product,
        _service = null;

  const _SearchResult.service(Service service)
      : _product = null,
        _service = service;

  T when<T>({
    required T Function(Product product) product,
    required T Function(Service service) service,
  }) {
    if (_product != null) return product(_product);
    return service(_service!);
  }
}
