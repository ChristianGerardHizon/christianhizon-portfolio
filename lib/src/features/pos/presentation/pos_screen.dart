import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'cart_controller.dart';
import 'components/cart_view.dart';
import 'components/product_grid.dart';

class PosScreen extends HookConsumerWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());

    // Debounce search to avoid excessive API calls
    useEffect(() {
      void listener() {
        searchQuery.value = searchController.text;
      }

      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    return ScreenTypeLayout.builder(
      mobile: (context) => _MobileLayout(
        scaffoldKey: scaffoldKey,
        searchController: searchController,
        searchQuery: searchQuery.value,
      ),
      tablet: (context) => _DesktopLayout(
        searchController: searchController,
        searchQuery: searchQuery.value,
      ),
      desktop: (context) => _DesktopLayout(
        searchController: searchController,
        searchQuery: searchQuery.value,
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.searchController,
    required this.searchQuery,
  });

  final TextEditingController searchController;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System'),
      ),
      body: Row(
        children: [
          // Product Grid Area
          Expanded(
            flex: 7,
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search products...',
                      border: const OutlineInputBorder(),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => searchController.clear(),
                            )
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: ProductGrid(searchQuery: searchQuery),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          // Cart Area
          Expanded(
            flex: 3,
            child: Container(
              color: theme.colorScheme.surfaceContainerLowest,
              child: const CartView(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileLayout extends ConsumerWidget {
  const _MobileLayout({
    required this.scaffoldKey,
    required this.searchController,
    required this.searchQuery,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController searchController;
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartState = ref.watch(cartControllerProvider);
    final itemCount = cartState.value?.items.length ?? 0;
    final total = cartState.value?.total ?? 0;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('POS System'),
        actions: [
          // Cart button in app bar
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: Badge(
              isLabelVisible: itemCount > 0,
              label: Text('$itemCount'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.85,
        child: SafeArea(
          child: Column(
            children: [
              // Drawer header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Cart',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              // Cart content
              const Expanded(child: CartView()),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search products...',
                border: const OutlineInputBorder(),
                isDense: true,
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => searchController.clear(),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: ProductGrid(searchQuery: searchQuery),
          ),
        ],
      ),
      // FAB to open cart
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
        icon: Badge(
          isLabelVisible: itemCount > 0,
          label: Text('$itemCount'),
          child: const Icon(Icons.shopping_cart),
        ),
        label: Text('₱${total.toStringAsFixed(2)}'),
      ),
    );
  }
}
