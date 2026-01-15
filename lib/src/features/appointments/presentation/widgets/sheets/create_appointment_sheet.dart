import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../patients/domain/patient.dart';
import '../../../../patients/domain/patient_record.dart';
import '../../../../patients/domain/patient_treatment_record.dart';
import '../../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../../../patients/presentation/controllers/patient_treatment_records_controller.dart';
import '../../../../patients/presentation/controllers/patients_controller.dart';
import '../../../../patients/presentation/widgets/sheets/add_record_sheet.dart';
import '../../../../patients/presentation/widgets/sheets/add_treatment_record_sheet.dart';
import '../../../domain/appointment_schedule.dart';
import '../components/linked_items_section.dart';
import 'record_treatment_selector_sheet.dart';

/// Bottom sheet for creating a new appointment.
class CreateAppointmentSheet extends HookConsumerWidget {
  const CreateAppointmentSheet({
    super.key,
    this.initialPatient,
    required this.onSave,
  });

  /// Pre-selected patient (when creating from patient context).
  final Patient? initialPatient;

  /// Callback when appointment is saved.
  /// Returns the created appointment on success, or null on failure.
  final Future<AppointmentSchedule?> Function(AppointmentSchedule appointment) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final hasTime = useState(false);
    final selectedPatient = useState<Patient?>(initialPatient);

    // Linked records and treatments (IDs for existing items)
    final linkedRecordIds = useState<List<String>>([]);
    final linkedTreatmentIds = useState<List<String>>([]);

    // Expanded records/treatments for display (tracks newly created items)
    final linkedRecordsExpanded = useState<List<PatientRecord>>([]);
    final linkedTreatmentsExpanded = useState<List<PatientTreatmentRecord>>([]);

    // Watch patients for dropdown
    final patientsAsync = ref.watch(patientsControllerProvider);

    // Helper to update records with appointment ID after creation (deferred linking)
    Future<void> updateRecordsWithAppointmentId(String appointmentId, String patientId) async {
      // Update patient records with the appointment ID
      for (final record in linkedRecordsExpanded.value) {
        if (record.appointment == null || record.appointment!.isEmpty) {
          final updated = PatientRecord(
            id: record.id,
            patientId: record.patientId,
            date: record.date,
            diagnosis: record.diagnosis,
            weight: record.weight,
            temperature: record.temperature,
            notes: record.notes,
            appointment: appointmentId,
            isDeleted: record.isDeleted,
            created: record.created,
            updated: record.updated,
          );
          await ref
              .read(patientRecordsControllerProvider(patientId).notifier)
              .updateRecord(updated);
        }
      }

      // Update treatment records with the appointment ID
      for (final treatment in linkedTreatmentsExpanded.value) {
        if (treatment.appointment == null || treatment.appointment!.isEmpty) {
          final updated = PatientTreatmentRecord(
            id: treatment.id,
            treatmentId: treatment.treatmentId,
            patientId: treatment.patientId,
            treatment: treatment.treatment,
            date: treatment.date,
            notes: treatment.notes,
            appointment: appointmentId,
            isDeleted: treatment.isDeleted,
            created: treatment.created,
            updated: treatment.updated,
          );
          await ref
              .read(patientTreatmentRecordsControllerProvider(patientId).notifier)
              .updateTreatmentRecord(updated);
        }
      }
    }

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;
      final patient = selectedPatient.value;

      if (patient == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a patient')),
        );
        return;
      }

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

      final appointment = AppointmentSchedule(
        id: '', // Will be assigned by PocketBase
        date: finalDate,
        hasTime: hasTime.value,
        purpose: values['purpose'] as String?,
        notes: values['notes'] as String?,
        status: AppointmentScheduleStatus.scheduled,
        patient: patient.id,
        patientRecords: linkedRecordIds.value,
        treatmentRecords: linkedTreatmentIds.value,
        patientName: patient.name,
        ownerName: patient.owner,
        ownerContact: patient.contactNumber,
        isDeleted: false,
      );

      final created = await onSave(appointment);

      if (context.mounted) {
        if (created != null) {
          // Update newly created records with the appointment ID (deferred linking)
          await updateRecordsWithAppointmentId(created.id, patient.id);

          isSaving.value = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment created successfully')),
          );
        } else {
          isSaving.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create appointment')),
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

              Text('New Appointment', style: theme.textTheme.titleLarge),
              const SizedBox(height: 24),

              // Patient selector
              if (initialPatient != null) ...[
                // Show selected patient as read-only
                Card(
                  child: ListTile(
                    leading: Icon(Icons.pets, color: theme.colorScheme.primary),
                    title: Text(initialPatient!.name),
                    subtitle: Text(initialPatient!.owner ?? 'No owner'),
                  ),
                ),
              ] else ...[
                // Searchable patient dropdown
                patientsAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('Error loading patients'),
                  data: (patients) => Autocomplete<Patient>(
                    displayStringForOption: (patient) =>
                        '${patient.name} (${patient.owner ?? 'No owner'})',
                    optionsBuilder: (textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return patients.take(10);
                      }
                      final query = textEditingValue.text.toLowerCase();
                      return patients.where((patient) {
                        return patient.name.toLowerCase().contains(query) ||
                            (patient.owner?.toLowerCase().contains(query) ?? false);
                      }).take(10);
                    },
                    onSelected: (patient) {
                      selectedPatient.value = patient;
                    },
                    fieldViewBuilder: (
                      context,
                      textController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'Patient *',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.pets),
                          suffixIcon: selectedPatient.value != null
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    textController.clear();
                                    selectedPatient.value = null;
                                  },
                                )
                              : null,
                        ),
                        enabled: !isSaving.value,
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(8),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final patient = options.elementAt(index);
                                return ListTile(
                                  leading: const Icon(Icons.pets),
                                  title: Text(patient.name),
                                  subtitle: Text(patient.owner ?? 'No owner'),
                                  onTap: () => onSelected(patient),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
                initialValue: DateTime.now(),
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
                  initialValue: DateTime.now(),
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
                maxLines: 3,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Link records/treatments section
              if (selectedPatient.value != null) ...[
                LinkedItemsSection(
                  patientRecords: linkedRecordsExpanded.value,
                  treatmentRecords: linkedTreatmentsExpanded.value,
                  showActions: !isSaving.value,
                  onLinkExistingPressed: () => _showRecordTreatmentSelector(
                    context: context,
                    ref: ref,
                    patientId: selectedPatient.value!.id,
                    linkedRecordIds: linkedRecordIds,
                    linkedTreatmentIds: linkedTreatmentIds,
                    linkedRecordsExpanded: linkedRecordsExpanded,
                    linkedTreatmentsExpanded: linkedTreatmentsExpanded,
                  ),
                  onAddRecordPressed: () => _showAddRecordSheet(
                    context: context,
                    ref: ref,
                    patientId: selectedPatient.value!.id,
                    linkedRecordIds: linkedRecordIds,
                    linkedRecordsExpanded: linkedRecordsExpanded,
                  ),
                  onAddTreatmentPressed: () => _showAddTreatmentSheet(
                    context: context,
                    ref: ref,
                    patientId: selectedPatient.value!.id,
                    linkedTreatmentIds: linkedTreatmentIds,
                    linkedTreatmentsExpanded: linkedTreatmentsExpanded,
                  ),
                ),
              ] else ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Select a patient first to link records or treatments.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
    required WidgetRef ref,
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
          // Note: For existing items selected here, we don't track expanded data
          // since they already exist and will be linked via IDs when appointment is saved
        },
      ),
    );
  }

  void _showAddRecordSheet({
    required BuildContext context,
    required WidgetRef ref,
    required String patientId,
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
        // No appointmentId since appointment doesn't exist yet
        onSave: (record) async {
          final created = await ref
              .read(patientRecordsControllerProvider(patientId).notifier)
              .createRecordAndReturn(record);
          if (created != null) {
            linkedRecordIds.value = [...linkedRecordIds.value, created.id];
            linkedRecordsExpanded.value = [...linkedRecordsExpanded.value, created];
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
    required ValueNotifier<List<String>> linkedTreatmentIds,
    required ValueNotifier<List<PatientTreatmentRecord>> linkedTreatmentsExpanded,
  }) {
    showTreatmentRecordSheet(
      context,
      patientId: patientId,
      // No appointmentId since appointment doesn't exist yet
      onSave: (treatment) async {
        final created = await ref
            .read(patientTreatmentRecordsControllerProvider(patientId).notifier)
            .createTreatmentRecordAndReturn(treatment);
        if (created != null) {
          linkedTreatmentIds.value = [...linkedTreatmentIds.value, created.id];
          linkedTreatmentsExpanded.value = [...linkedTreatmentsExpanded.value, created];
        }
        return created;
      },
    );
  }
}
