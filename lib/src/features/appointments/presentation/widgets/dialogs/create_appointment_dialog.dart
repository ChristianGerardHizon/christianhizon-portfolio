import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../messages/domain/message.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
import '../../../../patients/domain/patient.dart';
import '../../../../patients/presentation/controllers/patient_treatments_controller.dart';
import '../../../../patients/presentation/controllers/patients_controller.dart';
import '../../../../settings/domain/message_template.dart';
import '../../../../settings/presentation/controllers/message_templates_controller.dart';
import '../../../domain/appointment_schedule.dart';

/// Dialog for creating a new appointment.
class CreateAppointmentDialog extends HookConsumerWidget {
  const CreateAppointmentDialog({
    super.key,
    this.initialPatient,
    required this.onSave,
  });

  /// Pre-selected patient (when creating from patient context).
  final Patient? initialPatient;

  /// Callback when appointment is saved.
  /// Returns the created appointment on success, or null on failure.
  final Future<AppointmentSchedule?> Function(AppointmentSchedule appointment)
      onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: formKey);
    final isSaving = useState(false);
    final hasTime = useState(false);
    final selectedPatient = useState<Patient?>(initialPatient);
    final sendReminder = useState(false);
    final selectedPatientTreatmentId = useState<String?>(null);
    final reminderDateTime = useState<DateTime?>(null);

    // Watch patients for dropdown
    final patientsAsync = ref.watch(patientsControllerProvider);

    // Watch treatment types for dropdown
    final treatmentTypesAsync = ref.watch(patientTreatmentsControllerProvider);

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
      if (selectedPatientTreatmentId.value != null) {
        final treatmentTypes = treatmentTypesAsync.value;
        if (treatmentTypes != null) {
          final treatment = treatmentTypes.firstWhereOrNull(
            (t) => t.id == selectedPatientTreatmentId.value,
          );
          if (treatment != null) {
            replaced = replaced.replaceAll('{treatmentName}', treatment.name);
          }
        }
      }

      return replaced;
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
        patientTreatment: selectedPatientTreatmentId.value,
        patientName: patient.name,
        ownerName: patient.owner,
        ownerContact: patient.contactNumber,
        isDeleted: false,
      );

      final created = await onSave(appointment);

      if (context.mounted) {
        if (created != null) {
          // Create reminder message if enabled
          if (sendReminder.value &&
              patient.contactNumber != null &&
              patient.contactNumber!.isNotEmpty) {
            final values = formKey.currentState!.value;
            final messageContent = values['reminderMessage'] as String?;

            if (messageContent != null && messageContent.isNotEmpty) {
              // Use custom reminder date/time or default to 1 day before at 9 AM
              final sendDateTime = reminderDateTime.value ??
                  DateTime(
                    finalDate.year,
                    finalDate.month,
                    finalDate.day - 1,
                    9,
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
          context.pop();
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
                        'New Appointment',
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

                        // Patient selector
                        if (initialPatient != null) ...[
                          // Show selected patient as read-only
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.pets,
                                  color: theme.colorScheme.primary),
                              title: Text(initialPatient!.name),
                              subtitle:
                                  Text(initialPatient!.owner ?? 'No owner'),
                            ),
                          ),
                        ] else ...[
                          // Searchable patient dropdown
                          patientsAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (_, __) =>
                                const Text('Error loading patients'),
                            data: (patients) => Autocomplete<Patient>(
                              displayStringForOption: (patient) =>
                                  '${patient.name} (${patient.owner ?? 'No owner'})',
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return patients.take(10);
                                }
                                final query =
                                    textEditingValue.text.toLowerCase();
                                return patients.where((patient) {
                                  return patient.name
                                          .toLowerCase()
                                          .contains(query) ||
                                      (patient.owner
                                              ?.toLowerCase()
                                              .contains(query) ??
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
                              optionsViewBuilder:
                                  (context, onSelected, options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(8),
                                    child: ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 200),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          final patient =
                                              options.elementAt(index);
                                          return ListTile(
                                            leading: const Icon(Icons.pets),
                                            title: Text(patient.name),
                                            subtitle: Text(
                                                patient.owner ?? 'No owner'),
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
                          onChanged: (value) {
                            // When appointment date changes and reminder is enabled, update SMS date
                            if (sendReminder.value && value != null) {
                              reminderDateTime.value = DateTime(
                                value.year,
                                value.month,
                                value.day - 1, // One day before
                                9, // 9 AM
                                0,
                              );
                            }
                          },
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
                            initialValue: DateTime.now(),
                            enabled: !isSaving.value,
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Treatment Type
                        treatmentTypesAsync.when(
                          loading: () => const LinearProgressIndicator(),
                          error: (_, __) =>
                              const Text('Error loading treatment types'),
                          data: (treatmentTypes) => FormBuilderDropdown<String>(
                            name: 'patientTreatment',
                            decoration: InputDecoration(
                              labelText: 'Treatment Type (Optional)',
                              border: const OutlineInputBorder(),
                              prefixIcon:
                                  const Icon(Icons.medical_services_outlined),
                              suffixIcon: selectedPatientTreatmentId.value !=
                                      null
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        formKey.currentState
                                            ?.fields['patientTreatment']
                                            ?.didChange(null);
                                        selectedPatientTreatmentId.value = null;
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              selectedPatientTreatmentId.value = value;
                            },
                            items: treatmentTypes
                                .map((t) => DropdownMenuItem(
                                      value: t.id,
                                      child: Text(t.name),
                                    ))
                                .toList(),
                            enabled: !isSaving.value,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Purpose (hidden when treatment type is selected)
                        if (selectedPatientTreatmentId.value == null) ...[
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
                        ],

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
                                          : (value) =>
                                              sendReminder.value = value,
                                    ),
                                  ],
                                ),
                                if (sendReminder.value) ...[
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
                                            color: theme
                                                .colorScheme.onErrorContainer,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Please select a patient first',
                                              style: TextStyle(
                                                color: theme.colorScheme
                                                    .onErrorContainer,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ] else if (selectedPatient
                                              .value!.contactNumber ==
                                          null ||
                                      selectedPatient
                                          .value!.contactNumber!.isEmpty) ...[
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
                                              'No contact number on file for this patient',
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
                                    // Phone number display
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme
                                            .surfaceContainerHighest,
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
                                            'To: ${selectedPatient.value!.contactNumber}',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (selectedPatient.value!.owner !=
                                                  null &&
                                              selectedPatient
                                                  .value!.owner!.isNotEmpty)
                                            Text(
                                              ' (${selectedPatient.value!.owner})',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Send date/time picker
                                    Builder(
                                      builder: (context) {
                                        // Calculate default reminder time (1 day before at 9 AM)
                                        final now = DateTime.now();
                                        final appointmentDate = formKey
                                                .currentState
                                                ?.fields['date']
                                                ?.value as DateTime? ??
                                            now;
                                        final defaultReminderDate = DateTime(
                                          appointmentDate.year,
                                          appointmentDate.month,
                                          appointmentDate.day - 1,
                                          9,
                                          0,
                                        );
                                        // Ensure display date is not before now
                                        final displayDateTime =
                                            reminderDateTime.value ??
                                                defaultReminderDate;

                                        // Calculate valid date range for picker
                                        final today = DateTime(
                                            now.year, now.month, now.day);
                                        final appointmentDay = DateTime(
                                          appointmentDate.year,
                                          appointmentDate.month,
                                          appointmentDate.day,
                                        );
                                        // Ensure initialDate is within valid range
                                        final validInitialDate =
                                            displayDateTime.isBefore(today)
                                                ? today
                                                : (displayDateTime
                                                        .isAfter(appointmentDay)
                                                    ? appointmentDay
                                                    : displayDateTime);

                                        return InkWell(
                                          onTap: isSaving.value
                                              ? null
                                              : () async {
                                                  // Show date picker
                                                  final pickedDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        validInitialDate,
                                                    firstDate: today,
                                                    lastDate: appointmentDay,
                                                  );
                                                  if (pickedDate != null &&
                                                      context.mounted) {
                                                    // Show time picker
                                                    final pickedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime: TimeOfDay
                                                          .fromDateTime(
                                                              displayDateTime),
                                                    );
                                                    if (pickedTime != null) {
                                                      reminderDateTime.value =
                                                          DateTime(
                                                        pickedDate.year,
                                                        pickedDate.month,
                                                        pickedDate.day,
                                                        pickedTime.hour,
                                                        pickedTime.minute,
                                                      );
                                                    }
                                                  }
                                                },
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    theme.colorScheme.outline,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.schedule_send,
                                                  size: 20,
                                                  color:
                                                      theme.colorScheme.primary,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Send Date & Time',
                                                        style: theme
                                                            .textTheme.bodySmall
                                                            ?.copyWith(
                                                          color: theme
                                                              .colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        DateFormat(
                                                                'MMM d, yyyy - h:mm a')
                                                            .format(
                                                                displayDateTime),
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                  color: theme.colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Template selector and message content
                                    templatesAsync.when(
                                      loading: () =>
                                          const LinearProgressIndicator(),
                                      error: (_, __) => const SizedBox.shrink(),
                                      data: (templates) {
                                        return _ReminderMessageSection(
                                          templates: templates,
                                          formKey: formKey,
                                          selectedPatient:
                                              selectedPatient.value,
                                          selectedPatientTreatmentId:
                                              selectedPatientTreatmentId,
                                          sendReminder: sendReminder.value,
                                          isSaving: isSaving.value,
                                          replacePlaceholders:
                                              replacePlaceholders,
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ],
                            ),
                          ),
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

/// Shows the create appointment dialog.
void showCreateAppointmentDialog(
  BuildContext context, {
  Patient? initialPatient,
  required Future<AppointmentSchedule?> Function(
          AppointmentSchedule appointment)
      onSave,
}) {
  showConstrainedDialog(
    context: context,
    builder: (context) => CreateAppointmentDialog(
      initialPatient: initialPatient,
      onSave: onSave,
    ),
  );
}

/// Widget for handling reminder message template selection and content.
///
/// Automatically applies the appropriate default template based on
/// whether a treatment is selected:
/// - Without treatment: Uses "Appointment" category default template
/// - With treatment: Uses "Appointment with Treatment" category default template
class _ReminderMessageSection extends HookWidget {
  const _ReminderMessageSection({
    required this.templates,
    required this.formKey,
    required this.selectedPatient,
    required this.selectedPatientTreatmentId,
    required this.sendReminder,
    required this.isSaving,
    required this.replacePlaceholders,
  });

  final List<MessageTemplate> templates;
  final GlobalKey<FormBuilderState> formKey;
  final Patient? selectedPatient;
  final ValueNotifier<String?> selectedPatientTreatmentId;
  final bool sendReminder;
  final bool isSaving;
  final String Function(String, Patient?) replacePlaceholders;

  /// Fallback message when no default template is found.
  static String _getFallbackMessage(String patientName) {
    return 'Hello! This is a reminder about your appointment tomorrow for $patientName '
        'at San Jose Vet Clinic. Please contact us if you need to reschedule.';
  }

  @override
  Widget build(BuildContext context) {
    // Track if we've already applied the default template
    final hasAppliedDefault = useState(false);

    // Track the previous treatment ID to detect changes
    final previousTreatmentId = useState<String?>(null);

    // Determine which category to use based on treatment selection
    final category = selectedPatientTreatmentId.value != null
        ? MessageTemplateCategories.appointmentWithTreatment
        : MessageTemplateCategories.appointment;

    // Find default template for current category
    final defaultTemplate = templates.firstWhereOrNull(
      (t) => t.category == category && t.isDefault,
    );

    // Filter templates to show only appointment-related categories
    final filteredTemplates = templates
        .where((t) =>
                t.category == MessageTemplateCategories.appointment ||
                t.category ==
                    MessageTemplateCategories.appointmentWithTreatment ||
                t.category ==
                    'Appointment Reminders' // Legacy backward compatibility
            )
        .toList();

    // Helper function to apply a template to the message field
    void applyTemplate(MessageTemplate? template, Patient patient) {
      String message;
      if (template != null) {
        message = replacePlaceholders(template.content, patient);
      } else {
        message = _getFallbackMessage(patient.name);
      }
      formKey.currentState?.fields['reminderMessage']?.didChange(message);
    }

    // Apply default template on first build
    useEffect(() {
      if (!hasAppliedDefault.value && selectedPatient != null) {
        hasAppliedDefault.value = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          applyTemplate(defaultTemplate, selectedPatient!);
        });
      }
      return null;
    }, [selectedPatient]);

    // React to treatment selection changes
    useEffect(() {
      // Only react if the treatment ID has actually changed and we've already applied a default
      if (hasAppliedDefault.value &&
          previousTreatmentId.value != selectedPatientTreatmentId.value &&
          selectedPatient != null) {
        previousTreatmentId.value = selectedPatientTreatmentId.value;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          applyTemplate(defaultTemplate, selectedPatient!);
        });
      } else if (!hasAppliedDefault.value) {
        // Track the initial value without triggering an update
        previousTreatmentId.value = selectedPatientTreatmentId.value;
      }
      return null;
    }, [selectedPatientTreatmentId.value, defaultTemplate]);

    return Column(
      children: [
        // Template selector
        if (filteredTemplates.isNotEmpty) ...[
          FormBuilderDropdown<String>(
            name: 'template',
            initialValue: defaultTemplate?.id,
            decoration: const InputDecoration(
              labelText: 'Use Template',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description_outlined),
              helperText: 'Select a template to auto-fill reminder',
            ),
            onChanged: (value) {
              if (value != null && selectedPatient != null) {
                final template = templates.firstWhere((t) => t.id == value);
                final finalContent = replacePlaceholders(
                  template.content,
                  selectedPatient,
                );
                formKey.currentState?.fields['reminderMessage']
                    ?.didChange(finalContent);
              }
            },
            items: filteredTemplates
                .map((t) => DropdownMenuItem(
                      value: t.id,
                      child: Text(t.name),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],

        // Message content field
        FormBuilderTextField(
          name: 'reminderMessage',
          decoration: const InputDecoration(
            labelText: 'Message *',
            hintText: 'Enter reminder message',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.sms),
          ),
          maxLines: 3,
          enabled: !isSaving,
          validator: sendReminder
              ? FormBuilderValidators.required(
                  errorText: 'Message content is required',
                )
              : null,
        ),
      ],
    );
  }
}
