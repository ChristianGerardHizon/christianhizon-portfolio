import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/prescription.dart';

/// Entry data for a single prescription in the group.
class _PrescriptionEntry {
  _PrescriptionEntry({
    String? medication,
    String? dosage,
    String? instructions,
  })  : medicationController = TextEditingController(text: medication ?? ''),
        dosageController = TextEditingController(text: dosage ?? ''),
        instructionsController =
            TextEditingController(text: instructions ?? ''),
        showInstructions = ValueNotifier(instructions?.isNotEmpty ?? false);

  final TextEditingController medicationController;
  final TextEditingController dosageController;
  final TextEditingController instructionsController;
  final ValueNotifier<bool> showInstructions;

  void dispose() {
    medicationController.dispose();
    dosageController.dispose();
    instructionsController.dispose();
    showInstructions.dispose();
  }

  bool get isValid => medicationController.text.trim().isNotEmpty;

  Prescription toPrescription(String recordId, DateTime date) {
    return Prescription(
      id: '',
      recordId: recordId,
      medication: medicationController.text.trim(),
      dosage: dosageController.text.trim().isEmpty
          ? null
          : dosageController.text.trim(),
      instructions: instructionsController.text.trim().isEmpty
          ? null
          : instructionsController.text.trim(),
      date: date,
    );
  }
}

/// Bottom sheet for adding multiple prescriptions with a shared date.
class AddPrescriptionGroupSheet extends HookConsumerWidget {
  const AddPrescriptionGroupSheet({
    super.key,
    required this.recordId,
    required this.scrollController,
    required this.onSave,
  });

  final String recordId;
  final ScrollController scrollController;
  final Future<bool> Function(Prescription prescription) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final selectedDate = useState(DateTime.now());
    final entries = useState<List<_PrescriptionEntry>>([_PrescriptionEntry()]);
    final isSaving = useState(false);

    // Dispose controllers when widget is disposed
    useEffect(() {
      return () {
        for (final entry in entries.value) {
          entry.dispose();
        }
      };
    }, []);

    void addEntry() {
      entries.value = [...entries.value, _PrescriptionEntry()];
    }

    void removeEntry(int index) {
      if (entries.value.length <= 1) return;
      final entry = entries.value[index];
      final newList = [...entries.value]..removeAt(index);
      entry.dispose();
      entries.value = newList;
    }

    Future<void> selectDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (picked != null) {
        selectedDate.value = picked;
      }
    }

    Future<void> handleSave() async {
      // Validate at least one valid entry
      final validEntries = entries.value.where((e) => e.isValid).toList();
      if (validEntries.isEmpty) {
        showFormErrorDialog(
          context,
          errors: ['Add at least one medication'],
        );
        return;
      }

      // Check all entries have medication filled
      final invalidEntries = entries.value
          .where((e) =>
              e.medicationController.text.trim().isEmpty &&
              (e.dosageController.text.trim().isNotEmpty ||
                  e.instructionsController.text.trim().isNotEmpty))
          .toList();

      if (invalidEntries.isNotEmpty) {
        showFormErrorDialog(
          context,
          errors: ['Some entries are missing medication name'],
        );
        return;
      }

      isSaving.value = true;

      int successCount = 0;
      int failCount = 0;

      for (final entry in validEntries) {
        final prescription = entry.toPrescription(recordId, selectedDate.value);
        final success = await onSave(prescription);
        if (success) {
          successCount++;
        } else {
          failCount++;
        }
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        if (failCount == 0) {
          showSuccessSnackBar(
            context,
            message:
                '$successCount prescription${successCount > 1 ? 's' : ''} added',
          );
        } else {
          showErrorSnackBar(
            context,
            message: '$successCount added, $failCount failed',
          );
        }
      }
    }

    final validCount = entries.value.where((e) => e.isValid).length;

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

              // Title with count badge
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Add Prescription Group',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  if (validCount > 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '$validCount medication${validCount > 1 ? 's' : ''}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
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

              // Date picker
              InkWell(
                onTap: isSaving.value ? null : selectDate,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            DateFormat('MMMM d, yyyy')
                                .format(selectedDate.value),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Section header
              Row(
                children: [
                  Icon(
                    Icons.medication,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Medications',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Prescription entries - Compact Row Layout
              ...entries.value.asMap().entries.map((mapEntry) {
                final index = mapEntry.key;
                final entry = mapEntry.value;
                return _CompactPrescriptionEntry(
                  key: ValueKey(entry),
                  index: index,
                  entry: entry,
                  canRemove: entries.value.length > 1,
                  onRemove: () => removeEntry(index),
                  enabled: !isSaving.value,
                );
              }),

              // Add medication button
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: isSaving.value ? null : addEntry,
                icon: const Icon(Icons.add),
                label: const Text('Add another medication'),
              ),
              const SizedBox(height: 24),

              // Buttons
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact prescription entry with collapsible instructions.
class _CompactPrescriptionEntry extends HookWidget {
  const _CompactPrescriptionEntry({
    super.key,
    required this.index,
    required this.entry,
    required this.canRemove,
    required this.onRemove,
    required this.enabled,
  });

  final int index;
  final _PrescriptionEntry entry;
  final bool canRemove;
  final VoidCallback onRemove;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showInstructions = useValueListenable(entry.showInstructions);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Main row: Medication | Dosage | Remove
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medication field (flex: 2)
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: entry.medicationController,
                    decoration: InputDecoration(
                      labelText: 'Medication *',
                      hintText: 'e.g., Amoxicillin',
                      border: const OutlineInputBorder(),
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.medication,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    textCapitalization: TextCapitalization.words,
                    enabled: enabled,
                  ),
                ),
                const SizedBox(width: 8),
                // Dosage field (flex: 1)
                Expanded(
                  child: TextField(
                    controller: entry.dosageController,
                    decoration: const InputDecoration(
                      labelText: 'Dosage',
                      hintText: '250mg',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    enabled: enabled,
                  ),
                ),
                const SizedBox(width: 4),
                // Remove button
                if (canRemove)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: theme.colorScheme.error,
                    ),
                    onPressed: enabled ? onRemove : null,
                    tooltip: 'Remove',
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  )
                else
                  const SizedBox(width: 36),
              ],
            ),
          ),

          // Instructions toggle
          InkWell(
            onTap: enabled
                ? () => entry.showInstructions.value = !showInstructions
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.notes,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    showInstructions ? 'Hide instructions' : 'Add instructions',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    showInstructions ? Icons.expand_less : Icons.expand_more,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),

          // Collapsible instructions field
          if (showInstructions)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: TextField(
                controller: entry.instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions',
                  hintText: 'e.g., Take with food for 7 days',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                maxLines: 2,
                enabled: enabled,
              ),
            ),
        ],
      ),
    );
  }
}

/// Shows the add prescription group sheet with fullscreen draggable functionality.
void showPrescriptionGroupSheet(
  BuildContext context, {
  required String recordId,
  required Future<bool> Function(Prescription prescription) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => AddPrescriptionGroupSheet(
        recordId: recordId,
        scrollController: scrollController,
        onSave: onSave,
      ),
    ),
  );
}
