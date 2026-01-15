import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../controllers/product_search_controller.dart';

/// Bottom sheet for selecting which fields to include in product search.
class ProductSearchFieldsSheet extends ConsumerWidget {
  const ProductSearchFieldsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final selectedFields = ref.watch(productSearchFieldsProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewPadding.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              t.fields.searchFields,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            Text(
              t.fields.searchFieldsHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // Field checkboxes
            ...productSearchableFields.map((field) {
              final isSelected = selectedFields.contains(field);
              final isLastSelected = isSelected && selectedFields.length == 1;

              return CheckboxListTile(
                value: isSelected,
                onChanged: isLastSelected
                    ? null // Can't deselect the last field
                    : (_) => ref
                        .read(productSearchFieldsProvider.notifier)
                        .toggleField(field),
                title: Text(_getFieldLabel(field, t)),
                subtitle: isLastSelected
                    ? Text(
                        t.fields.atLeastOneRequired,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      )
                    : null,
                dense: true,
                contentPadding: EdgeInsets.zero,
              );
            }),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(productSearchFieldsProvider.notifier).reset();
                    },
                    child: Text(t.common.reset),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(t.common.done),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFieldLabel(String field, Translations t) {
    switch (field) {
      case 'name':
        return t.fields.name;
      case 'description':
        return 'Description';
      case 'category':
        return 'Category';
      default:
        return field;
    }
  }
}

/// Shows the product search fields selection sheet.
void showProductSearchFieldsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => const ProductSearchFieldsSheet(),
  );
}
