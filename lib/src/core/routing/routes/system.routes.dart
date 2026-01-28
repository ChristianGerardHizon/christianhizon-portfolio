import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/products/domain/product_category.dart';
import '../../../features/settings/domain/message_template.dart';
import '../../../features/settings/presentation/controllers/message_templates_controller.dart';
import '../../../features/settings/presentation/controllers/product_categories_controller.dart';
import '../../../features/patients/presentation/controllers/patient_treatments_controller.dart';
import '../../../features/settings/presentation/controllers/species_controller.dart';
import '../../../features/settings/presentation/pages/system_shell.dart';
import '../../../features/settings/presentation/widgets/message_template_detail_panel.dart';
import '../../../features/settings/presentation/widgets/dialogs/product_category_form_dialog.dart';
import '../../../features/settings/presentation/widgets/product_category_detail_panel.dart';
import '../../../features/settings/presentation/widgets/dialogs/message_template_form_dialog.dart';
import '../../../features/settings/presentation/widgets/species_detail_panel.dart';
import '../../../features/settings/presentation/widgets/treatment_type_detail_panel.dart';
import '../../../features/settings/presentation/widgets/printer_config_detail_panel.dart';
import '../../../features/settings/presentation/widgets/theme_settings_panel.dart';
import '../../../features/settings/presentation/controllers/printer_configs_controller.dart';
import '../../../features/settings/presentation/widgets/dialogs/printer_config_form_dialog.dart';
import '../../utils/breakpoints.dart';

part 'system.routes.g.dart';

/// System shell route for 3-panel layout.
///
/// On tablet: Shows nav rail + list + detail side-by-side
/// On mobile: Shows landing page, then list, then detail
@TypedShellRoute<SystemShellRoute>(
  routes: [
    TypedGoRoute<SystemRoute>(
      path: SystemRoute.path,
      routes: [
        // Species with detail (breeds managed within species detail)
        TypedGoRoute<SpeciesRoute>(
          path: 'species',
          routes: [
            TypedGoRoute<SpeciesDetailRoute>(path: ':id'),
          ],
        ),
        // Product categories with detail
        TypedGoRoute<ProductCategoriesRoute>(
          path: 'product-categories',
          routes: [
            TypedGoRoute<ProductCategoryDetailRoute>(path: ':id'),
          ],
        ),
        // Message templates with detail
        TypedGoRoute<MessageTemplatesRoute>(
          path: 'message-templates',
          routes: [
            TypedGoRoute<MessageTemplateDetailRoute>(path: ':id'),
          ],
        ),
        // Treatment types with detail
        TypedGoRoute<TreatmentTypesRoute>(
          path: 'treatment-types',
          routes: [
            TypedGoRoute<TreatmentTypeDetailRoute>(path: ':id'),
          ],
        ),
        // Printer settings with detail
        TypedGoRoute<PrinterSettingsRoute>(
          path: 'printers',
          routes: [
            TypedGoRoute<PrinterDetailRoute>(path: ':id'),
          ],
        ),
        // Appearance/theme settings
        TypedGoRoute<AppearanceRoute>(path: 'appearance'),
      ],
    ),
  ],
)
class SystemShellRoute extends ShellRouteData {
  const SystemShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return SystemShell(child: navigator);
  }
}

/// System root route.
///
/// On tablet: Redirects to /system/species (3-panel layout)
/// On mobile: Shows landing page with Species/Categories/Templates options
class SystemRoute extends GoRouteData with $SystemRoute {
  const SystemRoute();

  static const path = '/system';

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    // Only redirect on tablet - mobile shows landing page
    if (Breakpoints.isTabletOrLarger(context) && state.uri.path == path) {
      return '$path/species';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Mobile: Show landing page with options
    return const _MobileSystemLandingPage();
  }
}

/// Species management route.
class SpeciesRoute extends GoRouteData with $SpeciesRoute {
  const SpeciesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show species list
    return const _MobileSpeciesListPage();
  }
}

/// Species detail route.
class SpeciesDetailRoute extends GoRouteData with $SpeciesDetailRoute {
  const SpeciesDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SpeciesDetailPanel(speciesId: id);
  }
}

/// Product categories management route.
class ProductCategoriesRoute extends GoRouteData with $ProductCategoriesRoute {
  const ProductCategoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show categories list
    return const _MobileProductCategoriesListPage();
  }
}

/// Product category detail route.
class ProductCategoryDetailRoute extends GoRouteData
    with $ProductCategoryDetailRoute {
  const ProductCategoryDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCategoryDetailPanel(categoryId: id);
  }
}

/// Message templates management route.
class MessageTemplatesRoute extends GoRouteData with $MessageTemplatesRoute {
  const MessageTemplatesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show templates list
    return const _MobileMessageTemplatesListPage();
  }
}

/// Message template detail route.
class MessageTemplateDetailRoute extends GoRouteData
    with $MessageTemplateDetailRoute {
  const MessageTemplateDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MessageTemplateDetailPanel(templateId: id);
  }
}

/// Treatment types management route.
class TreatmentTypesRoute extends GoRouteData with $TreatmentTypesRoute {
  const TreatmentTypesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show treatment types list
    return const _MobileTreatmentTypesListPage();
  }
}

/// Treatment type detail route.
class TreatmentTypeDetailRoute extends GoRouteData
    with $TreatmentTypeDetailRoute {
  const TreatmentTypeDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TreatmentTypeDetailPanel(treatmentId: id);
  }
}

/// Printer settings management route.
class PrinterSettingsRoute extends GoRouteData with $PrinterSettingsRoute {
  const PrinterSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, handled by shell - return empty
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    // Mobile: Show printers list
    return const _MobilePrinterListPage();
  }
}

/// Printer detail route.
class PrinterDetailRoute extends GoRouteData with $PrinterDetailRoute {
  const PrinterDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PrinterConfigDetailPanel(printerId: id);
  }
}

/// Appearance/theme settings route.
class AppearanceRoute extends GoRouteData with $AppearanceRoute {
  const AppearanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ThemeSettingsPanel();
  }
}

// ============================================================================
// Mobile Pages
// ============================================================================

/// Mobile landing page for system settings with option cards.
class _MobileSystemLandingPage extends StatelessWidget {
  const _MobileSystemLandingPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _SystemOptionCard(
                icon: Icons.pets,
                title: 'Species & Breeds',
                description: 'Manage patient species and their breeds',
                color: theme.colorScheme.primary,
                onTap: () => const SpeciesRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _SystemOptionCard(
                icon: Icons.inventory_2,
                title: 'Product Categories',
                description: 'Manage product category hierarchy',
                color: theme.colorScheme.secondary,
                onTap: () => const ProductCategoriesRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _SystemOptionCard(
                icon: Icons.chat_bubble,
                title: 'Message Templates',
                description: 'Manage SMS message templates',
                color: theme.colorScheme.tertiary,
                onTap: () => const MessageTemplatesRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _SystemOptionCard(
                icon: Icons.medical_services,
                title: 'Treatment Types',
                description: 'Manage patient treatment categories',
                color: Colors.teal,
                onTap: () => const TreatmentTypesRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _SystemOptionCard(
                icon: Icons.print,
                title: 'Printers',
                description: 'Configure thermal receipt printers',
                color: Colors.orange,
                onTap: () => const PrinterSettingsRoute().go(context),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _SystemOptionCard(
                icon: Icons.palette,
                title: 'Appearance',
                description: 'Customize app theme and colors',
                color: Colors.purple,
                onTap: () => const AppearanceRoute().go(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for system option selection.
class _SystemOptionCard extends StatelessWidget {
  const _SystemOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile species list page.
class _MobileSpeciesListPage extends ConsumerWidget {
  const _MobileSpeciesListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final speciesAsync = ref.watch(speciesControllerProvider);
    final controller = ref.read(speciesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Species & Breeds'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'species_fab',
        onPressed: () => const SpeciesDetailRoute(id: 'new').push(context),
        child: const Icon(Icons.add),
      ),
      body: speciesAsync.when(
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
        data: (speciesList) {
          if (speciesList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No species yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a species',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: ListView.builder(
              itemCount: speciesList.length,
              itemBuilder: (context, index) {
                final species = speciesList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.pets_outlined,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(species.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      SpeciesDetailRoute(id: species.id).push(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Mobile product categories list page.
class _MobileProductCategoriesListPage extends ConsumerWidget {
  const _MobileProductCategoriesListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final categoriesAsync = ref.watch(productCategoriesControllerProvider);
    final controller = ref.read(productCategoriesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'product_category_fab',
        onPressed: () => showProductCategoryFormDialog(context),
        tooltip: 'Add Category',
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
                    _MobileCategoryListTile(
                      category: category,
                      isChild: false,
                      onTap: () => ProductCategoryDetailRoute(id: category.id)
                          .push(context),
                    ),
                    ...children.map((child) => Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: _MobileCategoryListTile(
                            category: child,
                            isChild: true,
                            onTap: () =>
                                ProductCategoryDetailRoute(id: child.id)
                                    .push(context),
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

class _MobileCategoryListTile extends StatelessWidget {
  const _MobileCategoryListTile({
    required this.category,
    required this.isChild,
    required this.onTap,
  });

  final ProductCategory category;
  final bool isChild;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isChild
            ? theme.colorScheme.secondaryContainer
            : theme.colorScheme.primaryContainer,
        child: Icon(
          isChild ? Icons.subdirectory_arrow_right : Icons.inventory_2_outlined,
          color: isChild
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

/// Mobile message templates list page.
class _MobileMessageTemplatesListPage extends ConsumerWidget {
  const _MobileMessageTemplatesListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final templatesAsync = ref.watch(messageTemplatesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Templates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateSheet(context),
            tooltip: 'Add Template',
          ),
        ],
      ),
      body: templatesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    ref.invalidate(messageTemplatesControllerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (templates) {
          if (templates.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No templates yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a template',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          // Group by category
          final grouped = ref
              .read(messageTemplatesControllerProvider.notifier)
              .groupedByCategory;
          final categories = grouped.keys.toList()..sort();

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryTemplates = grouped[category]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index > 0) const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      category,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ...categoryTemplates.map((template) =>
                      _MobileTemplateListTile(
                        template: template,
                        onTap: () => MessageTemplateDetailRoute(id: template.id)
                            .push(context),
                      )),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showCreateSheet(BuildContext context) {
    showMessageTemplateFormDialog(context);
  }
}

class _MobileTemplateListTile extends StatelessWidget {
  const _MobileTemplateListTile({
    required this.template,
    required this.onTap,
  });

  final MessageTemplate template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
        leading: Icon(
          Icons.message_outlined,
          color: theme.colorScheme.outline,
          size: 20,
        ),
        title: Text(template.name),
        subtitle: Text(
          template.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

/// Mobile treatment types list page.
class _MobileTreatmentTypesListPage extends ConsumerWidget {
  const _MobileTreatmentTypesListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);
    final controller = ref.read(patientTreatmentsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatment Types'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'treatment_type_fab',
        onPressed: () => const TreatmentTypeDetailRoute(id: 'new').push(context),
        child: const Icon(Icons.add),
      ),
      body: treatmentsAsync.when(
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
        data: (treatments) {
          if (treatments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No treatment types yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a treatment type',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: ListView.builder(
              itemCount: treatments.length,
              itemBuilder: (context, index) {
                final treatment = treatments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(treatment.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      TreatmentTypeDetailRoute(id: treatment.id).push(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Mobile printer list page.
class _MobilePrinterListPage extends ConsumerWidget {
  const _MobilePrinterListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final printersAsync = ref.watch(printerConfigsControllerProvider);
    final controller = ref.read(printerConfigsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Printers'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'printer_fab',
        onPressed: () => _showCreateSheet(context),
        child: const Icon(Icons.add),
      ),
      body: printersAsync.when(
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
        data: (printers) {
          if (printers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.print_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No printers configured',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a printer',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: ListView.builder(
              itemCount: printers.length,
              itemBuilder: (context, index) {
                final printer = printers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      printer.connectionType.icon,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(child: Text(printer.name)),
                      if (printer.isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Default',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Text(
                    '${printer.connectionType.displayName} • ${printer.paperWidth.displayName}',
                  ),
                  trailing: printer.isEnabled
                      ? const Icon(Icons.chevron_right)
                      : Icon(Icons.block, color: theme.colorScheme.error),
                  onTap: () => PrinterDetailRoute(id: printer.id).push(context),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showCreateSheet(BuildContext context) {
    showPrinterConfigFormDialog(context);
  }
}
