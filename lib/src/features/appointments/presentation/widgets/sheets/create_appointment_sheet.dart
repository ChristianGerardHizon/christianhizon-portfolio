import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../messages/domain/message.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
import '../../../../patients/domain/patient.dart';
import '../../../../patients/domain/patient_record.dart';
import '../../../../patients/domain/patient_treatment_record.dart';
import '../../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../../../patients/presentation/controllers/patient_treatment_records_controller.dart';
import '../../../../patients/presentation/controllers/patients_controller.dart';
import '../../../../settings/presentation/controllers/message_templates_controller.dart';
import '../../../../patients/presentation/widgets/sheets/add_record_sheet.dart';
import '../../../../patients/presentation/widgets/sheets/add_treatment_record_sheet.dart';
import '../../../../treatment_plans/domain/treatment_plan_item.dart';
import '../../../domain/appointment_schedule.dart';
import '../components/linked_items_section.dart';
import 'record_treatment_selector_sheet.dart';

/// Bottom sheet for creating a new appointment.
class CreateAppointmentSheet extends HookConsumerWidget {
  const CreateAppointmentSheet({
    super.key,
    this.initialPatient,
    this.treatmentPlanItem,
    this.initialPurpose,
    required this.onSave,
  });

  /// Pre-selected patient (when creating from patient context).
  final Patient? initialPatient;

  /// Treatment plan item to link (when booking from a treatment plan).
  final TreatmentPlanItem? treatmentPlanItem;

  /// Pre-filled purpose (when booking from a treatment plan).
  final String? initialPurpose;

  /// Callback when appointment is saved.
  /// Returns the created appointment on success, or null on failure.
  final Future<AppointmentSchedule?> Function(AppointmentSchedule appointment)
      onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final hasTime = useState(false);
    final selectedPatient = useState<Patient?>(initialPatient);
    final sendReminder = useState(false);

    // Linked records and treatments (IDs for existing items)
    final linkedRecordIds = useState<List<String>>([]);
    final linkedTreatmentIds = useState<List<String>>([]);

    // Expanded records/treatments for display (tracks newly created items)
    final linkedRecordsExpanded = useState<List<PatientRecord>>([]);
    final linkedTreatmentsExpanded = useState<List<PatientTreatmentRecord>>([]);

    // Watch patients for dropdown
    final patientsAsync = ref.watch(patientsControllerProvider);

    // Watch templates for dropdown
    final templatesAsync = ref.watch(messageTemplatesControllerProvider);

    String replacePlaceholders(String content, Patient? patient) {
      if (content.isEmpty) return content;

      var replaced = content;

      // Replace patient data
      if (patient != null) {
        replaced = replaced.replaceAll('{patientName}', patient.name);
        replaced =
            replaced.replaceAll('{patientPhone}', patient.contactNumber ?? '');
        replaced = replaced.replaceAll('{ownerName}', patient.owner ?? '');
        replaced = replaced.replaceAll('{species}', patient.species ?? '');
        replaced = replaced.replaceAll('{breed}', patient.breed ?? '');
        replaced = replaced.replaceAll('{email}', patient.email ?? '');
        replaced = replaced.replaceAll('{address}', patient.address ?? '');
      }

      // Replace appointment info
      final date = formKey.currentState?.fields['date']?.value as DateTime?;
      if (date != null) {
        replaced = replaced.replaceAll(
            '{treatmentDate}', DateFormat('MMM d, yyyy').format(date));
      }

      final purpose = formKey.currentState?.fields['purpose']?.value as String?;
      if (purpose != null && purpose.isNotEmpty) {
        replaced = replaced.replaceAll('{treatmentName}', purpose);
      }

      final notes = formKey.currentState?.fields['notes']?.value as String?;
      if (notes != null && notes.isNotEmpty) {
        replaced = replaced.replaceAll('{treatmentNotes}', notes);
      }

      return replaced;
    }

    // Helper to update records with appointment ID after creation (deferred linking)
    Future<void> updateRecordsWithAppointmentId(
        String appointmentId, String patientId) async {
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
              .read(
                  patientTreatmentRecordsControllerProvider(patientId).notifier)
              .updateTreatmentRecord(updated);
        }
      }
    }

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;
      final patient = selectedPatient.value;

      if (patient == null) {
        showErrorSnackBar(context, message: 'Please select a patient');
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
        treatmentPlanItem: treatmentPlanItem?.id,
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

          // Create reminder message if enabled
          if (sendReminder.value &&
              patient.contactNumber != null &&
              patient.contactNumber!.isNotEmpty) {
            final values = formKey.currentState!.value;
            final messageContent = values['reminderMessage'] as String?;

            if (messageContent != null && messageContent.isNotEmpty) {
              // Schedule reminder for 1 day before at 9:00 AM
              final reminderDate = finalDate.subtract(const Duration(days: 1));
              final sendDateTime = DateTime(
                reminderDate.year,
                reminderDate.month,
                reminderDate.day,
                9, // 9:00 AM
                0,
              );

              final message = Message(
                id: '',
                phone: patient.contactNumber!,
                content: messageContent,
                sendDateTime: sendDateTime,
                patient: patient.id,
                appointment: created.id,
                notes: 'Appointment reminder',
              );

              await ref
                  .read(messagesControllerProvider.notifier)
                  .createMessage(message);
            }
          }

          isSaving.value = false;
          Navigator.pop(context);
          showSuccessSnackBar(
            context,
            message: sendReminder.value
                ? 'Appointment created with reminder'
                : 'Appointment created successfully',
          );
        } else {
          isSaving.value = false;
          showErrorSnackBar(context, message: 'Failed to create appointment');
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

              // === HEADER WITH ACTIONS ===
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Appointment',
                            style: theme.textTheme.titleLarge),
                        if (treatmentPlanItem != null) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Session ${treatmentPlanItem!.sequence} of Treatment Plan',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ],
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
                            (patient.owner?.toLowerCase().contains(query) ??
                                false);
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
                decoration: InputDecoration(
                  labelText: 'Date *',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  helperText: treatmentPlanItem != null
                      ? 'Pre-filled from treatment plan'
                      : null,
                ),
                inputType: InputType.date,
                initialValue: treatmentPlanItem?.expectedDate ?? DateTime.now(),
                validator: FormBuilderValidators.required(),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Time toggle
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SwitchListTile(
                  title: const Text('Include specific time'),
                  value: hasTime.value,
                  onChanged:
                      isSaving.value ? null : (value) => hasTime.value = value,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              if (hasTime.value) const SizedBox(height: 16),

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
                initialValue: initialPurpose,
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

              // === REMINDER MESSAGE SECTION ===
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_active,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Send Reminder Message',
                            style: theme.textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Switch(
                            value: sendReminder.value,
                            onChanged: isSaving.value
                                ? null
                                : (value) => sendReminder.value = value,
                          ),
                        ],
                      ),
                      if (sendReminder.value) ...[
                        const SizedBox(height: 8),
                        Text(
                          'A reminder will be sent 1 day before the appointment',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (selectedPatient.value == null) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: theme.colorScheme.onErrorContainer,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Please select a patient first',
                                    style: TextStyle(
                                      color: theme.colorScheme.onErrorContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (selectedPatient.value!.contactNumber ==
                                null ||
                            selectedPatient.value!.contactNumber!.isEmpty) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: theme.colorScheme.onErrorContainer,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'No contact number on file for this patient',
                                    style: TextStyle(
                                      color: theme.colorScheme.onErrorContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          // Phone number display
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'To: ${selectedPatient.value!.contactNumber}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (selectedPatient.value!.owner != null &&
                                    selectedPatient.value!.owner!.isNotEmpty)
                                  Text(
                                    ' (${selectedPatient.value!.owner})',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Template selector
                          templatesAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (_, __) => const SizedBox.shrink(),
                            data: (templates) {
                              if (templates.isEmpty)
                                return const SizedBox.shrink();
                              return Column(
                                children: [
                                  FormBuilderDropdown<String>(
                                    name: 'template',
                                    decoration: const InputDecoration(
                                      labelText: 'Use Template',
                                      border: OutlineInputBorder(),
                                      prefixIcon:
                                          Icon(Icons.description_outlined),
                                      helperText:
                                          'Select a template to auto-fill reminder',
                                    ),
                                    onChanged: (value) {
                                      if (value != null) {
                                        final template = templates
                                            .firstWhere((t) => t.id == value);
                                        final finalContent =
                                            replacePlaceholders(
                                          template.content,
                                          selectedPatient.value,
                                        );
                                        formKey.currentState
                                            ?.fields['reminderMessage']
                                            ?.didChange(finalContent);
                                      }
                                    },
                                    items: templates
                                        .map((t) => DropdownMenuItem(
                                              value: t.id,
                                              child: Text(t.name),
                                            ))
                                        .toList(),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          ),

                          // Message content
                          FormBuilderTextField(
                            name: 'reminderMessage',
                            initialValue: _getDefaultReminderMessage(
                                selectedPatient.value!.name),
                            decoration: const InputDecoration(
                              labelText: 'Message *',
                              hintText: 'Enter reminder message',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.sms),
                            ),
                            maxLines: 3,
                            enabled: !isSaving.value,
                            validator: sendReminder.value
                                ? FormBuilderValidators.required(
                                    errorText: 'Message content is required',
                                  )
                                : null,
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
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
              // Bottom actions removed (moved to header)
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
    required ValueNotifier<List<PatientTreatmentRecord>>
        linkedTreatmentsExpanded,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
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
            linkedRecordsExpanded.value = [
              ...linkedRecordsExpanded.value,
              created
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
    required ValueNotifier<List<String>> linkedTreatmentIds,
    required ValueNotifier<List<PatientTreatmentRecord>>
        linkedTreatmentsExpanded,
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
          linkedTreatmentsExpanded.value = [
            ...linkedTreatmentsExpanded.value,
            created
          ];
        }
        return created;
      },
    );
  }

  String _getDefaultReminderMessage(String patientName) {
    return 'Hello! This is a reminder about your appointment tomorrow for $patientName '
        'at San Jose Vet Clinic. Please contact us if you need to reschedule.';
  }
}
