import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/prescription.dart';

/// Bottom sheet for adding or editing a prescription.
class AddPrescriptionSheet extends HookConsumerWidget {
  const AddPrescriptionSheet({
    super.key,
    required this.recordId,
    required this.scrollController,
    this.existingPrescription,
    required this.onSave,
  });

  final String recordId;
  final ScrollController scrollController;
  final Prescription? existingPrescription;
  final Future<bool> Function(Prescription prescription) onSave;

  static const _fieldLabels = {
    'medication': 'Medication',
    'dosage': 'Dosage',
    'instructions': 'Instructions',
    'date': 'Date',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isEditing = existingPrescription != null;

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      if (!isValid) {
        final errors = formKey.currentState?.errors ?? {};
        final errorMessages = formatFormErrors(errors, _fieldLabels);
        if (errorMessages.isNotEmpty) {
          showFormErrorDialog(context, errors: errorMessages);
        }
        return;
      }

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final prescription = Prescription(
        id: existingPrescription?.id ?? '',
        recordId: recordId,
        medication: (values['medication'] as String).trim(),
        dosage: _nullIfEmpty(values['dosage'] as String?),
        instructions: _nullIfEmpty(values['instructions'] as String?),
        date: values['date'] as DateTime? ?? DateTime.now(),
      );

      final success = await onSave(prescription);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          context.pop();
          showSuccessSnackBar(
            context,
            message: isEditing ? 'Prescription updated' : 'Prescription added',
          );
        } else {
          showErrorSnackBar(
            context,
            message: isEditing
                ? 'Failed to update prescription'
                : 'Failed to add prescription',
          );
        }
      }
    }

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
        child: FormBuilder(
          key: formKey,
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

                Text(
                  isEditing ? 'Edit Prescription' : 'Add Prescription',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24),

                // Medication
                FormBuilderTextField(
                  name: 'medication',
                  initialValue: existingPrescription?.medication ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Medication *',
                    hintText: 'e.g., Amoxicillin',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.medication),
                  ),
                  textCapitalization: TextCapitalization.words,
                  enabled: !isSaving.value,
                  validator: FormBuilderValidators.required(
                    errorText: 'Medication is required',
                  ),
                ),
                const SizedBox(height: 16),

                // Date
                FormBuilderDateTimePicker(
                  name: 'date',
                  initialValue: existingPrescription?.date ?? DateTime.now(),
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  enabled: !isSaving.value,
                  inputType: InputType.date,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                ),
                const SizedBox(height: 16),

                // Dosage
                FormBuilderTextField(
                  name: 'dosage',
                  initialValue: existingPrescription?.dosage ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Dosage',
                    hintText: 'e.g., 250mg, 2x daily',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.scale),
                  ),
                  enabled: !isSaving.value,
                ),
                const SizedBox(height: 16),

                // Instructions
                FormBuilderTextField(
                  name: 'instructions',
                  initialValue: existingPrescription?.instructions ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Instructions',
                    hintText: 'e.g., Take with food for 7 days',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.notes),
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
                        onPressed: isSaving.value ? null : () => context.pop(),
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
      ),
    );
  }

  String? _nullIfEmpty(String? text) {
    if (text == null) return null;
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

/// Shows the add/edit prescription sheet with fullscreen draggable functionality.
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
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => AddPrescriptionSheet(
        recordId: recordId,
        scrollController: scrollController,
        existingPrescription: existingPrescription,
        onSave: onSave,
      ),
    ),
  );
}
