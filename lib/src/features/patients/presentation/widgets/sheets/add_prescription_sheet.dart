import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../domain/prescription.dart';

/// Frequency options for prescription.
const _frequencyOptions = [
  '1x daily',
  '2x daily',
  '3x daily',
  '4x daily',
  'Every 4 hours',
  'Every 6 hours',
  'Every 8 hours',
  'Weekly',
  'Monthly',
  'As needed',
];

/// Bottom sheet for adding or editing a prescription.
class AddPrescriptionSheet extends HookWidget {
  const AddPrescriptionSheet({
    super.key,
    required this.recordId,
    this.existingPrescription,
    required this.onSave,
  });

  final String recordId;
  final Prescription? existingPrescription;
  final void Function(Prescription prescription) onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isEditing = existingPrescription != null;

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final medicationController = useTextEditingController(
      text: existingPrescription?.medication ?? '',
    );
    final dosageController = useTextEditingController(
      text: existingPrescription?.dosage ?? '',
    );
    final frequency = useState<String>(
      existingPrescription?.frequency ?? '1x daily',
    );
    final durationController = useTextEditingController(
      text: existingPrescription?.duration ?? '',
    );
    final instructionsController = useTextEditingController(
      text: existingPrescription?.instructions ?? '',
    );

    void handleSave() {
      if (!formKey.currentState!.validate()) return;

      final prescription = Prescription(
        id: existingPrescription?.id ?? 'p${DateTime.now().millisecondsSinceEpoch}',
        recordId: recordId,
        medication: medicationController.text.trim(),
        dosage: dosageController.text.trim(),
        frequency: frequency.value,
        duration: durationController.text.trim().isEmpty ? null : durationController.text.trim(),
        instructions: instructionsController.text.trim().isEmpty ? null : instructionsController.text.trim(),
      );

      onSave(prescription);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? 'Prescription updated' : 'Prescription added'),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
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

              Text(
                isEditing ? 'Edit Prescription' : 'Add Prescription',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 24),

              // Medication
              TextFormField(
                controller: medicationController,
                decoration: const InputDecoration(
                  labelText: 'Medication *',
                  hintText: 'e.g., Amoxicillin',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medication),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Medication is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dosage
              TextFormField(
                controller: dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage *',
                  hintText: 'e.g., 250mg',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Dosage is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Frequency dropdown
              DropdownButtonFormField<String>(
                initialValue: frequency.value,
                decoration: const InputDecoration(
                  labelText: 'Frequency *',
                  border: OutlineInputBorder(),
                ),
                items: _frequencyOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    frequency.value = value;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Duration (optional)
              TextFormField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration',
                  hintText: 'e.g., 7 days, 2 weeks',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Instructions (optional)
              TextFormField(
                controller: instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions',
                  hintText: 'e.g., Take with food',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: handleSave,
                      child: Text(t.common.save),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows the add/edit prescription sheet.
void showPrescriptionSheet(
  BuildContext context, {
  required String recordId,
  Prescription? existingPrescription,
  required void Function(Prescription prescription) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => AddPrescriptionSheet(
      recordId: recordId,
      existingPrescription: existingPrescription,
      onSave: onSave,
    ),
  );
}
