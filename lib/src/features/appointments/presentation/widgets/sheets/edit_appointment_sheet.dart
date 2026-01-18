import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../messages/domain/message.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
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
    final sendReminder = useState(false);

    // Check if appointment is in the future
    final isFutureAppointment = appointment.date.isAfter(DateTime.now());

    // Watch existing reminder messages for this appointment
    final existingMessagesAsync =
        ref.watch(messagesByAppointmentProvider(appointment.id));

    // Linked records and treatments (initialized from appointment)
    final linkedRecordIds = useState<List<String>>(appointment.patientRecords);
    final linkedTreatmentIds =
        useState<List<String>>(appointment.treatmentRecords);

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
        if (success) {
          // Create reminder message if enabled
          if (sendReminder.value &&
              appointment.ownerContact != null &&
              appointment.ownerContact!.isNotEmpty) {
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
                phone: appointment.ownerContact!,
                content: messageContent,
                sendDateTime: sendDateTime,
                patient: appointment.patient,
                appointment: appointment.id,
                notes: 'Appointment reminder',
              );

              await ref
                  .read(messagesControllerProvider.notifier)
                  .createMessage(message);
            }
          }

          isSaving.value = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(sendReminder.value
                  ? 'Appointment updated with reminder'
                  : 'Appointment updated successfully'),
            ),
          );
        } else {
          isSaving.value = false;
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

              // === HEADER WITH ACTIONS ===
              Row(
                children: [
                  Expanded(
                    child: Text('Edit Appointment',
                        style: theme.textTheme.titleLarge),
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
                onChanged:
                    isSaving.value ? null : (value) => hasTime.value = value,
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
                  initialValue:
                      appointment.hasTime ? appointment.date : DateTime.now(),
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

              // === REMINDER MESSAGE SECTION ===
              if (isFutureAppointment) ...[
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
                              'Reminder Message',
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        existingMessagesAsync.when(
                          loading: () => const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          error: (_, __) => Text(
                            'Could not load reminder info',
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                          data: (messages) {
                            // Check for pending reminder messages
                            final pendingReminders = messages
                                .where((m) => m.status == MessageStatus.pending)
                                .toList();

                            if (pendingReminders.isNotEmpty) {
                              // Show existing reminder info
                              final reminder = pendingReminders.first;
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 18,
                                          color: theme
                                              .colorScheme.onPrimaryContainer,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Reminder already scheduled',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            color: theme
                                                .colorScheme.onPrimaryContainer,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Scheduled for: ${_formatDateTime(reminder.sendDateTime)}',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color:
                                            theme.colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                    Text(
                                      'To: ${reminder.phone}',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color:
                                            theme.colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // No existing reminder - allow creating one
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Send reminder 1 day before appointment',
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                    Switch(
                                      value: sendReminder.value,
                                      onChanged: isSaving.value
                                          ? null
                                          : (value) =>
                                              sendReminder.value = value,
                                    ),
                                  ],
                                ),
                                if (sendReminder.value) ...[
                                  const SizedBox(height: 12),
                                  if (appointment.ownerContact == null ||
                                      appointment.ownerContact!.isEmpty) ...[
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
                                            color: theme
                                                .colorScheme.onErrorContainer,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'No contact number on file',
                                              style: TextStyle(
                                                color: theme.colorScheme
                                                    .onErrorContainer,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ] else ...[
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: theme
                                            .colorScheme.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 20,
                                            color: theme
                                                .colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'To: ${appointment.ownerContact}',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    FormBuilderTextField(
                                      name: 'reminderMessage',
                                      initialValue: _getDefaultReminderMessage(
                                          appointment.patientDisplayName),
                                      decoration: const InputDecoration(
                                        labelText: 'Message *',
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.sms),
                                      ),
                                      maxLines: 3,
                                      enabled: !isSaving.value,
                                      validator: sendReminder.value
                                          ? FormBuilderValidators.required(
                                              errorText:
                                                  'Message content is required',
                                            )
                                          : null,
                                    ),
                                  ],
                                ],
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

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
              // Bottom actions removed (moved to header)
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
    required ValueNotifier<List<PatientTreatmentRecord>>
        linkedTreatmentsExpanded,
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

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy - h:mm a').format(dateTime);
  }

  String _getDefaultReminderMessage(String patientName) {
    return 'Hello! This is a reminder about your appointment tomorrow for $patientName '
        'at San Jose Vet Clinic. Please contact us if you need to reschedule.';
  }
}
