import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/domain/patient.dart';
import '../../../../patients/presentation/controllers/patient_treatments_controller.dart';
import '../../../../settings/presentation/controllers/message_templates_controller.dart';
import '../../../../messages/domain/message.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
import '../../../domain/appointment_schedule.dart';

/// Dialog for editing an existing appointment.
class EditAppointmentDialog extends HookConsumerWidget {
  const EditAppointmentDialog({
    super.key,
    required this.appointment,
    required this.onSave,
  });

  final AppointmentSchedule appointment;
  final Future<bool> Function(AppointmentSchedule appointment) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: {
        'date': appointment.date,
        'time': appointment.hasTime ? appointment.date : null,
        'purpose': appointment.purpose,
        'notes': appointment.notes,
      },
    );
    final isSaving = useState(false);
    final hasTime = useState(appointment.hasTime);
    final isTreatment = useState(appointment.patientTreatment.isNotEmpty);
    final selectedPatientTreatmentIds =
        useState<List<String>>(appointment.patientTreatment);
    final sendReminder = useState(false);

    // Watch treatment types for dropdown
    final treatmentTypesAsync = ref.watch(patientTreatmentsControllerProvider);

    // Check if appointment is in the future
    final isFutureAppointment = appointment.date.isAfter(DateTime.now());

    // Watch existing reminder messages for this appointment
    final existingMessagesAsync =
        ref.watch(messagesByAppointmentProvider(appointment.id));

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
            '{appointmentDate}', DateFormat('MMM d, yyyy').format(date));
      }

      final purpose = formKey.currentState?.fields['purpose']?.value as String?;
      if (purpose != null && purpose.isNotEmpty) {
        replaced = replaced.replaceAll('{purpose}', purpose);
      }

      final notes = formKey.currentState?.fields['notes']?.value as String?;
      if (notes != null && notes.isNotEmpty) {
        replaced = replaced.replaceAll('{notes}', notes);
      }

      // Replace treatment data
      if (appointment.patientTreatmentName.isNotEmpty) {
        replaced = replaced.replaceAll(
            '{treatmentName}', appointment.treatmentNamesDisplay);
      }

      return replaced;
    }

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

      // Resolve treatment names from the list if treatments are selected
      var patientTreatmentNames = <String>[];
      if (isTreatment.value && selectedPatientTreatmentIds.value.isNotEmpty) {
        final treatmentTypes = treatmentTypesAsync.value;
        if (treatmentTypes != null) {
          patientTreatmentNames = selectedPatientTreatmentIds.value
              .map((id) => treatmentTypes.firstWhereOrNull((t) => t.id == id))
              .where((t) => t != null)
              .map((t) => t!.name)
              .toList();
        }
      }

      // Determine autoCreateRecord:
      // - If type changed from the original, set based on new type
      // - Otherwise preserve the existing value
      final originalWasTreatment = appointment.patientTreatment.isNotEmpty;
      final bool autoCreateRecord;
      if (isTreatment.value != originalWasTreatment) {
        autoCreateRecord = isTreatment.value;
      } else {
        autoCreateRecord = appointment.autoCreateRecord;
      }

      final updated = AppointmentSchedule(
        id: appointment.id,
        date: finalDate,
        hasTime: hasTime.value,
        purpose: isTreatment.value ? null : values['purpose'] as String?,
        notes: values['notes'] as String?,
        status: appointment.status,
        patient: appointment.patient,
        patientTreatment:
            isTreatment.value ? selectedPatientTreatmentIds.value : const [],
        patientTreatmentName:
            isTreatment.value ? patientTreatmentNames : const [],
        patientRecords: appointment.patientRecords,
        branch: appointment.branch,
        patientName: appointment.patientName,
        ownerName: appointment.ownerName,
        ownerContact: appointment.ownerContact,
        isDeleted: appointment.isDeleted,
        patientExpanded: appointment.patientExpanded,
        patientRecordsExpanded: appointment.patientRecordsExpanded,
        created: appointment.created,
        updated: appointment.updated,
        autoCreateRecord: autoCreateRecord,
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
          context.pop();
          showSuccessSnackBar(
            context,
            message: sendReminder.value
                ? 'Appointment updated with reminder'
                : 'Appointment updated successfully',
          );
        } else {
          isSaving.value = false;
          showErrorSnackBar(context, message: 'Failed to update appointment');
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
                      'Edit Appointment',
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
                      child: const Text('Cancel'),
                    ),
                  ),
                  FilledButton(
                    onPressed: isSaving.value ? null : handleSave,
                    child: isSaving.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Content
            Expanded(
              child: FormBuilder(
                key: formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),

                      // Patient info (read-only)
                      Card(
                        child: ListTile(
                          leading:
                              Icon(Icons.pets, color: theme.colorScheme.primary),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SwitchListTile(
                          title: const Text('Include specific time'),
                          value: hasTime.value,
                          onChanged: isSaving.value
                              ? null
                              : (value) => hasTime.value = value,
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
                          initialValue:
                              appointment.hasTime ? appointment.date : DateTime.now(),
                          enabled: !isSaving.value,
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Appointment Type Toggle
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment<bool>(
                            value: false,
                            label: Text('General'),
                            icon: Icon(Icons.description_outlined),
                          ),
                          ButtonSegment<bool>(
                            value: true,
                            label: Text('Treatment'),
                            icon: Icon(Icons.medical_services_outlined),
                          ),
                        ],
                        selected: {isTreatment.value},
                        onSelectionChanged: isSaving.value
                            ? null
                            : (value) {
                                isTreatment.value = value.first;
                                if (value.first) {
                                  // Switching to treatment: clear purpose
                                  formKey.currentState?.fields['purpose']
                                      ?.didChange(null);
                                } else {
                                  // Switching to checkup: clear treatments
                                  selectedPatientTreatmentIds.value = [];
                                }
                              },
                      ),
                      const SizedBox(height: 16),

                      // Treatment Types (shown when Treatment is selected)
                      if (isTreatment.value) ...[
                        treatmentTypesAsync.when(
                          loading: () => const LinearProgressIndicator(),
                          error: (_, __) =>
                              const Text('Error loading treatment types'),
                          data: (treatmentTypes) => InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Treatment Types *',
                              border: OutlineInputBorder(),
                              prefixIcon:
                                  Icon(Icons.medical_services_outlined),
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: treatmentTypes.map((t) {
                                final isSelected =
                                    selectedPatientTreatmentIds.value
                                        .contains(t.id);
                                return FilterChip(
                                  label: Text(t.name),
                                  selected: isSelected,
                                  onSelected: isSaving.value
                                      ? null
                                      : (selected) {
                                          final current = [
                                            ...selectedPatientTreatmentIds.value
                                          ];
                                          if (selected) {
                                            current.add(t.id);
                                          } else {
                                            current.remove(t.id);
                                          }
                                          selectedPatientTreatmentIds.value =
                                              current;
                                        },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Purpose (shown when General is selected)
                      if (!isTreatment.value) ...[
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
                      ],

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
                                      child:
                                          CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                  error: (_, __) => Text(
                                    'Could not load reminder info',
                                    style:
                                        TextStyle(color: theme.colorScheme.error),
                                  ),
                                  data: (messages) {
                                    // Check for pending reminder messages
                                    final pendingReminders = messages
                                        .where(
                                            (m) => m.status == MessageStatus.pending)
                                        .toList();

                                    if (pendingReminders.isNotEmpty) {
                                      // Show existing reminder info
                                      final reminder = pendingReminders.first;
                                      return Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color:
                                              theme.colorScheme.primaryContainer,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  size: 18,
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Reminder already scheduled',
                                                  style: theme.textTheme.labelLarge
                                                      ?.copyWith(
                                                    color: theme.colorScheme
                                                        .onPrimaryContainer,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Scheduled for: ${_formatDateTime(reminder.sendDateTime)}',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: theme.colorScheme
                                                    .onPrimaryContainer,
                                              ),
                                            ),
                                            Text(
                                              'To: ${reminder.phone}',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: theme.colorScheme
                                                    .onPrimaryContainer,
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
                                              appointment
                                                  .ownerContact!.isEmpty) ...[
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: theme
                                                    .colorScheme.errorContainer,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.warning,
                                                    color: theme.colorScheme
                                                        .onErrorContainer,
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
                                                color: theme.colorScheme
                                                    .surfaceContainerHighest,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    size: 20,
                                                    color: theme.colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'To: ${appointment.ownerContact}',
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),

                                            // Template selector
                                            templatesAsync.when(
                                              loading: () =>
                                                  const LinearProgressIndicator(),
                                              error: (_, __) =>
                                                  const SizedBox.shrink(),
                                              data: (templates) {
                                                if (templates.isEmpty) {
                                                  return const SizedBox.shrink();
                                                }
                                                return Column(
                                                  children: [
                                                    FormBuilderDropdown<String>(
                                                      name: 'template',
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Use Template',
                                                        border:
                                                            OutlineInputBorder(),
                                                        prefixIcon: Icon(Icons
                                                            .description_outlined),
                                                        helperText:
                                                            'Select a template to auto-fill reminder',
                                                      ),
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          final template =
                                                              templates.firstWhere(
                                                                  (t) =>
                                                                      t.id ==
                                                                      value);
                                                          final finalContent =
                                                              replacePlaceholders(
                                                            template.content,
                                                            appointment
                                                                .patientExpanded,
                                                          );
                                                          formKey
                                                              .currentState
                                                              ?.fields[
                                                                  'reminderMessage']
                                                              ?.didChange(
                                                                  finalContent);
                                                        }
                                                      },
                                                      items: templates
                                                          .map((t) =>
                                                              DropdownMenuItem(
                                                                value: t.id,
                                                                child:
                                                                    Text(t.name),
                                                              ))
                                                          .toList(),
                                                    ),
                                                    const SizedBox(height: 16),
                                                  ],
                                                );
                                              },
                                            ),

                                            FormBuilderTextField(
                                              name: 'reminderMessage',
                                              initialValue:
                                                  _getDefaultReminderMessage(
                                                      appointment
                                                          .patientDisplayName),
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

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy - h:mm a').format(dateTime);
  }

  String _getDefaultReminderMessage(String patientName) {
    return 'Hello! This is a reminder about your appointment tomorrow for $patientName '
        'at San Jose Vet Clinic. Please contact us if you need to reschedule.';
  }
}

/// Shows the edit appointment dialog.
void showEditAppointmentDialog(
  BuildContext context, {
  required AppointmentSchedule appointment,
  required Future<bool> Function(AppointmentSchedule appointment) onSave,
}) {
  showConstrainedDialog(
    context: context,
    builder: (context) => EditAppointmentDialog(
      appointment: appointment,
      onSave: onSave,
    ),
  );
}
