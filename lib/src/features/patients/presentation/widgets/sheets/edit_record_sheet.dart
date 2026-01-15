import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../domain/patient_record.dart';
import '../../controllers/patient_records_controller.dart';

/// Bottom sheet for editing an existing patient record.
class EditRecordSheet extends HookConsumerWidget {
  const EditRecordSheet({
    super.key,
    required this.record,
  });

  final PatientRecord record;

  /// Parses a value with unit suffix (e.g., "5.2 kg" -> "5.2").
  static String _parseValueWithUnit(String value, String unit) {
    if (value.isEmpty) return '';
    return value.replaceAll(unit, '').trim();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Pre-populate controllers with existing values
    final diagnosisController = useTextEditingController(
      text: record.diagnosis,
    );
    final weightController = useTextEditingController(
      text: _parseValueWithUnit(record.weight, 'kg'),
    );
    final temperatureController = useTextEditingController(
      text: _parseValueWithUnit(record.temperature, '°C'),
    );
    final notesController = useTextEditingController(
      text: record.notes ?? '',
    );

    final selectedDate = useState(record.date);
    final isSaving = useState(false);

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        // Preserve the time from the original date
        selectedDate.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          record.date.hour,
          record.date.minute,
        );
      }
    }

    Future<void> handleSave() async {
      if (diagnosisController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Diagnosis is required')),
        );
        return;
      }

      isSaving.value = true;

      final updatedRecord = PatientRecord(
        id: record.id,
        patientId: record.patientId,
        date: selectedDate.value,
        diagnosis: diagnosisController.text,
        weight: weightController.text.isEmpty
            ? ''
            : '${weightController.text} kg',
        temperature: temperatureController.text.isEmpty
            ? ''
            : '${temperatureController.text} °C',
        notes: notesController.text.isEmpty ? null : notesController.text,
        treatment: record.treatment,
        tests: record.tests,
        branch: record.branch,
        isDeleted: record.isDeleted,
        created: record.created,
        updated: record.updated,
      );

      final success = await ref
          .read(patientRecordsControllerProvider(record.patientId).notifier)
          .updateRecord(updatedRecord);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Record updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update record')),
          );
        }
      }
    }

    String formatDate(DateTime date) {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
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

            Text('Edit Record', style: theme.textTheme.titleLarge),
            const SizedBox(height: 24),

            // Date picker
            InkWell(
              onTap: isSaving.value ? null : pickDate,
              borderRadius: BorderRadius.circular(4),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Visit Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(formatDate(selectedDate.value)),
              ),
            ),
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
