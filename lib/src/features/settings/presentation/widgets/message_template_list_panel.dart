import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../domain/message_template.dart';
import '../controllers/message_templates_controller.dart';
import 'sheets/message_template_form_sheet.dart';

/// List panel for message templates (tablet master-detail layout).
class MessageTemplateListPanel extends ConsumerWidget {
  const MessageTemplateListPanel({
    super.key,
    this.selectedId,
    this.onTemplateSelected,
  });

  final String? selectedId;
  final ValueChanged<MessageTemplate>? onTemplateSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final templatesAsync = ref.watch(messageTemplatesControllerProvider);

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Message Templates',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showCreateSheet(context),
                tooltip: 'Add Template',
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: templatesAsync.when(
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
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          color: isSelected
                              ? theme.colorScheme.primaryContainer
                              : null,
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
                            onTap: () {
                              if (onTemplateSelected != null) {
                                onTemplateSelected!(template);
                              }
                              MessageTemplateDetailRoute(id: template.id)
                                  .go(context);
                            },
                          ),
                        );
                      }),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showCreateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) => const MessageTemplateFormSheet(),
    );
  }
}
