import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../../settings/presentation/controllers/branch_provider.dart';
import '../../../domain/patient.dart';
import '../../../domain/patient_record.dart';
import '../../../domain/prescription.dart';
import '../../controllers/patient_records_controller.dart';
import '../../controllers/prescription_controller.dart';
import '../../pdf/prescription_pdf_generator.dart';
import '../sections/prescriptions_section.dart';

/// Expandable card displaying a patient medical record.
///
/// Shows a summary when collapsed, and full details with
/// prescriptions and edit capability when expanded.
class RecordCard extends HookConsumerWidget {
  const RecordCard({
    super.key,
    required this.record,
    required this.patient,
    this.initiallyExpanded = false,
  });

  final PatientRecord record;
  final Patient patient;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State management
    final isExpanded = useState(initiallyExpanded);
    final isSaving = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // Toggle expand/collapse
    void toggleExpand() {
      if (isExpanded.value) {
        // Check if form has changes before collapsing
        final currentState = formKey.currentState;
        if (currentState != null) {
          currentState.save();
          final values = currentState.value;
          final hasChanges = _hasFormChanges(record, values);
          if (hasChanges) {
            _showDiscardConfirmation(context, () {
              isExpanded.value = false;
            });
            return;
          }
        }
      }
      isExpanded.value = !isExpanded.value;
    }

    void cancelExpand() {
      isExpanded.value = false;
    }

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) {
        final errors = formKey.currentState?.errors ?? {};
        final errorMessages = formatFormErrors(errors, _fieldLabels);
        if (errorMessages.isNotEmpty) {
          showFormErrorDialog(context, errors: errorMessages);
        }
        return;
      }

      isSaving.value = true;

      final values = formKey.currentState!.value;
      final weight = values['weight'] as String?;
      final temperature = values['temperature'] as String?;

      final updatedRecord = PatientRecord(
        id: record.id,
        patientId: patient.id,
        date: values['recordDate'] as DateTime? ?? record.date,
        diagnosis: (values['diagnosis'] as String? ?? '').trim(),
        weight: weight?.isEmpty ?? true ? '' : '$weight kg',
        temperature: temperature?.isEmpty ?? true ? '' : '$temperature °C',
        treatment: _nullIfEmpty(values['treatment'] as String?),
        notes: _nullIfEmpty(values['notes'] as String?),
        appointment: record.appointment,
        branch: record.branch,
        tests: record.tests,
        isDeleted: record.isDeleted,
        created: record.created,
        updated: record.updated,
      );

      try {
        final success = await ref
            .read(patientRecordsControllerProvider(patient.id).notifier)
            .updateRecord(updatedRecord);

        if (context.mounted) {
          isSaving.value = false;
          if (success) {
            isExpanded.value = false;
            showSuccessSnackBar(context, message: 'Record updated successfully');
          } else {
            showErrorSnackBar(context, message: 'Failed to update record');
          }
        }
      } catch (e) {
        if (context.mounted) {
          isSaving.value = false;
          showErrorSnackBar(context, message: 'An error occurred');
        }
      }
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - always visible, tappable
          _RecordHeader(
            record: record,
            isExpanded: isExpanded.value,
            isSaving: isSaving.value,
            onTap: toggleExpand,
            onCancel: cancelExpand,
            onSave: handleSave,
          ),

          // Collapsed content (summary)
          if (!isExpanded.value)
            _CollapsedContent(record: record),

          // Expanded content with animation
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _ExpandedContent(
              formKey: formKey,
              record: record,
              patient: patient,
              isSaving: isSaving.value,
            ),
            crossFadeState: isExpanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  void _showDiscardConfirmation(BuildContext context, VoidCallback onDiscard) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Editing'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDiscard();
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }

  /// Check if form values differ from original record.
  bool _hasFormChanges(PatientRecord record, Map<String, dynamic> values) {
    final weight = values['weight'] as String? ?? '';
    final temperature = values['temperature'] as String? ?? '';
    final diagnosis = values['diagnosis'] as String? ?? '';
    final treatment = values['treatment'] as String? ?? '';
    final notes = values['notes'] as String? ?? '';

    // Parse original values
    final originalWeight = record.weight.replaceAll('kg', '').trim();
    final originalTemp = record.temperature.replaceAll('°C', '').trim();

    return weight != originalWeight ||
        temperature != originalTemp ||
        diagnosis != record.diagnosis ||
        treatment != (record.treatment ?? '') ||
        notes != (record.notes ?? '');
  }
}

/// Field labels for form error messages.
const _fieldLabels = {
  'recordDate': 'Visit Date',
  'diagnosis': 'Diagnosis',
  'weight': 'Weight',
  'temperature': 'Temperature',
  'treatment': 'Treatment',
  'notes': 'Notes',
};

/// Header row with date, badges, and expand/collapse indicator.
class _RecordHeader extends StatelessWidget {
  const _RecordHeader({
    required this.record,
    required this.isExpanded,
    required this.isSaving,
    required this.onTap,
    required this.onCancel,
    required this.onSave,
  });

  final PatientRecord record;
  final bool isExpanded;
  final bool isSaving;
  final VoidCallback onTap;
  final VoidCallback onCancel;
  final Future<void> Function() onSave;

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[date.month - 1];
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month ${date.day}, ${date.year} $hour:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = _formatDate(record.date);

    return InkWell(
      onTap: isExpanded ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.medical_services, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                dateStr,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),

            // Appointment badge
            if (record.appointment != null && record.appointment!.isNotEmpty) ...[
              Tooltip(
                message: 'Linked to appointment',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.event,
                        size: 14,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Appt',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],

            // Show Save/Cancel when expanded, otherwise show expand indicator
            if (isExpanded) ...[
              TextButton(
                onPressed: isSaving ? null : onCancel,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: isSaving ? null : onSave,
                child: isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ] else
              // Expand indicator
              Icon(
                Icons.keyboard_arrow_down,
                color: theme.colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

/// Collapsed content showing diagnosis and vitals summary.
class _CollapsedContent extends StatelessWidget {
  const _CollapsedContent({required this.record});

  final PatientRecord record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            record.diagnosis,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (record.weight.isNotEmpty)
                Chip(
                  avatar: const Icon(Icons.monitor_weight, size: 16),
                  label: Text(record.weight),
                  visualDensity: VisualDensity.compact,
                ),
              if (record.weight.isNotEmpty && record.temperature.isNotEmpty)
                const SizedBox(width: 8),
              if (record.temperature.isNotEmpty)
                Chip(
                  avatar: const Icon(Icons.thermostat, size: 16),
                  label: Text(record.temperature),
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Expanded content with editable form fields, prescriptions, and actions.
class _ExpandedContent extends StatelessWidget {
  const _ExpandedContent({
    required this.formKey,
    required this.record,
    required this.patient,
    required this.isSaving,
  });

  final GlobalKey<FormBuilderState> formKey;
  final PatientRecord record;
  final Patient patient;
  final bool isSaving;

  /// Parses a value with unit suffix (e.g., "5.2 kg" -> "5.2").
  static String _parseValueWithUnit(String value, String unit) {
    if (value.isEmpty) return '';
    return value.replaceAll(unit, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDiagnosis = record.diagnosis.isNotEmpty;

    final initialWeight = _parseValueWithUnit(record.weight, 'kg');
    final initialTemp = _parseValueWithUnit(record.temperature, '°C');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visit date
            FormBuilderDateTimePicker(
              name: 'recordDate',
              initialValue: record.date,
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Visit Date',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              firstDate: DateTime(2000),
              lastDate: DateTime.now().add(const Duration(days: 1)),
              enabled: !isSaving,
            ),
            const SizedBox(height: 16),

            // Vitals row
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'weight',
                    initialValue: initialWeight,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      border: OutlineInputBorder(),
                      suffixText: 'kg',
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !isSaving,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'temperature',
                    initialValue: initialTemp,
                    decoration: const InputDecoration(
                      labelText: 'Temperature',
                      border: OutlineInputBorder(),
                      suffixText: '°C',
                      prefixIcon: Icon(Icons.thermostat),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !isSaving,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Diagnosis (required)
            FormBuilderTextField(
              name: 'diagnosis',
              initialValue: record.diagnosis,
              decoration: const InputDecoration(
                labelText: 'Diagnosis *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services),
              ),
              maxLines: 2,
              enabled: !isSaving,
              validator: FormBuilderValidators.required(
                errorText: 'Diagnosis is required',
              ),
            ),
            const SizedBox(height: 16),

            // Treatment
            FormBuilderTextField(
              name: 'treatment',
              initialValue: record.treatment ?? '',
              decoration: const InputDecoration(
                labelText: 'Treatment',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.healing),
              ),
              maxLines: 2,
              enabled: !isSaving,
            ),
            const SizedBox(height: 16),

            // Notes
            FormBuilderTextField(
              name: 'notes',
              initialValue: record.notes ?? '',
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
              enabled: !isSaving,
            ),

            // Divider before prescriptions
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Prescriptions section
            if (hasDiagnosis)
              PrescriptionsSection(recordId: record.id)
            else
              _DisabledPrescriptionsPlaceholder(theme: theme),

            // Action buttons (PDF only, no Edit button needed)
            const SizedBox(height: 24),
            _RecordActions(
              record: record,
              patient: patient,
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder shown when prescriptions are disabled.
class _DisabledPrescriptionsPlaceholder extends StatelessWidget {
  const _DisabledPrescriptionsPlaceholder({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medication, color: theme.colorScheme.outline),
              const SizedBox(width: 8),
              Text('Prescriptions', style: theme.textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Add a diagnosis to enable prescriptions',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Action buttons: Print, Share, Download.
/// Only shown when there are prescriptions.
class _RecordActions extends ConsumerWidget {
  const _RecordActions({
    required this.record,
    required this.patient,
  });

  final PatientRecord record;
  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(prescriptionControllerProvider(record.id));

    // Only show buttons if there are prescriptions
    final hasPrescriptions = prescriptionsAsync.maybeWhen(
      data: (prescriptions) => prescriptions.isNotEmpty,
      orElse: () => false,
    );

    if (!hasPrescriptions) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: () => _showPrescriptionGroupSelector(
            context,
            ref,
            action: _PdfAction.print,
          ),
          icon: const Icon(Icons.print, size: 18),
          label: const Text('Print'),
        ),
        OutlinedButton.icon(
          onPressed: () => _showPrescriptionGroupSelector(
            context,
            ref,
            action: _PdfAction.share,
          ),
          icon: const Icon(Icons.share, size: 18),
          label: const Text('Share'),
        ),
        OutlinedButton.icon(
          onPressed: () => _showPrescriptionGroupSelector(
            context,
            ref,
            action: _PdfAction.save,
          ),
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Download'),
        ),
      ],
    );
  }

  /// Groups prescriptions by date and returns a sorted map (newest first).
  Map<DateTime, List<Prescription>> _groupPrescriptionsByDate(
      List<Prescription> prescriptions) {
    final grouped = groupBy<Prescription, DateTime>(
      prescriptions,
      (p) {
        final date = p.date ?? p.created ?? DateTime.now();
        return DateTime(date.year, date.month, date.day);
      },
    );
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

  void _showPrescriptionGroupSelector(
    BuildContext context,
    WidgetRef ref, {
    required _PdfAction action,
  }) {
    final prescriptionsAsync =
        ref.read(prescriptionControllerProvider(record.id));

    prescriptionsAsync.when(
      loading: () {
        showInfoSnackBar(context, message: 'Loading prescriptions...');
      },
      error: (error, stack) {
        showErrorSnackBar(context, message: 'Failed to load prescriptions');
      },
      data: (prescriptions) {
        if (prescriptions.isEmpty) {
          showInfoSnackBar(context, message: 'No prescriptions available');
          return;
        }

        final groupedPrescriptions = _groupPrescriptionsByDate(prescriptions);

        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => _PrescriptionGroupSelectorSheet(
            groupedPrescriptions: groupedPrescriptions,
            formatDateHeader: _formatDateHeader,
            onSelect: (date, prescriptions) async {
              Navigator.pop(context);

              // Fetch branch data for PDF header
              final branchId = record.branch;
              final branch = branchId != null && branchId.isNotEmpty
                  ? await ref.read(branchProvider(branchId).future)
                  : null;

              final pdfData = PrescriptionPdfData(
                prescriptions: prescriptions,
                patient: patient,
                record: record,
                prescriptionDate: date,
                branch: branch,
              );
              final generator = PrescriptionPdfGenerator(pdfData);
              switch (action) {
                case _PdfAction.print:
                  await generator.printPrescription();
                case _PdfAction.share:
                  await generator.sharePrescription();
                case _PdfAction.save:
                  final path = await generator.savePrescription();
                  if (context.mounted && path != null) {
                    showSuccessSnackBar(context, message: 'Prescription saved');
                  }
              }
            },
            action: action,
          ),
        );
      },
    );
  }
}

/// PDF action type.
enum _PdfAction { print, share, save }

/// Bottom sheet for selecting a prescription group.
class _PrescriptionGroupSelectorSheet extends StatelessWidget {
  const _PrescriptionGroupSelectorSheet({
    required this.groupedPrescriptions,
    required this.formatDateHeader,
    required this.onSelect,
    required this.action,
  });

  final Map<DateTime, List<Prescription>> groupedPrescriptions;
  final String Function(DateTime) formatDateHeader;
  final void Function(DateTime date, List<Prescription> prescriptions) onSelect;
  final _PdfAction action;

  String get _title => switch (action) {
        _PdfAction.print => 'Select Prescription to Print',
        _PdfAction.share => 'Select Prescription to Share',
        _PdfAction.save => 'Select Prescription to Download',
      };

  IconData get _trailingIcon => switch (action) {
        _PdfAction.print => Icons.print,
        _PdfAction.share => Icons.share,
        _PdfAction.save => Icons.download,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a prescription group by date',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          ...groupedPrescriptions.entries.map((entry) {
            final date = entry.key;
            final prescriptions = entry.value;
            final medicationNames =
                prescriptions.map((p) => p.medication).join(', ');

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.medication),
                title: Text(formatDateHeader(date)),
                subtitle: Text(
                  '${prescriptions.length} medication${prescriptions.length > 1 ? 's' : ''}: $medicationNames',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(_trailingIcon),
                onTap: () => onSelect(date, prescriptions),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

