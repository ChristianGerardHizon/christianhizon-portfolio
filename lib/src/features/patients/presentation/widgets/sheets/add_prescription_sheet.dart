import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../domain/prescription.dart';

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
  final Future<bool> Function(Prescription prescription) onSave;

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
    final instructionsController = useTextEditingController(
      text: existingPrescription?.instructions ?? '',
    );
    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (!formKey.currentState!.validate()) return;

      isSaving.value = true;

      final prescription = Prescription(
        id: existingPrescription?.id ?? '',
        recordId: recordId,
        medication: medicationController.text.trim(),
        dosage: dosageController.text.trim().isEmpty
            ? null
            : dosageController.text.trim(),
        instructions: instructionsController.text.trim().isEmpty
            ? null
            : instructionsController.text.trim(),
        date: existingPrescription?.date ?? DateTime.now(),
      );

      final success = await onSave(prescription);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(isEditing ? 'Prescription updated' : 'Prescription added'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  isEditing ? 'Failed to update prescription' : 'Failed to add prescription'),
            ),
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
                enabled: !isSaving.value,
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
                  labelText: 'Dosage',
                  hintText: 'e.g., 250mg, 2x daily',
                  border: OutlineInputBorder(),
                ),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Instructions
              TextFormField(
                controller: instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions',
                  hintText: 'e.g., Take with food for 7 days',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 24),

              // Buttons
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
      ),
    );
  }
}

/// Shows the add/edit prescription sheet.
void showPrescriptionSheet(
  BuildContext context, {
  required String recordId,
  Prescription? existingPrescription,
  required Future<bool> Function(Prescription prescription) onSave,
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
