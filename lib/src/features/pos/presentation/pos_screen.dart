import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'components/cart_view.dart';
import 'components/product_grid.dart';

class PosScreen extends ConsumerWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System'),
      ),
      body: ScreenTypeLayout.builder(
        mobile: (context) => const _MobileLayout(),
        tablet: (context) => const _DesktopLayout(),
        desktop: (context) => const _DesktopLayout(),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product Grid Area
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              // Search Bar could go here
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search products...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(child: ProductGrid()),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        // Cart Area
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.grey[50],
            child: const CartView(),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    // For mobile, maybe tabs or a different flow?
    // For now, simple column, but POS is usually tablet/desktop.
    return const Column(
      children: [
         Expanded(child: ProductGrid()),
         Divider(),
         SizedBox(height: 200, child: CartView()),
      ],
    );
  }
}
