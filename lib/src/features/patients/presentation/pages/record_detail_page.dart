import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/patients.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../settings/presentation/controllers/branch_provider.dart';
import '../../domain/patient.dart';
import '../../domain/patient_record.dart';
import '../../domain/prescription.dart';
import '../controllers/patient_provider.dart';
import '../controllers/patient_record_provider.dart';
import '../controllers/patient_records_controller.dart';
import '../controllers/prescription_controller.dart';
import '../pdf/prescription_pdf_generator.dart';
import '../widgets/sections/prescriptions_section.dart';

/// Full-screen page for viewing/editing/creating a patient record.
///
/// Pass [recordId] as null to create a new record.
class RecordDetailPage extends HookConsumerWidget {
  const RecordDetailPage({
    super.key,
    required this.patientId,
    this.recordId,
  });

  final String patientId;
  final String? recordId;

  /// Whether this is a new record being created.
  bool get isNewRecord => recordId == null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final patientAsync = ref.watch(patientProvider(patientId));

    // Only fetch record if we have a recordId
    final recordAsync = recordId != null
        ? ref.watch(patientRecordProvider(recordId!))
        : const AsyncValue<PatientRecord?>.data(null);

    // Track if we're in edit mode (always true for new records)
    final isEditing = useState(isNewRecord);

    // Track if save is in progress
    final isSaving = useState(false);

    // Form key for the record form
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // Created record ID (for new records, set after first save)
    final createdRecordId = useState<String?>(recordId);

    // Handle loading state for patient (and record if not new)
    if (patientAsync.isLoading || (!isNewRecord && recordAsync.isLoading)) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Handle error state
    if (patientAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${patientAsync.error.toString()}'),
            ],
          ),
        ),
      );
    }

    if (!isNewRecord && recordAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${recordAsync.error.toString()}'),
            ],
          ),
        ),
      );
    }

    final patient = patientAsync.value;
    final record = recordAsync.value;

    if (patient == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: const Center(child: Text('Patient not found')),
      );
    }

    if (!isNewRecord && record == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: const Center(child: Text('Record not found')),
      );
    }

    // Check if diagnosis exists (for enabling prescriptions)
    final hasDiagnosis = record?.diagnosis.isNotEmpty ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewRecord ? 'New Record' : 'Record Details'),
        actions: [
          if (!isNewRecord && !isEditing.value)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
              onPressed: () => isEditing.value = true,
            ),
          if (isEditing.value) ...[
            TextButton(
              onPressed: isSaving.value
                  ? null
                  : () {
                      if (isNewRecord) {
                        // For new unsaved records, just go back
                        context.pop();
                      } else {
                        // For existing records, cancel edit mode
                        isEditing.value = false;
                      }
                    },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: isSaving.value
                  ? null
                  : () => _handleSave(
                        context,
                        ref,
                        formKey,
                        patient,
                        record,
                        isSaving,
                        isEditing,
                        createdRecordId,
                      ),
              child: isSaving.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(patientProvider(patientId));
          if (createdRecordId.value != null) {
            ref.invalidate(patientRecordProvider(createdRecordId.value!));
          }
          await ref.read(patientProvider(patientId).future);
          if (createdRecordId.value != null) {
            await ref.read(patientRecordProvider(createdRecordId.value!).future);
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient info
              _buildPatientCard(theme, patient),
              const SizedBox(height: 24),

              // Record form (editable) or display (read-only)
              if (isEditing.value)
                _RecordForm(
                  formKey: formKey,
                  record: record,
                  enabled: !isSaving.value,
                )
              else if (record != null)
                _RecordDisplay(record: record, theme: theme),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),

              // Prescriptions section (greyed out if no diagnosis)
              _PrescriptionsSectionWrapper(
                recordId: createdRecordId.value,
                hasDiagnosis: hasDiagnosis,
                theme: theme,
              ),

              // Actions (only show if record exists with diagnosis)
              if (hasDiagnosis && createdRecordId.value != null) ...[
                const SizedBox(height: 32),
                _RecordActions(
                  patient: patient,
                  record: record!,
                  recordId: createdRecordId.value!,
                  ref: ref,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormBuilderState> formKey,
    Patient patient,
    PatientRecord? existingRecord,
    ValueNotifier<bool> isSaving,
    ValueNotifier<bool> isEditing,
    ValueNotifier<String?> createdRecordId,
  ) async {
    final isValid = formKey.currentState!.saveAndValidate();
    if (!isValid) {
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

    final record = PatientRecord(
      id: existingRecord?.id ?? '',
      patientId: patientId,
      date: values['recordDate'] as DateTime? ?? DateTime.now(),
      diagnosis: (values['diagnosis'] as String? ?? '').trim(),
      weight: weight?.isEmpty ?? true ? '' : '$weight kg',
      temperature: temperature?.isEmpty ?? true ? '' : '$temperature °C',
      treatment: _nullIfEmpty(values['treatment'] as String?),
      notes: _nullIfEmpty(values['notes'] as String?),
      appointment: existingRecord?.appointment,
      branch: existingRecord?.branch,
      tests: existingRecord?.tests,
      isDeleted: existingRecord?.isDeleted ?? false,
      created: existingRecord?.created,
      updated: existingRecord?.updated,
    );

    try {
      if (existingRecord == null) {
        // Create new record
        final created = await ref
            .read(patientRecordsControllerProvider(patientId).notifier)
            .createRecordAndReturn(record);

        if (created != null && context.mounted) {
          createdRecordId.value = created.id;
          isEditing.value = false;
          isSaving.value = false;

          // Navigate to the created record's page (replace current route)
          RecordDetailRoute(id: patientId, recordId: created.id).go(context);

          showSuccessSnackBar(context, message: 'Record created successfully');
        } else if (context.mounted) {
          isSaving.value = false;
          showErrorSnackBar(context, message: 'Failed to create record');
        }
      } else {
        // Update existing record
        final success = await ref
            .read(patientRecordsControllerProvider(patientId).notifier)
            .updateRecord(record);

        if (context.mounted) {
          isSaving.value = false;
          if (success) {
            isEditing.value = false;
            // Refresh the record
            ref.invalidate(patientRecordProvider(existingRecord.id));
            showSuccessSnackBar(context, message: 'Record updated successfully');
          } else {
            showErrorSnackBar(context, message: 'Failed to update record');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        isSaving.value = false;
        showErrorSnackBar(context, message: 'An error occurred');
      }
    }
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }

  Widget _buildPatientCard(ThemeData theme, Patient patient) {
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: patient.species == 'Dog'
                  ? Colors.brown.shade100
                  : Colors.orange.shade100,
              child: Icon(
                patient.species == 'Dog' ? Icons.pets : Icons.catching_pokemon,
                color: patient.species == 'Dog' ? Colors.brown : Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('${patient.species ?? ''} - ${patient.breed ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

/// Editable record form.
class _RecordForm extends StatelessWidget {
  const _RecordForm({
    required this.formKey,
    required this.record,
    required this.enabled,
  });

  final GlobalKey<FormBuilderState> formKey;
  final PatientRecord? record;
  final bool enabled;

  /// Parses a value with unit suffix (e.g., "5.2 kg" -> "5.2").
  static String _parseValueWithUnit(String value, String unit) {
    if (value.isEmpty) return '';
    return value.replaceAll(unit, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final initialDate = record?.date ?? DateTime.now();
    final initialWeight = _parseValueWithUnit(record?.weight ?? '', 'kg');
    final initialTemp = _parseValueWithUnit(record?.temperature ?? '', '°C');

    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visit date
          FormBuilderDateTimePicker(
            name: 'recordDate',
            initialValue: initialDate,
            inputType: InputType.date,
            decoration: const InputDecoration(
              labelText: 'Visit Date',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
            firstDate: DateTime(2000),
            lastDate: DateTime.now().add(const Duration(days: 1)),
            enabled: enabled,
          ),
          const SizedBox(height: 16),

          // Diagnosis (required)
          FormBuilderTextField(
            name: 'diagnosis',
            initialValue: record?.diagnosis ?? '',
            decoration: const InputDecoration(
              labelText: 'Diagnosis *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.medical_services),
            ),
            maxLines: 2,
            enabled: enabled,
            validator: FormBuilderValidators.required(
              errorText: 'Diagnosis is required',
            ),
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
                  ),
                  keyboardType: TextInputType.number,
                  enabled: enabled,
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
                  ),
                  keyboardType: TextInputType.number,
                  enabled: enabled,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Treatment
          FormBuilderTextField(
            name: 'treatment',
            initialValue: record?.treatment ?? '',
            decoration: const InputDecoration(
              labelText: 'Treatment',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.healing),
            ),
            maxLines: 2,
            enabled: enabled,
          ),
          const SizedBox(height: 16),

          // Notes
          FormBuilderTextField(
            name: 'notes',
            initialValue: record?.notes ?? '',
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.notes),
            ),
            maxLines: 3,
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}

/// Read-only record display.
class _RecordDisplay extends StatelessWidget {
  const _RecordDisplay({
    required this.record,
    required this.theme,
  });

  final PatientRecord record;
  final ThemeData theme;

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final month = months[date.month - 1];
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month ${date.day}, ${date.year} $hour:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Visit date
        Text('Visit Date', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 12),
                Text(_formatDate(record.date)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Vitals
        Text('Vitals', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(Icons.monitor_weight, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        record.weight.isNotEmpty ? record.weight : '-',
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text('Weight', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(Icons.thermostat, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        record.temperature.isNotEmpty ? record.temperature : '-',
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text('Temperature', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Diagnosis
        Text('Diagnosis', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(record.diagnosis.isNotEmpty ? record.diagnosis : '-'),
          ),
        ),

        // Treatment
        if (record.treatment != null && record.treatment!.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text('Treatment', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(record.treatment!),
            ),
          ),
        ],

        // Notes
        if (record.notes != null && record.notes!.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text('Notes', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(record.notes!),
            ),
          ),
        ],
      ],
    );
  }
}

/// Wrapper for prescriptions section that handles disabled state.
class _PrescriptionsSectionWrapper extends StatelessWidget {
  const _PrescriptionsSectionWrapper({
    required this.recordId,
    required this.hasDiagnosis,
    required this.theme,
  });

  final String? recordId;
  final bool hasDiagnosis;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (recordId == null || !hasDiagnosis) {
      // Show disabled state
      return Opacity(
        opacity: 0.5,
        child: IgnorePointer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.medication, color: theme.colorScheme.outline),
                  const SizedBox(width: 8),
                  Text('Prescriptions', style: theme.textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 16),
              Card(
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
                        recordId == null
                            ? 'Save the record first to add prescriptions'
                            : 'Add a diagnosis to enable prescriptions',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PrescriptionsSection(recordId: recordId!);
  }
}

/// Record action buttons (print, share, save).
class _RecordActions extends ConsumerWidget {
  const _RecordActions({
    required this.patient,
    required this.record,
    required this.recordId,
    required this.ref,
  });

  final Patient patient;
  final PatientRecord record;
  final String recordId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: () => _showPrescriptionGroupSelector(
            context,
            ref,
            patient,
            record,
            action: _PdfAction.print,
          ),
          icon: const Icon(Icons.print),
          label: const Text('Print'),
        ),
        OutlinedButton.icon(
          onPressed: () => _showPrescriptionGroupSelector(
            context,
            ref,
            patient,
            record,
            action: _PdfAction.share,
          ),
          icon: const Icon(Icons.share),
          label: const Text('Share'),
        ),
        OutlinedButton.icon(
          onPressed: () => _showPrescriptionGroupSelector(
            context,
            ref,
            patient,
            record,
            action: _PdfAction.save,
          ),
          icon: const Icon(Icons.download),
          label: const Text('Save'),
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
    WidgetRef ref,
    Patient patient,
    PatientRecord record, {
    required _PdfAction action,
  }) {
    final prescriptionsAsync =
        ref.read(prescriptionControllerProvider(recordId));

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
              if (!context.mounted) return;
              switch (action) {
                case _PdfAction.print:
                  await generator.printPrescription(context);
                case _PdfAction.share:
                  await generator.sharePrescription(context);
                case _PdfAction.save:
                  final path = await generator.savePrescription(context);
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

/// Action type for prescription PDF.
enum _PdfAction { print, share, save }

/// Bottom sheet for selecting a prescription group to print/share/save.
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
        _PdfAction.save => 'Select Prescription to Save',
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
