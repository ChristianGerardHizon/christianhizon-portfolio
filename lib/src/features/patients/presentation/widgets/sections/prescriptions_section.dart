import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/prescription.dart';
import '../../controllers/prescription_controller.dart';

/// Entry data for a single prescription in a group.
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

/// Section displaying prescriptions for a record, grouped by date.
/// Supports inline adding and editing of prescriptions.
class PrescriptionsSection extends HookConsumerWidget {
  const PrescriptionsSection({
    super.key,
    required this.recordId,
  });

  final String recordId;

  /// Groups prescriptions by date and returns a sorted map (newest first).
  Map<DateTime, List<Prescription>> _groupByDate(List<Prescription> prescriptions) {
    final grouped = groupBy<Prescription, DateTime>(
      prescriptions,
      (p) {
        final date = p.date ?? p.created ?? DateTime.now();
        // Normalize to date only (no time component)
        return DateTime(date.year, date.month, date.day);
      },
    );

    // Sort by date descending (newest first)
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return {for (final key in sortedKeys) key: grouped[key]!};
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(prescriptionControllerProvider(recordId));
    final theme = Theme.of(context);

    // State for inline forms
    final showAddSingle = useState(false);
    final showAddGroup = useState(false);
    final editingPrescriptionId = useState<String?>(null);

    void closeAllForms() {
      showAddSingle.value = false;
      showAddGroup.value = false;
      editingPrescriptionId.value = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header - responsive layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;
            final isAddingOrEditing = showAddSingle.value ||
                showAddGroup.value ||
                editingPrescriptionId.value != null;

            final actionButtons = isAddingOrEditing
                ? <Widget>[]
                : [
                    OutlinedButton.icon(
                      onPressed: () {
                        closeAllForms();
                        showAddGroup.value = true;
                      },
                      icon: const Icon(Icons.playlist_add, size: 18),
                      label: const Text('Add Group'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: () {
                        closeAllForms();
                        showAddSingle.value = true;
                      },
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add'),
                    ),
                  ];

            if (isTablet) {
              return Row(
                children: [
                  Icon(Icons.medication, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text('Prescriptions', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  ...actionButtons,
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.medication, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text('Prescriptions', style: theme.textTheme.titleMedium),
                  ],
                ),
                if (actionButtons.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: actionButtons,
                  ),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        // Inline Add Single Prescription Form
        if (showAddSingle.value)
          _InlineAddPrescriptionForm(
            recordId: recordId,
            onCancel: () => showAddSingle.value = false,
            onSaved: () => showAddSingle.value = false,
          ),

        // Inline Add Prescription Group Form
        if (showAddGroup.value)
          _InlineAddPrescriptionGroupForm(
            recordId: recordId,
            onCancel: () => showAddGroup.value = false,
            onSaved: () => showAddGroup.value = false,
          ),

        // Content
        prescriptionsAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load prescriptions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => ref
                        .read(prescriptionControllerProvider(recordId).notifier)
                        .refresh(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (prescriptions) {
            if (prescriptions.isEmpty && !showAddSingle.value && !showAddGroup.value) {
              return _EmptyState(
                onAddSingle: () => showAddSingle.value = true,
                onAddGroup: () => showAddGroup.value = true,
              );
            }

            final groupedPrescriptions = _groupByDate(prescriptions);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: groupedPrescriptions.entries.map((entry) {
                final date = entry.key;
                final datePrescriptions = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    _DateHeader(date: _formatDateHeader(date)),
                    const SizedBox(height: 8),
                    // Prescriptions for this date
                    ...datePrescriptions.map(
                      (prescription) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: editingPrescriptionId.value == prescription.id
                            ? _InlineEditPrescriptionForm(
                                prescription: prescription,
                                onCancel: () => editingPrescriptionId.value = null,
                                onSaved: () => editingPrescriptionId.value = null,
                              )
                            : _PrescriptionCard(
                                prescription: prescription,
                                onEdit: () {
                                  closeAllForms();
                                  editingPrescriptionId.value = prescription.id;
                                },
                                onDelete: () => _handleDeletePrescription(
                                  context,
                                  ref,
                                  prescription,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleDeletePrescription(
    BuildContext context,
    WidgetRef ref,
    Prescription prescription,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Prescription'),
        content: Text('Are you sure you want to delete ${prescription.medication}?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(prescriptionControllerProvider(recordId).notifier)
          .deletePrescription(prescription.id);

      if (context.mounted) {
        if (success) {
          showSuccessSnackBar(context, message: 'Prescription deleted');
        } else {
          showErrorSnackBar(context, message: 'Failed to delete prescription');
        }
      }
    }
  }
}

/// Inline form for adding prescriptions (multiple entries, no date picker - uses today).
class _InlineAddPrescriptionForm extends HookConsumerWidget {
  const _InlineAddPrescriptionForm({
    required this.recordId,
    required this.onCancel,
    required this.onSaved,
  });

  final String recordId;
  final VoidCallback onCancel;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
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

      isSaving.value = true;

      int successCount = 0;
      int failCount = 0;

      for (final entry in validEntries) {
        final prescription = entry.toPrescription(recordId, DateTime.now());
        final success = await ref
            .read(prescriptionControllerProvider(recordId).notifier)
            .createPrescription(prescription);
        if (success) {
          successCount++;
        } else {
          failCount++;
        }
      }

      if (context.mounted) {
        isSaving.value = false;

        if (failCount == 0) {
          showSuccessSnackBar(
            context,
            message: '$successCount prescription${successCount > 1 ? 's' : ''} added',
          );
          onSaved();
        } else {
          showErrorSnackBar(
            context,
            message: '$successCount added, $failCount failed',
          );
        }
      }
    }

    final validCount = entries.value.where((e) => e.isValid).length;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.add, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Add Prescription',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                if (validCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$validCount',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: isSaving.value ? null : onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: isSaving.value ? null : handleSave,
                  child: isSaving.value
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save All'),
                ),
              ],
            ),
            const Divider(height: 24),

            // Medication entries
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
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add another medication'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Inline form for editing an existing prescription.
class _InlineEditPrescriptionForm extends HookConsumerWidget {
  const _InlineEditPrescriptionForm({
    required this.prescription,
    required this.onCancel,
    required this.onSaved,
  });

  final Prescription prescription;
  final VoidCallback onCancel;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final updated = Prescription(
        id: prescription.id,
        recordId: prescription.recordId,
        medication: (values['medication'] as String).trim(),
        dosage: _nullIfEmpty(values['dosage'] as String?),
        instructions: _nullIfEmpty(values['instructions'] as String?),
        date: values['date'] as DateTime? ?? prescription.date,
      );

      final success = await ref
          .read(prescriptionControllerProvider(prescription.recordId).notifier)
          .updatePrescription(updated);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          showSuccessSnackBar(context, message: 'Prescription updated');
          onSaved();
        } else {
          showErrorSnackBar(context, message: 'Failed to update prescription');
        }
      }
    }

    return Card(
      elevation: 2,
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.edit, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Edit Prescription',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: isSaving.value ? null : onCancel,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: isSaving.value ? null : handleSave,
                    child: isSaving.value
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ],
              ),
              const Divider(height: 24),

              // Form fields - Responsive layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 500;

                  if (isWide) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: FormBuilderTextField(
                                name: 'medication',
                                initialValue: prescription.medication,
                                decoration: const InputDecoration(
                                  labelText: 'Medication *',
                                  hintText: 'e.g., Amoxicillin',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  prefixIcon: Icon(Icons.medication),
                                ),
                                textCapitalization: TextCapitalization.words,
                                enabled: !isSaving.value,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'dosage',
                                initialValue: prescription.dosage ?? '',
                                decoration: const InputDecoration(
                                  labelText: 'Dosage',
                                  hintText: '250mg',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                enabled: !isSaving.value,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FormBuilderDateTimePicker(
                                name: 'date',
                                initialValue: prescription.date ?? DateTime.now(),
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  prefixIcon: Icon(Icons.calendar_today),
                                ),
                                enabled: !isSaving.value,
                                inputType: InputType.date,
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FormBuilderTextField(
                          name: 'instructions',
                          initialValue: prescription.instructions ?? '',
                          decoration: const InputDecoration(
                            labelText: 'Instructions',
                            hintText: 'e.g., Take with food for 7 days',
                            border: OutlineInputBorder(),
                            isDense: true,
                            prefixIcon: Icon(Icons.notes),
                          ),
                          maxLines: 2,
                          enabled: !isSaving.value,
                        ),
                      ],
                    );
                  }

                  // Mobile layout - stacked
                  return Column(
                    children: [
                      FormBuilderTextField(
                        name: 'medication',
                        initialValue: prescription.medication,
                        decoration: const InputDecoration(
                          labelText: 'Medication *',
                          hintText: 'e.g., Amoxicillin',
                          border: OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: Icon(Icons.medication),
                        ),
                        textCapitalization: TextCapitalization.words,
                        enabled: !isSaving.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'dosage',
                              initialValue: prescription.dosage ?? '',
                              decoration: const InputDecoration(
                                labelText: 'Dosage',
                                hintText: '250mg',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              enabled: !isSaving.value,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'date',
                              initialValue: prescription.date ?? DateTime.now(),
                              decoration: const InputDecoration(
                                labelText: 'Date',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              enabled: !isSaving.value,
                              inputType: InputType.date,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FormBuilderTextField(
                        name: 'instructions',
                        initialValue: prescription.instructions ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Instructions',
                          hintText: 'e.g., Take with food for 7 days',
                          border: OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: Icon(Icons.notes),
                        ),
                        maxLines: 2,
                        enabled: !isSaving.value,
                      ),
                    ],
                  );
                },
              ),
            ],
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

/// Inline form for adding a prescription group (multiple medications with shared date).
class _InlineAddPrescriptionGroupForm extends HookConsumerWidget {
  const _InlineAddPrescriptionGroupForm({
    required this.recordId,
    required this.onCancel,
    required this.onSaved,
  });

  final String recordId;
  final VoidCallback onCancel;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final entries = useState<List<_PrescriptionEntry>>([_PrescriptionEntry()]);
    final isSaving = useState(false);
    final selectedDate = useState(DateTime.now());

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

      isSaving.value = true;

      int successCount = 0;
      int failCount = 0;

      for (final entry in validEntries) {
        final prescription = entry.toPrescription(recordId, selectedDate.value);
        final success = await ref
            .read(prescriptionControllerProvider(recordId).notifier)
            .createPrescription(prescription);
        if (success) {
          successCount++;
        } else {
          failCount++;
        }
      }

      if (context.mounted) {
        isSaving.value = false;

        if (failCount == 0) {
          showSuccessSnackBar(
            context,
            message: '$successCount prescription${successCount > 1 ? 's' : ''} added',
          );
          onSaved();
        } else {
          showErrorSnackBar(
            context,
            message: '$successCount added, $failCount failed',
          );
        }
      }
    }

    final validCount = entries.value.where((e) => e.isValid).length;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.playlist_add, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Add Prescription Group',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                if (validCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$validCount',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: isSaving.value ? null : onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: isSaving.value ? null : handleSave,
                  child: isSaving.value
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save All'),
                ),
              ],
            ),
            const Divider(height: 24),

            // Date picker for all prescriptions in the group
            FormBuilderDateTimePicker(
              name: 'date',
              initialValue: selectedDate.value,
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                isDense: true,
                prefixIcon: Icon(Icons.calendar_today),
              ),
              enabled: !isSaving.value,
              inputType: InputType.date,
              firstDate: DateTime(2020),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onChanged: (value) {
                if (value != null) {
                  selectedDate.value = value;
                }
              },
            ),
            const SizedBox(height: 16),

            // Medication entries
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
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add another medication'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact prescription entry for group form.
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

/// Compact prescription item with border styling.
class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({
    required this.prescription,
    required this.onEdit,
    required this.onDelete,
  });

  final Prescription prescription;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Build medication + dosage text
    final medicationText = prescription.dosage != null
        ? '${prescription.medication} - ${prescription.dosage}'
        : prescription.medication;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main row: icon + medication/dosage + actions
          Row(
            children: [
              Icon(
                Icons.medication,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  medicationText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Action buttons
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                onPressed: onEdit,
                tooltip: 'Edit',
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: theme.colorScheme.error,
                ),
                onPressed: onDelete,
                tooltip: 'Delete',
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          // Instructions (if present)
          if (prescription.instructions != null &&
              prescription.instructions!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                prescription.instructions!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.onAddSingle,
    required this.onAddGroup,
  });

  final VoidCallback onAddSingle;
  final VoidCallback onAddGroup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.medication_outlined,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No prescriptions',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add a prescription for this record',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: onAddGroup,
                  icon: const Icon(Icons.playlist_add, size: 18),
                  label: const Text('Add Group'),
                ),
                FilledButton.icon(
                  onPressed: onAddSingle,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Prescription'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Date header for grouping prescriptions.
class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          date,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Divider(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ],
    );
  }
}
