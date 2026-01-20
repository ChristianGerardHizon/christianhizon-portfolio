import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/treatment_plan_item.dart';

/// Bottom sheet for rescheduling a treatment plan item.
class RescheduleItemSheet extends HookConsumerWidget {
  const RescheduleItemSheet({
    super.key,
    required this.item,
    required this.scrollController,
    required this.onSave,
  });

  final TreatmentPlanItem item;
  final ScrollController scrollController;

  /// Callback when saving. Returns true on success, false on failure.
  final Future<bool> Function(DateTime newDate) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final dateFormat = DateFormat('EEE, MMM d, yyyy');

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      if (!isValid) {
        return;
      }

      final values = formKey.currentState!.value;
      final newDate = values['newDate'] as DateTime?;

      if (newDate == null) {
        showErrorSnackBar(context, message: 'Please select a new date');
        return;
      }

      isSaving.value = true;

      final success = await onSave(newDate);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          context.pop();
          showSuccessSnackBar(
            context,
            message: 'Session rescheduled to ${dateFormat.format(newDate)}',
          );
        } else {
          showErrorSnackBar(
            context,
            message: 'Failed to reschedule session',
          );
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            controller: scrollController,
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

                // Header with actions
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Reschedule Session',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: isSaving.value ? null : () => context.pop(),
                      child: Text(t.common.cancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: isSaving.value ? null : handleSave,
                      child: isSaving.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(t.common.save),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Current date info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: item.isOverdue
                                ? theme.colorScheme.errorContainer
                                : theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${item.sequence}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: item.isOverdue
                                    ? theme.colorScheme.onErrorContainer
                                    : theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Session ${item.sequence}',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Current: ',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    dateFormat.format(item.expectedDate),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: item.isOverdue
                                          ? theme.colorScheme.error
                                          : theme.colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  if (item.isOverdue) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.errorContainer,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'OVERDUE',
                                        style:
                                            theme.textTheme.labelSmall?.copyWith(
                                          color:
                                              theme.colorScheme.onErrorContainer,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // New date picker
                FormBuilderDateTimePicker(
                  name: 'newDate',
                  initialValue: item.expectedDate,
                  decoration: InputDecoration(
                    labelText: 'New Date *',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.calendar_today),
                    helperText: 'Select the new date for this session',
                    helperStyle: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  enabled: !isSaving.value,
                  inputType: InputType.date,
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 730)),
                  validator: FormBuilderValidators.required(
                    errorText: 'New date is required',
                  ),
                ),
                const SizedBox(height: 16),

                // Quick select buttons
                Text(
                  'Quick Select',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _QuickSelectChip(
                      label: 'Tomorrow',
                      onTap: isSaving.value
                          ? null
                          : () {
                              final tomorrow = DateTime.now()
                                  .add(const Duration(days: 1));
                              formKey.currentState?.fields['newDate']
                                  ?.didChange(tomorrow);
                            },
                    ),
                    _QuickSelectChip(
                      label: 'In 3 Days',
                      onTap: isSaving.value
                          ? null
                          : () {
                              final date = DateTime.now()
                                  .add(const Duration(days: 3));
                              formKey.currentState?.fields['newDate']
                                  ?.didChange(date);
                            },
                    ),
                    _QuickSelectChip(
                      label: 'Next Week',
                      onTap: isSaving.value
                          ? null
                          : () {
                              final date = DateTime.now()
                                  .add(const Duration(days: 7));
                              formKey.currentState?.fields['newDate']
                                  ?.didChange(date);
                            },
                    ),
                    _QuickSelectChip(
                      label: 'In 2 Weeks',
                      onTap: isSaving.value
                          ? null
                          : () {
                              final date = DateTime.now()
                                  .add(const Duration(days: 14));
                              formKey.currentState?.fields['newDate']
                                  ?.didChange(date);
                            },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickSelectChip extends StatelessWidget {
  const _QuickSelectChip({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      labelStyle: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

/// Shows the reschedule item sheet.
void showRescheduleItemSheet(
  BuildContext context, {
  required TreatmentPlanItem item,
  required Future<bool> Function(DateTime newDate) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) => RescheduleItemSheet(
        item: item,
        scrollController: scrollController,
        onSave: onSave,
      ),
    ),
  );
}
