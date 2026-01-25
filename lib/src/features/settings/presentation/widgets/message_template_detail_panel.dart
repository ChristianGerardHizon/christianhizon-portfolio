import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../data/repositories/message_template_repository.dart';
import '../../domain/message_template.dart';
import '../controllers/message_templates_controller.dart';
import 'sheets/message_template_form_sheet.dart';

/// Detail panel for viewing/editing a message template.
class MessageTemplateDetailPanel extends ConsumerWidget {
  const MessageTemplateDetailPanel({
    super.key,
    required this.templateId,
  });

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return FutureBuilder<Either<Failure, MessageTemplate>>(
      future: ref.read(messageTemplateRepositoryProvider).fetchOne(templateId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Template not found',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        final result = snapshot.data!;
        return result.fold(
          (failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load template',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          (template) => _TemplateDetailContent(template: template),
        );
      },
    );
  }
}

class _TemplateDetailContent extends ConsumerWidget {
  const _TemplateDetailContent({required this.template});

  final MessageTemplate template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(template.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _showEditSheet(context),
            tooltip: 'Edit',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
            tooltip: 'Delete',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            if (template.category != null) ...[
              Text(
                'Category',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 4),
              Chip(
                label: Text(template.category!),
                backgroundColor: theme.colorScheme.primaryContainer,
                labelStyle: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Content
            Text(
              'Message Content',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _HighlightedContent(content: template.content),
            ),
            const SizedBox(height: 24),

            // Placeholders used
            if (template.usedPlaceholders.isNotEmpty) ...[
              Text(
                'Placeholders Used',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: template.usedPlaceholders
                    .map((p) => Chip(
                          label: Text(p),
                          backgroundColor: theme.colorScheme.tertiaryContainer,
                          labelStyle: TextStyle(
                            color: theme.colorScheme.onTertiaryContainer,
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ))
                    .toList(),
              ),
            ],

            // Treatment warning
            if (template.usesTreatmentData) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.tertiary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This template uses treatment data. Make sure a treatment is linked when using this template.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) => MessageTemplateFormSheet(template: template),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Template'),
        content: Text('Are you sure you want to delete "${template.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(messageTemplatesControllerProvider.notifier)
          .deleteTemplate(template.id);

      if (success && context.mounted) {
        showSuccessSnackBar(context, message: 'Template deleted');
        Navigator.of(context).pop();
      }
    }
  }
}

/// Widget that highlights placeholders in the template content.
class _HighlightedContent extends StatelessWidget {
  const _HighlightedContent({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spans = <TextSpan>[];

    // Regex to find placeholders
    final regex = RegExp(r'\{[a-zA-Z]+\}');
    int lastEnd = 0;

    for (final match in regex.allMatches(content)) {
      // Add text before the placeholder
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: content.substring(lastEnd, match.start)));
      }

      // Add the highlighted placeholder
      spans.add(TextSpan(
        text: match.group(0),
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
          backgroundColor:
              theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
        ),
      ));

      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < content.length) {
      spans.add(TextSpan(text: content.substring(lastEnd)));
    }

    return SelectableText.rich(
      TextSpan(
        style: theme.textTheme.bodyLarge,
        children: spans,
      ),
    );
  }
}
