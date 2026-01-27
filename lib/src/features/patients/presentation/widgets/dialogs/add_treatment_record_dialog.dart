import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient_treatment.dart';
import '../../../domain/patient_treatment_record.dart';
import '../../controllers/patient_treatments_controller.dart';

/// Shows a dialog to add or edit a treatment record.
void showTreatmentRecordDialog(
  BuildContext context, {
  required String patientId,
  PatientTreatmentRecord? existingRecord,
  required Future<PatientTreatmentRecord?> Function(PatientTreatmentRecord)
      onSave,
}) {
  showConstrainedDialog(
    context: context,
    builder: (context) => AddTreatmentRecordDialog(
      patientId: patientId,
      existingRecord: existingRecord,
      onSave: onSave,
    ),
  );
}

/// Dialog for adding or editing a treatment record.
class AddTreatmentRecordDialog extends HookConsumerWidget {
  const AddTreatmentRecordDialog({
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
    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: existingRecord != null
          ? {
              'treatment': existingRecord!.treatmentId,
              'date': existingRecord!.date,
              'notes': existingRecord!.notes,
            }
          : null,
    );
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
          context.pop();
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

    return DialogCloseHandler(
      onClose: (ctx) => dirtyGuard.confirmDiscard(ctx),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: dirtyGuard.onPopInvokedWithResult,
        child: ConstrainedDialogContent(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: isSaving.value
                          ? null
                          : () async {
                              if (await dirtyGuard.confirmDiscard(context)) {
                                if (context.mounted) context.pop();
                              }
                            },
                    ),
                    Expanded(
                      child: Text(
                        isEditing ? 'Edit Treatment' : 'Add Treatment',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: isSaving.value
                          ? null
                          : () async {
                              if (await dirtyGuard.confirmDiscard(context)) {
                                if (context.mounted) context.pop();
                              }
                            },
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
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),

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
            ),
          ],
          ),
        ),
      ),
    );
  }
}
