import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../../patients/domain/patient_treatment.dart';
import '../../../patients/presentation/controllers/patient_treatments_controller.dart';
import '../../../products/domain/product_category.dart';
import '../../domain/message_template.dart';
import '../controllers/message_templates_controller.dart';
import '../controllers/product_categories_controller.dart';
import '../controllers/species_controller.dart';
import '../controllers/printer_configs_controller.dart';
import 'empty_system_state.dart';
import 'dialogs/message_template_form_dialog.dart';
import 'dialogs/printer_config_form_dialog.dart';
import 'system_nav_panel.dart';

/// Three-panel tablet layout for system settings.
///
/// Panel 1 (72px): Navigation rail for Species/Categories/Templates selection
/// Panel 2 (320px): List panel based on current mode
/// Panel 3 (expanded): Detail panel from router or empty state
class TabletSystemLayout extends ConsumerWidget {
  const TabletSystemLayout({
    super.key,
    required this.detailChild,
  });

  /// The detail panel content from the router.
  final Widget detailChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerState = GoRouterState.of(context);
    final path = routerState.uri.path;
    final selectedId = routerState.pathParameters['id'];

    // Determine current mode from path
    final SystemMode currentMode;
    if (path.contains('/product-categories')) {
      currentMode = SystemMode.productCategories;
    } else if (path.contains('/message-templates')) {
      currentMode = SystemMode.messageTemplates;
    } else if (path.contains('/treatment-types')) {
      currentMode = SystemMode.treatmentTypes;
    } else if (path.contains('/printers')) {
      currentMode = SystemMode.printers;
    } else {
      currentMode = SystemMode.speciesBreeds;
    }

    return Row(
      children: [
        // Panel 1: Navigation
        SystemNavPanel(
          currentMode: currentMode,
          onModeChanged: (mode) {
            switch (mode) {
              case SystemMode.speciesBreeds:
                const SpeciesRoute().go(context);
              case SystemMode.productCategories:
                const ProductCategoriesRoute().go(context);
              case SystemMode.messageTemplates:
                const MessageTemplatesRoute().go(context);
              case SystemMode.treatmentTypes:
                const TreatmentTypesRoute().go(context);
              case SystemMode.printers:
                const PrinterSettingsRoute().go(context);
            }
          },
        ),
        const VerticalDivider(width: 1),

        // Panel 2: List
        SizedBox(
          width: 320,
          child: switch (currentMode) {
            SystemMode.speciesBreeds =>
              _SpeciesListWrapper(selectedId: selectedId),
            SystemMode.productCategories =>
              _ProductCategoryListWrapper(selectedId: selectedId),
            SystemMode.messageTemplates =>
              _MessageTemplateListWrapper(selectedId: selectedId),
            SystemMode.treatmentTypes =>
              _TreatmentTypeListWrapper(selectedId: selectedId),
            SystemMode.printers =>
              _PrinterListWrapper(selectedId: selectedId),
          },
        ),
        const VerticalDivider(width: 1),

        // Panel 3: Detail
        Expanded(
          child: selectedId != null
              ? detailChild
              : EmptySystemState(mode: currentMode),
        ),
      ],
    );
  }
}

/// Wrapper for SpeciesListPanel with system-specific navigation.
class _SpeciesListWrapper extends ConsumerWidget {
  const _SpeciesListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final speciesAsync = ref.watch(speciesControllerProvider);
    final controller = ref.read(speciesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Species'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'species_fab',
        onPressed: () => const SpeciesDetailRoute(id: 'new').go(context),
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
                final isSelected = species.id == selectedId;

                return ListTile(
                  selected: isSelected,
                  selectedTileColor:
                      theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.pets_outlined,
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(species.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => SpeciesDetailRoute(id: species.id).go(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Wrapper for ProductCategoryListPanel with system-specific navigation.
class _ProductCategoryListWrapper extends ConsumerWidget {
  const _ProductCategoryListWrapper({required this.selectedId});

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
                      onTap: () =>
                          ProductCategoryDetailRoute(id: category.id).go(context),
                    ),
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

/// Wrapper for MessageTemplateListPanel with system-specific navigation.
class _MessageTemplateListWrapper extends ConsumerWidget {
  const _MessageTemplateListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final templatesAsync = ref.watch(messageTemplatesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Templates'),
        automaticallyImplyLeading: false,
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
                    size: 48,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No templates yet',
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
                  ...categoryTemplates.map((template) {
                    final isSelected = template.id == selectedId;
                    return _MessageTemplateListTile(
                      template: template,
                      isSelected: isSelected,
                      onTap: () =>
                          MessageTemplateDetailRoute(id: template.id).go(context),
                    );
                  }),
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

class _MessageTemplateListTile extends StatelessWidget {
  const _MessageTemplateListTile({
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  final MessageTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: isSelected ? theme.colorScheme.primaryContainer : null,
      child: ListTile(
        dense: true,
        leading: Icon(
          Icons.message_outlined,
          color: isSelected
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.outline,
          size: 20,
        ),
        title: Text(
          template.name,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : null,
          ),
        ),
        subtitle: Text(
          template.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

/// Wrapper for TreatmentTypeListPanel with system-specific navigation.
class _TreatmentTypeListWrapper extends ConsumerWidget {
  const _TreatmentTypeListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);
    final controller = ref.read(patientTreatmentsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatment Types'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'treatment_type_fab',
        onPressed: () => const TreatmentTypeDetailRoute(id: 'new').go(context),
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
                final isSelected = treatment.id == selectedId;

                return ListTile(
                  selected: isSelected,
                  selectedTileColor:
                      theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(treatment.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      TreatmentTypeDetailRoute(id: treatment.id).go(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Wrapper for PrinterListPanel with system-specific navigation.
class _PrinterListWrapper extends ConsumerWidget {
  const _PrinterListWrapper({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final printersAsync = ref.watch(printerConfigsControllerProvider);
    final controller = ref.read(printerConfigsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Printers'),
        automaticallyImplyLeading: false,
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
                final isSelected = printer.id == selectedId;

                return ListTile(
                  selected: isSelected,
                  selectedTileColor:
                      theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer,
                    child: Icon(
                      printer.connectionType.icon,
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onPrimaryContainer,
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
                  onTap: () => PrinterDetailRoute(id: printer.id).go(context),
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
