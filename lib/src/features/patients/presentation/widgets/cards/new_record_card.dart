import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient.dart';
import '../../../domain/patient_record.dart';
import '../../controllers/patient_records_controller.dart';

/// Inline card for creating a new patient record.
///
/// Shows an expanded form for entering record details.
/// Calls [onSaved] with the created record ID when record is successfully created,
/// or [onCancel] when user discards the form.
class NewRecordCard extends HookConsumerWidget {
  const NewRecordCard({
    super.key,
    required this.patient,
    required this.onSaved,
    required this.onCancel,
  });

  final Patient patient;
  final void Function(String recordId) onSaved;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

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

      final record = PatientRecord(
        id: '', // Empty for new record
        patientId: patient.id,
        date: values['recordDate'] as DateTime? ?? DateTime.now(),
        diagnosis: (values['diagnosis'] as String? ?? '').trim(),
        weight: weight?.isEmpty ?? true ? '' : '$weight kg',
        temperature: temperature?.isEmpty ?? true ? '' : '$temperature °C',
        treatment: _nullIfEmpty(values['treatment'] as String?),
        notes: _nullIfEmpty(values['notes'] as String?),
      );

      try {
        final created = await ref
            .read(patientRecordsControllerProvider(patient.id).notifier)
            .createRecordAndReturn(record);

        if (context.mounted) {
          isSaving.value = false;
          if (created != null) {
            showSuccessSnackBar(context,
                message: 'Record created successfully');
            onSaved(created.id);
          } else {
            showErrorSnackBar(context, message: 'Failed to create record');
          }
        }
      } catch (e) {
        if (context.mounted) {
          isSaving.value = false;
          showErrorSnackBar(context, message: 'An error occurred');
        }
      }
    }

    void handleCancel() {
      // Check if form has changes before canceling
      final currentState = formKey.currentState;
      if (currentState != null) {
        currentState.save();
        final values = currentState.value;
        final hasChanges = _hasFormChanges(values);
        if (hasChanges) {
          _showDiscardConfirmation(context, onCancel);
          return;
        }
      }
      onCancel();
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.primaryContainer.withValues(alpha: .9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _NewRecordHeader(
            isSaving: isSaving.value,
            onCancel: handleCancel,
            onSave: handleSave,
          ),

          // Form content
          Padding(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Visit date
                  FormBuilderDateTimePicker(
                    name: 'recordDate',
                    initialValue: DateTime.now(),
                    inputType: InputType.date,
                    decoration: const InputDecoration(
                      labelText: 'Visit Date',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 1)),
                    enabled: !isSaving.value,
                  ),
                  const SizedBox(height: 16),

                  // Vitals row
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'weight',
                          decoration: const InputDecoration(
                            labelText: 'Weight',
                            border: OutlineInputBorder(),
                            suffixText: 'kg',
                            prefixIcon: Icon(Icons.monitor_weight),
                          ),
                          keyboardType: TextInputType.number,
                          enabled: !isSaving.value,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'temperature',
                          decoration: const InputDecoration(
                            labelText: 'Temperature',
                            border: OutlineInputBorder(),
                            suffixText: '°C',
                            prefixIcon: Icon(Icons.thermostat),
                          ),
                          keyboardType: TextInputType.number,
                          enabled: !isSaving.value,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Diagnosis (required)
                  FormBuilderTextField(
                    name: 'diagnosis',
                    decoration: const InputDecoration(
                      labelText: 'Diagnosis *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                    maxLines: 2,
                    enabled: !isSaving.value,
                    validator: FormBuilderValidators.required(
                      errorText: 'Diagnosis is required',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Treatment
                  FormBuilderTextField(
                    name: 'treatment',
                    decoration: const InputDecoration(
                      labelText: 'Treatment',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.healing),
                    ),
                    maxLines: 2,
                    enabled: !isSaving.value,
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  FormBuilderTextField(
                    name: 'notes',
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.notes),
                    ),
                    maxLines: 3,
                    enabled: !isSaving.value,
                  ),
                ],
              ),
            ),
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
        content: const Text(
            'You have unsaved changes. Are you sure you want to discard them?'),
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

  /// Check if form has any non-empty values.
  bool _hasFormChanges(Map<String, dynamic> values) {
    final diagnosis = values['diagnosis'] as String? ?? '';
    final weight = values['weight'] as String? ?? '';
    final temperature = values['temperature'] as String? ?? '';
    final treatment = values['treatment'] as String? ?? '';
    final notes = values['notes'] as String? ?? '';

    return diagnosis.isNotEmpty ||
        weight.isNotEmpty ||
        temperature.isNotEmpty ||
        treatment.isNotEmpty ||
        notes.isNotEmpty;
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

/// Header row with "New Record" title and Cancel/Save buttons.
class _NewRecordHeader extends StatelessWidget {
  const _NewRecordHeader({
    required this.isSaving,
    required this.onCancel,
    required this.onSave,
  });

  final bool isSaving;
  final VoidCallback onCancel;
  final Future<void> Function() onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.add_circle, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            'New Record',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
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
        ],
      ),
    );
  }
}
