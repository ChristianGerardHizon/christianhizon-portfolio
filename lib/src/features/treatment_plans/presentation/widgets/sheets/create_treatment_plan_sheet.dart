import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/presentation/controllers/patient_treatments_controller.dart';
import '../../../domain/treatment_plan.dart';
import '../../../domain/treatment_plan_status.dart';
import '../../controllers/treatment_templates_controller.dart';

/// Bottom sheet for creating a new treatment plan with manually added dates.
class CreateTreatmentPlanSheet extends HookConsumerWidget {
  const CreateTreatmentPlanSheet({
    super.key,
    required this.patientId,
    required this.scrollController,
    required this.onSave,
  });

  final String patientId;
  final ScrollController scrollController;

  /// Callback when saving. Returns the created plan on success, null on failure.
  final Future<TreatmentPlan?> Function(
    TreatmentPlan plan,
    List<DateTime> scheduledDates,
  ) onSave;

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
    final dates = useState<List<DateTime>>([]);
    final errorMessage = useState<String?>(null);

    // Watch treatment catalog
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);

    // Watch templates (optional)
    final templatesAsync = ref.watch(treatmentTemplatesControllerProvider);

    Future<void> addDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 30)),
        lastDate: DateTime.now().add(const Duration(days: 730)),
      );
      if (picked != null) {
        dates.value = [...dates.value, picked];
      }
    }

    void updateDateAt(int index, DateTime newDate) {
      final list = List<DateTime>.from(dates.value);
      list[index] = newDate;
      dates.value = list;
    }

    void removeSessionAt(int index) {
      if (dates.value.length <= 1) return;
      final list = List<DateTime>.from(dates.value);
      list.removeAt(index);
      dates.value = list;
    }

    void onReorder(int oldIndex, int newIndex) {
      final list = List<DateTime>.from(dates.value);
      if (newIndex > oldIndex) newIndex -= 1;
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      dates.value = list;
    }

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

      if (dates.value.isEmpty) {
        errorMessage.value = 'Please add at least one date';
        return;
      }

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final plan = TreatmentPlan(
        id: '',
        patientId: patientId,
        treatmentId: values['treatment'] as String,
        status: TreatmentPlanStatus.active,
        startDate: dates.value.first,
        title: _nullIfEmpty(values['title'] as String?),
        notes: _nullIfEmpty(values['notes'] as String?),
      );

      final created = await onSave(plan, dates.value);

      if (context.mounted) {
        isSaving.value = false;
        if (created != null) {
          context.pop();
          showSuccessSnackBar(
            context,
            message:
                'Treatment plan created with ${dates.value.length} sessions',
          );
        } else {
          errorMessage.value = 'Failed to create treatment plan';
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
                        'Create Treatment Plan',
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
                    onChanged: (treatmentId) {
                      // Check if there's a template for this treatment
                      if (treatmentId != null) {
                        final templates = templatesAsync.value ?? [];
                        final template = templates
                            .where((t) => t.treatmentId == treatmentId)
                            .firstOrNull;
                        if (template != null && template.notes != null) {
                          // Auto-fill notes from template
                          formKey.currentState?.fields['notes']
                              ?.didChange(template.notes);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Sessions Card with ReorderableListView
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Icon(
                              Icons.event_note,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Sessions',
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            TextButton.icon(
                              onPressed: isSaving.value ? null : addDate,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add Date'),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 8),

                        // Empty state or date list
                        if (dates.value.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 48,
                                    color: theme.colorScheme.outlineVariant,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No sessions added yet',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tap "Add Date" to add sessions',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dates.value.length,
                            onReorder: isSaving.value ? (_, __) {} : onReorder,
                            proxyDecorator: (child, index, animation) =>
                                Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(8),
                              child: child,
                            ),
                            itemBuilder: (context, index) => _DraggableDateItem(
                              key: ValueKey(
                                'date_${index}_${dates.value[index].millisecondsSinceEpoch}',
                              ),
                              index: index,
                              date: dates.value[index],
                              canRemove: dates.value.length > 1,
                              enabled: !isSaving.value,
                              onDateChanged: (newDate) =>
                                  updateDateAt(index, newDate),
                              onRemove: () => removeSessionAt(index),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                FormBuilderTextField(
                  name: 'notes',
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Additional notes about this treatment plan',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.notes),
                  ),
                  maxLines: 2,
                  enabled: !isSaving.value,
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

/// A draggable date item in the sessions list.
class _DraggableDateItem extends StatelessWidget {
  const _DraggableDateItem({
    super.key,
    required this.index,
    required this.date,
    required this.canRemove,
    required this.enabled,
    this.onDateChanged,
    this.onRemove,
  });

  final int index;
  final DateTime date;
  final bool canRemove;
  final bool enabled;
  final void Function(DateTime)? onDateChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d, yyyy');

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Drag handle
          ReorderableDragStartListener(
            index: index,
            enabled: enabled,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.drag_handle,
                color: enabled
                    ? theme.colorScheme.outline
                    : theme.colorScheme.outlineVariant,
              ),
            ),
          ),
          const SizedBox(width: 4),

          // Sequence badge
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Date display
          Expanded(
            child: InkWell(
              onTap: !enabled || onDateChanged == null
                  ? null
                  : () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 730)),
                      );
                      if (picked != null) {
                        onDateChanged!(picked);
                      }
                    },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dateFormat.format(date),
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (enabled && onDateChanged != null) ...[
                      const Spacer(),
                      Icon(
                        Icons.edit,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Remove button
          if (canRemove && onRemove != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: enabled ? onRemove : null,
              icon: Icon(
                Icons.close,
                size: 20,
                color: enabled
                    ? theme.colorScheme.error
                    : theme.colorScheme.outlineVariant,
              ),
              tooltip: 'Remove session',
            ),
          ] else
            const SizedBox(width: 48), // Maintain alignment
        ],
      ),
    );
  }
}

/// Shows the create treatment plan sheet.
void showCreateTreatmentPlanSheet(
  BuildContext context, {
  required String patientId,
  required Future<TreatmentPlan?> Function(
    TreatmentPlan plan,
    List<DateTime> scheduledDates,
  ) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => CreateTreatmentPlanSheet(
        patientId: patientId,
        scrollController: scrollController,
        onSave: onSave,
      ),
    ),
  );
}
