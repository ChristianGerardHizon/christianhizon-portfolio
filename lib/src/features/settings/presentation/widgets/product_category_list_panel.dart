import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../../products/domain/product_category.dart';
import '../controllers/product_categories_controller.dart';

/// List panel for product categories in tablet two-pane layout.
class ProductCategoryListPanel extends ConsumerWidget {
  const ProductCategoryListPanel({
    super.key,
    this.selectedId,
  });

  /// Currently selected category ID for highlighting.
  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final categoriesAsync = ref.watch(productCategoriesControllerProvider);
    final controller = ref.read(productCategoriesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Categories'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'product_category_fab',
        onPressed: () =>
            const ProductCategoryDetailRoute(id: 'new').go(context),
        child: const Icon(Icons.add),
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No categories yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a category',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          // Build hierarchical display
          final rootCategories =
              categories.where((c) => !c.hasParent).toList();
          final childCategories = categories.where((c) => c.hasParent).toList();

          return RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: ListView.builder(
              itemCount: rootCategories.length,
              itemBuilder: (context, index) {
                final category = rootCategories[index];
                final children = childCategories
                    .where((c) => c.parentId == category.id)
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryListTile(
                      category: category,
                      isSelected: category.id == selectedId,
                      isChild: false,
                      onTap: () => ProductCategoryDetailRoute(id: category.id)
                          .go(context),
                    ),
                    // Show children with indentation
                    ...children.map((child) => Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: _CategoryListTile(
                            category: child,
                            isSelected: child.id == selectedId,
                            isChild: true,
                            onTap: () =>
                                ProductCategoryDetailRoute(id: child.id)
                                    .go(context),
                          ),
                        )),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _CategoryListTile extends StatelessWidget {
  const _CategoryListTile({
    required this.category,
    required this.isSelected,
    required this.isChild,
    required this.onTap,
  });

  final ProductCategory category;
  final bool isSelected;
  final bool isChild;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primaryContainer.withValues(
        alpha: 0.3,
      ),
      leading: CircleAvatar(
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : isChild
                ? theme.colorScheme.secondaryContainer
                : theme.colorScheme.primaryContainer,
        child: Icon(
          isChild ? Icons.subdirectory_arrow_right : Icons.inventory_2_outlined,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : isChild
                  ? theme.colorScheme.onSecondaryContainer
                  : theme.colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(category.name),
      subtitle: category.hasParent && category.parentName != null
          ? Text('Parent: ${category.parentName}')
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
