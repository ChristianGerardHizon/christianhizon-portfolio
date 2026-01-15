import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../patients/domain/patient_record.dart';
import '../../../../patients/domain/patient_treatment_record.dart';
import '../../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../../../patients/presentation/controllers/patient_treatment_records_controller.dart';
import '../../../../patients/presentation/widgets/sheets/add_record_sheet.dart';
import '../../../../patients/presentation/widgets/sheets/add_treatment_record_sheet.dart';
import '../../../domain/appointment_schedule.dart';
import '../components/linked_items_section.dart';
import 'record_treatment_selector_sheet.dart';

/// Bottom sheet for editing an existing appointment.
class EditAppointmentSheet extends HookConsumerWidget {
  const EditAppointmentSheet({
    super.key,
    required this.appointment,
    required this.onSave,
  });

  final AppointmentSchedule appointment;
  final Future<bool> Function(AppointmentSchedule appointment) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final hasTime = useState(appointment.hasTime);

    // Linked records and treatments (initialized from appointment)
    final linkedRecordIds = useState<List<String>>(appointment.patientRecords);
    final linkedTreatmentIds = useState<List<String>>(appointment.treatmentRecords);

    // Expanded records/treatments for display (tracks newly created items)
    final linkedRecordsExpanded = useState<List<PatientRecord>>(
      appointment.patientRecordsExpanded,
    );
    final linkedTreatmentsExpanded = useState<List<PatientTreatmentRecord>>(
      appointment.treatmentRecordsExpanded,
    );

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;

      isSaving.value = true;

      final date = values['date'] as DateTime;
      final time = values['time'] as DateTime?;

      // Combine date and time if provided
      DateTime finalDate;
      if (hasTime.value && time != null) {
        finalDate = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      } else {
        finalDate = DateTime(date.year, date.month, date.day);
      }

      final updated = AppointmentSchedule(
        id: appointment.id,
        date: finalDate,
        hasTime: hasTime.value,
        purpose: values['purpose'] as String?,
        notes: values['notes'] as String?,
        status: appointment.status,
        patient: appointment.patient,
        patientRecords: linkedRecordIds.value,
        treatmentRecords: linkedTreatmentIds.value,
        branch: appointment.branch,
        patientName: appointment.patientName,
        ownerName: appointment.ownerName,
        ownerContact: appointment.ownerContact,
        isDeleted: appointment.isDeleted,
        patientExpanded: appointment.patientExpanded,
        patientRecordsExpanded: appointment.patientRecordsExpanded,
        treatmentRecordsExpanded: appointment.treatmentRecordsExpanded,
        created: appointment.created,
        updated: appointment.updated,
      );

      final success = await onSave(updated);

      if (context.mounted) {
        isSaving.value = false;
        if (success) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update appointment')),
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

              Text('Edit Appointment', style: theme.textTheme.titleLarge),
              const SizedBox(height: 24),

              // Patient info (read-only)
              Card(
                child: ListTile(
                  leading: Icon(Icons.pets, color: theme.colorScheme.primary),
                  title: Text(appointment.patientDisplayName),
                  subtitle: Text(appointment.ownerDisplayName),
                ),
              ),
              const SizedBox(height: 16),

              // Date picker
              FormBuilderDateTimePicker(
                name: 'date',
                decoration: const InputDecoration(
                  labelText: 'Date *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                inputType: InputType.date,
                initialValue: appointment.date,
                validator: FormBuilderValidators.required(),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Time toggle
              SwitchListTile(
                title: const Text('Include specific time'),
                value: hasTime.value,
                onChanged: isSaving.value ? null : (value) => hasTime.value = value,
                contentPadding: EdgeInsets.zero,
              ),

              // Time picker (conditional)
              if (hasTime.value) ...[
                FormBuilderDateTimePicker(
                  name: 'time',
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  inputType: InputType.time,
                  initialValue: appointment.hasTime ? appointment.date : DateTime.now(),
                  enabled: !isSaving.value,
                ),
                const SizedBox(height: 16),
              ],

              // Purpose
              FormBuilderTextField(
                name: 'purpose',
                decoration: const InputDecoration(
                  labelText: 'Purpose',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description_outlined),
                  hintText: 'e.g., Check-up, Vaccination, Surgery',
                ),
                initialValue: appointment.purpose,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Notes
              FormBuilderTextField(
                name: 'notes',
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
                initialValue: appointment.notes,
                maxLines: 3,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Linked items section
              LinkedItemsSection(
                patientRecords: linkedRecordsExpanded.value,
                treatmentRecords: linkedTreatmentsExpanded.value,
                showActions: !isSaving.value,
                onLinkExistingPressed: appointment.patient != null
                    ? () => _showRecordTreatmentSelector(
                          context: context,
                          patientId: appointment.patient!,
                          linkedRecordIds: linkedRecordIds,
                          linkedTreatmentIds: linkedTreatmentIds,
                          linkedRecordsExpanded: linkedRecordsExpanded,
                          linkedTreatmentsExpanded: linkedTreatmentsExpanded,
                        )
                    : null,
                onAddRecordPressed: appointment.patient != null
                    ? () => _showAddRecordSheet(
                          context: context,
                          ref: ref,
                          patientId: appointment.patient!,
                          appointmentId: appointment.id,
                          linkedRecordIds: linkedRecordIds,
                          linkedRecordsExpanded: linkedRecordsExpanded,
                        )
                    : null,
                onAddTreatmentPressed: appointment.patient != null
                    ? () => _showAddTreatmentSheet(
                          context: context,
                          ref: ref,
                          patientId: appointment.patient!,
                          appointmentId: appointment.id,
                          linkedTreatmentIds: linkedTreatmentIds,
                          linkedTreatmentsExpanded: linkedTreatmentsExpanded,
                        )
                    : null,
              ),
              const SizedBox(height: 24),

              // Action buttons
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

  void _showRecordTreatmentSelector({
    required BuildContext context,
    required String patientId,
    required ValueNotifier<List<String>> linkedRecordIds,
    required ValueNotifier<List<String>> linkedTreatmentIds,
    required ValueNotifier<List<PatientRecord>> linkedRecordsExpanded,
    required ValueNotifier<List<PatientTreatmentRecord>> linkedTreatmentsExpanded,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => RecordTreatmentSelectorSheet(
        patientId: patientId,
        selectedRecordIds: linkedRecordIds.value,
        selectedTreatmentIds: linkedTreatmentIds.value,
        onSave: (recordIds, treatmentIds) {
          linkedRecordIds.value = recordIds;
          linkedTreatmentIds.value = treatmentIds;
          // Note: expanded data will be refreshed when appointment is saved and reloaded
        },
      ),
    );
  }

  void _showAddRecordSheet({
    required BuildContext context,
    required WidgetRef ref,
    required String patientId,
    required String appointmentId,
    required ValueNotifier<List<String>> linkedRecordIds,
    required ValueNotifier<List<PatientRecord>> linkedRecordsExpanded,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => AddRecordSheet(
        patientId: patientId,
        appointmentId: appointmentId,
        onSave: (record) async {
          final created = await ref
              .read(patientRecordsControllerProvider(patientId).notifier)
              .createRecordAndReturn(record);

          if (created != null) {
            // Add to linked IDs and expanded list
            linkedRecordIds.value = [...linkedRecordIds.value, created.id];
            linkedRecordsExpanded.value = [
              ...linkedRecordsExpanded.value,
              created,
            ];
          }
          return created;
        },
      ),
    );
  }

  void _showAddTreatmentSheet({
    required BuildContext context,
    required WidgetRef ref,
    required String patientId,
    required String appointmentId,
    required ValueNotifier<List<String>> linkedTreatmentIds,
    required ValueNotifier<List<PatientTreatmentRecord>> linkedTreatmentsExpanded,
  }) {
    showTreatmentRecordSheet(
      context,
      patientId: patientId,
      appointmentId: appointmentId,
      onSave: (record) async {
        final created = await ref
            .read(patientTreatmentRecordsControllerProvider(patientId).notifier)
            .createTreatmentRecordAndReturn(record);

        if (created != null) {
          // Add to linked IDs and expanded list
          linkedTreatmentIds.value = [...linkedTreatmentIds.value, created.id];
          linkedTreatmentsExpanded.value = [
            ...linkedTreatmentsExpanded.value,
            created,
          ];
        }
        return created;
      },
    );
  }
}
