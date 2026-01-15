import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient_treatment_record.dart';
import '../../controllers/patient_treatments_controller.dart';

/// Bottom sheet for adding or editing a treatment record.
class AddTreatmentRecordSheet extends HookConsumerWidget {
  const AddTreatmentRecordSheet({
    super.key,
    required this.patientId,
    required this.scrollController,
    this.existingRecord,
    required this.onSave,
  });

  final String patientId;
  final ScrollController scrollController;
  final PatientTreatmentRecord? existingRecord;
  final Future<bool> Function(PatientTreatmentRecord record) onSave;

  static const _fieldLabels = {
    'treatment': 'Treatment Type',
    'date': 'Date',
    'notes': 'Notes',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isEditing = existingRecord != null;

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    // Watch treatment catalog
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);

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

      final record = PatientTreatmentRecord(
        id: existingRecord?.id ?? '',
        treatmentId: values['treatment'] as String,
        patientId: patientId,
        date: values['date'] as DateTime? ?? DateTime.now(),
        notes: _nullIfEmpty(values['notes'] as String?),
      );

      final success = await onSave(record);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          context.pop();
          showSuccessSnackBar(
            context,
            message:
                isEditing ? 'Treatment record updated' : 'Treatment record added',
          );
        } else {
          showErrorSnackBar(
            context,
            message: isEditing
                ? 'Failed to update treatment record'
                : 'Failed to add treatment record',
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
                  isEditing ? 'Edit Treatment Record' : 'Add Treatment Record',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24),

                // Treatment Type Dropdown
                treatmentsAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => Text(
                    'Failed to load treatments',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  data: (treatments) => FormBuilderDropdown<String>(
                    name: 'treatment',
                    initialValue: existingRecord?.treatmentId,
                    decoration: const InputDecoration(
                      labelText: 'Treatment Type *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.healing),
                    ),
                    enabled: !isSaving.value,
                    validator: FormBuilderValidators.required(
                      errorText: 'Treatment type is required',
                    ),
                    items: treatments
                        .map(
                          (treatment) => DropdownMenuItem(
                            value: treatment.id,
                            child: Text(treatment.name),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Date
                FormBuilderDateTimePicker(
                  name: 'date',
                  initialValue: existingRecord?.date ?? DateTime.now(),
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

                // Notes
                FormBuilderTextField(
                  name: 'notes',
                  initialValue: existingRecord?.notes ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Additional notes about this treatment',
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

/// Shows the add/edit treatment record sheet with fullscreen draggable functionality.
void showTreatmentRecordSheet(
  BuildContext context, {
  required String patientId,
  PatientTreatmentRecord? existingRecord,
  required Future<bool> Function(PatientTreatmentRecord record) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => AddTreatmentRecordSheet(
        patientId: patientId,
        scrollController: scrollController,
        existingRecord: existingRecord,
        onSave: onSave,
      ),
    ),
  );
}
