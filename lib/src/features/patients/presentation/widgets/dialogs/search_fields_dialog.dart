import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../controllers/patient_search_controller.dart';

/// Dialog for selecting which fields to include in patient search.
class SearchFieldsDialog extends ConsumerWidget {
  const SearchFieldsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final selectedFields = ref.watch(patientSearchFieldsProvider);

    return DialogCloseHandler(
      child: ConstrainedDialogContent(
        maxWidth: DialogConstraints.compactMaxWidth,
        child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    t.fields.searchFields,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.fields.searchFieldsHint,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Field checkboxes
                  ...patientSearchableFields.map((field) {
                    final isSelected = selectedFields.contains(field);
                    final isLastSelected =
                        isSelected && selectedFields.length == 1;

                    return CheckboxListTile(
                      value: isSelected,
                      onChanged: isLastSelected
                          ? null // Can't deselect the last field
                          : (_) => ref
                              .read(patientSearchFieldsProvider.notifier)
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
                ],
              ),
            ),
          ),

          // Footer buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(patientSearchFieldsProvider.notifier).reset();
                    },
                    child: Text(t.common.reset),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => context.pop(),
                    child: Text(t.common.done),
                  ),
                ),
              ],
            ),
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
      case 'owner':
        return t.fields.owner;
      case 'species':
        return t.fields.species;
      case 'breed':
        return t.fields.breed;
      case 'contactNumber':
        return t.fields.contactNumber;
      case 'email':
        return t.fields.email;
      case 'address':
        return t.fields.address;
      default:
        return field;
    }
  }
}

/// Shows the search fields selection dialog.
void showSearchFieldsDialog(BuildContext context) {
  showConstrainedDialog(
    context: context,
    maxWidth: DialogConstraints.compactMaxWidth,
    builder: (context) => const SearchFieldsDialog(),
  );
}
