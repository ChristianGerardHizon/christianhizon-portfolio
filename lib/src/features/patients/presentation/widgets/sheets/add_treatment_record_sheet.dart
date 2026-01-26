import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient_treatment.dart';
import '../../../domain/patient_treatment_record.dart';
import '../../controllers/patient_treatments_controller.dart';

/// Shows a bottom sheet to add or edit a treatment record.
void showTreatmentRecordSheet(
  BuildContext context, {
  required String patientId,
  PatientTreatmentRecord? existingRecord,
  required Future<PatientTreatmentRecord?> Function(PatientTreatmentRecord)
      onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => AddTreatmentRecordSheet(
      patientId: patientId,
      existingRecord: existingRecord,
      onSave: onSave,
    ),
  );
}

/// Bottom sheet for adding or editing a treatment record.
class AddTreatmentRecordSheet extends HookConsumerWidget {
  const AddTreatmentRecordSheet({
    super.key,
    required this.patientId,
    required this.onSave,
    this.existingRecord,
  });

  final String patientId;
  final PatientTreatmentRecord? existingRecord;
  final Future<PatientTreatmentRecord?> Function(PatientTreatmentRecord) onSave;

  bool get isEditing => existingRecord != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    // Watch treatment catalog
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;
      final treatmentId = values['treatment'] as String?;
      final date = values['date'] as DateTime?;
      final notes = values['notes'] as String?;

      if (treatmentId == null || treatmentId.isEmpty) {
        showErrorSnackBar(context, message: 'Please select a treatment');
        return;
      }

      isSaving.value = true;

      // Find treatment from catalog to get expanded data
      PatientTreatment? selectedTreatment;
      if (treatmentsAsync.hasValue) {
        selectedTreatment = treatmentsAsync.value!.firstWhere(
          (t) => t.id == treatmentId,
          orElse: () => PatientTreatment(id: treatmentId, name: 'Unknown'),
        );
      }

      final record = PatientTreatmentRecord(
        id: existingRecord?.id ?? '',
        treatmentId: treatmentId,
        patientId: patientId,
        treatment: selectedTreatment,
        date: date ?? DateTime.now(),
        notes: notes?.isEmpty == true ? null : notes,
        appointment: existingRecord?.appointment,
        isDeleted: false,
      );

      final result = await onSave(record);

      if (context.mounted) {
        isSaving.value = false;
        if (result != null) {
          Navigator.pop(context);
          showSuccessSnackBar(
            context,
            message: isEditing
                ? 'Treatment record updated'
                : 'Treatment record added',
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

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: FormBuilder(
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

              // Header with actions
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isEditing ? 'Edit Treatment' : 'Add Treatment',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed:
                        isSaving.value ? null : () => Navigator.pop(context),
                    child: Text(t.common.cancel),
                  ),
                  const SizedBox(width: 8),
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
                ],
              ),
              const SizedBox(height: 24),

              // Treatment dropdown
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
                    labelText: 'Treatment *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.healing),
                  ),
                  enabled: !isSaving.value,
                  validator: FormBuilderValidators.required(),
                  items: treatments
                      .map(
                        (t) => DropdownMenuItem(
                          value: t.id,
                          child: Text(t.name),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Date picker
              FormBuilderDateTimePicker(
                name: 'date',
                initialValue: existingRecord?.date ?? DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Notes
              FormBuilderTextField(
                name: 'notes',
                initialValue: existingRecord?.notes,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 3,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
