import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/presentation/controllers/patient_treatments_controller.dart';
import '../../../domain/treatment_plan.dart';

/// Bottom sheet for editing an existing treatment plan.
class EditTreatmentPlanSheet extends HookConsumerWidget {
  const EditTreatmentPlanSheet({
    super.key,
    required this.plan,
    required this.scrollController,
    required this.onSave,
  });

  final TreatmentPlan plan;
  final ScrollController scrollController;

  /// Callback when saving. Returns true on success, false on failure.
  final Future<bool> Function(TreatmentPlan updatedPlan) onSave;

  static const _fieldLabels = {
    'treatment': 'Treatment Type',
    'notes': 'Notes',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final errorMessage = useState<String?>(null);

    // Watch treatment catalog
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);

    Future<void> handleSave() async {
      // Clear any previous error
      errorMessage.value = null;

      final isValid = formKey.currentState!.saveAndValidate();

      if (!isValid) {
        final errors = formKey.currentState?.errors ?? {};
        final errorMessages = formatFormErrors(errors, _fieldLabels);
        if (errorMessages.isNotEmpty) {
          errorMessage.value = errorMessages.join('\n');
        }
        return;
      }

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final updatedPlan = plan.copyWith(
        title: _nullIfEmpty(values['title'] as String?),
        treatmentId: values['treatment'] as String,
        notes: _nullIfEmpty(values['notes'] as String?),
      );

      final success = await onSave(updatedPlan);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          context.pop();
          showSuccessSnackBar(
            context,
            message: 'Treatment plan updated',
          );
        } else {
          errorMessage.value = 'Failed to update treatment plan';
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
                        'Edit Treatment Plan',
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

                // Plan Title (Optional)
                FormBuilderTextField(
                  name: 'title',
                  initialValue: plan.title ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Plan Title (Optional)',
                    hintText: 'Leave empty to auto-generate',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  enabled: !isSaving.value,
                ),
                const SizedBox(height: 16),

                // Treatment Type Dropdown
                treatmentsAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => Text(
                    'Failed to load treatments',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  data: (treatments) => FormBuilderDropdown<String>(
                    name: 'treatment',
                    initialValue: plan.treatmentId,
                    decoration: const InputDecoration(
                      labelText: 'Treatment Type *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                    enabled: !isSaving.value,
                    validator: FormBuilderValidators.required(
                      errorText: 'Treatment type is required',
                    ),
                    items: treatments
                        .map(
                          (treatment) => DropdownMenuItem(
                            value: treatment.id,
                            child: Text(treatment.name),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                FormBuilderTextField(
                  name: 'notes',
                  initialValue: plan.notes ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Additional notes about this treatment plan',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.notes),
                  ),
                  maxLines: 3,
                  enabled: !isSaving.value,
                ),

                // Info card about sessions
                const SizedBox(height: 16),
                Card(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Sessions are managed separately. Use the session menu to reschedule or add new sessions.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Error message banner
                if (errorMessage.value != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.error.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.onErrorContainer,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            errorMessage.value!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => errorMessage.value = null,
                          icon: Icon(
                            Icons.close,
                            size: 18,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _nullIfEmpty(String? text) {
    if (text == null) return null;
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

/// Shows the edit treatment plan sheet.
void showEditTreatmentPlanSheet(
  BuildContext context, {
  required TreatmentPlan plan,
  required Future<bool> Function(TreatmentPlan updatedPlan) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => EditTreatmentPlanSheet(
        plan: plan,
        scrollController: scrollController,
        onSave: onSave,
      ),
    ),
  );
}
