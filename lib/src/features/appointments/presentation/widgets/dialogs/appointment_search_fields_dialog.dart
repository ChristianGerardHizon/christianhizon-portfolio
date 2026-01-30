import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../controllers/appointment_search_controller.dart';

/// Dialog for selecting which fields to include in appointment search.
class AppointmentSearchFieldsDialog extends ConsumerWidget {
  const AppointmentSearchFieldsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final selectedFields = ref.watch(appointmentSearchFieldsProvider);

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
                    ...appointmentSearchableFields.map((field) {
                      final isSelected = selectedFields.contains(field);
                      final isLastSelected =
                          isSelected && selectedFields.length == 1;

                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: isLastSelected
                            ? null // Can't deselect the last field
                            : (_) => ref
                                .read(appointmentSearchFieldsProvider.notifier)
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
                        ref
                            .read(appointmentSearchFieldsProvider.notifier)
                            .reset();
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
      case 'patientName':
        return t.fields.name;
      case 'ownerName':
        return t.fields.owner;
      case 'purpose':
        return 'Purpose';
      case 'ownerContact':
        return t.fields.contactNumber;
      case 'notes':
        return 'Notes';
      default:
        return field;
    }
  }
}

/// Shows the appointment search fields selection dialog.
void showAppointmentSearchFieldsDialog(BuildContext context) {
  showConstrainedDialog(
    context: context,
    maxWidth: DialogConstraints.compactMaxWidth,
    builder: (context) => const AppointmentSearchFieldsDialog(),
  );
}
