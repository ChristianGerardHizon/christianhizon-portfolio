import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../domain/patient_record.dart';

/// Bottom sheet for adding a new patient record.
///
/// If [appointmentId] is provided, the record will be linked to that appointment.
class AddRecordSheet extends HookWidget {
  const AddRecordSheet({
    super.key,
    required this.patientId,
    required this.onSave,
    this.appointmentId,
  });

  final String patientId;

  /// Optional appointment ID to link the record to.
  final String? appointmentId;

  /// Callback when saving. Returns the created record on success, null on failure.
  final Future<PatientRecord?> Function(PatientRecord record) onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final diagnosisController = useTextEditingController();
    final weightController = useTextEditingController();
    final temperatureController = useTextEditingController();
    final notesController = useTextEditingController();
    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (diagnosisController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Diagnosis is required')),
        );
        return;
      }

      isSaving.value = true;

      final record = PatientRecord(
        id: '', // Will be assigned by PocketBase
        patientId: patientId,
        date: DateTime.now(),
        diagnosis: diagnosisController.text,
        weight: weightController.text.isEmpty ? '' : '${weightController.text} kg',
        temperature: temperatureController.text.isEmpty ? '' : '${temperatureController.text} °C',
        notes: notesController.text.isEmpty ? null : notesController.text,
        appointment: appointmentId,
      );

      final created = await onSave(record);

      if (context.mounted) {
        isSaving.value = false;
        if (created != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Record added successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add record')),
          );
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
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

            Text('Add Record', style: theme.textTheme.titleLarge),
            const SizedBox(height: 24),

            TextField(
              controller: diagnosisController,
              decoration: const InputDecoration(
                labelText: 'Diagnosis *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services),
              ),
              maxLines: 2,
              enabled: !isSaving.value,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      border: OutlineInputBorder(),
                      suffixText: 'kg',
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !isSaving.value,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: temperatureController,
                    decoration: const InputDecoration(
                      labelText: 'Temperature',
                      border: OutlineInputBorder(),
                      suffixText: '°C',
                    ),
                    keyboardType: TextInputType.number,
                    enabled: !isSaving.value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              enabled: !isSaving.value,
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isSaving.value ? null : () => Navigator.pop(context),
                    child: Text(t.common.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: isSaving.value ? null : handleSave,
                    child: isSaving.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(t.common.save),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
