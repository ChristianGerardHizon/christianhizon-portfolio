import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient_record.dart';

/// Dialog for adding a new patient record.
///
/// If [appointmentId] is provided, the record will be linked to that appointment.
class AddRecordDialog extends HookWidget {
  const AddRecordDialog({
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
    final size = MediaQuery.sizeOf(context);

    final diagnosisController = useTextEditingController();
    final weightController = useTextEditingController();
    final temperatureController = useTextEditingController();
    final notesController = useTextEditingController();
    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (diagnosisController.text.isEmpty) {
        showErrorSnackBar(context, message: 'Diagnosis is required');
        return;
      }

      isSaving.value = true;

      final record = PatientRecord(
        id: '', // Will be assigned by PocketBase
        patientId: patientId,
        date: DateTime.now(),
        diagnosis: diagnosisController.text,
        weight:
            weightController.text.isEmpty ? '' : '${weightController.text} kg',
        temperature: temperatureController.text.isEmpty
            ? ''
            : '${temperatureController.text} °C',
        notes: notesController.text.isEmpty ? null : notesController.text,
        appointment: appointmentId,
      );

      final created = await onSave(record);

      if (context.mounted) {
        isSaving.value = false;
        if (created != null) {
          context.pop();
          showSuccessSnackBar(context, message: 'Record added successfully');
        } else {
          showErrorSnackBar(context, message: 'Failed to add record');
        }
      }
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: isSaving.value ? null : () => context.pop(),
                ),
                Expanded(
                  child: Text('Add Record', style: theme.textTheme.titleLarge),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: isSaving.value ? null : () => context.pop(),
                    child: Text(t.common.cancel),
                  ),
                ),
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
                const SizedBox(width: 8),
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
                  const SizedBox(height: 16),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows the add record dialog.
void showAddRecordDialog(
  BuildContext context, {
  required String patientId,
  required Future<PatientRecord?> Function(PatientRecord record) onSave,
  String? appointmentId,
}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: AddRecordDialog(
        patientId: patientId,
        onSave: onSave,
        appointmentId: appointmentId,
      ),
    ),
  );
}
