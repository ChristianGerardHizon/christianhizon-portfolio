import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../patients/domain/patient.dart';
import '../../../../settings/domain/message_template.dart';
import '../../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../../../settings/presentation/controllers/message_templates_controller.dart';
import '../../../domain/appointment_schedule.dart';

/// Result returned from the reschedule dialog.
class RescheduleResult {
  const RescheduleResult({
    required this.newDate,
    required this.hasTime,
    this.sendReminder = false,
    this.reminderMessage,
    this.reminderDateTime,
  });

  final DateTime newDate;
  final bool hasTime;
  final bool sendReminder;
  final String? reminderMessage;
  final DateTime? reminderDateTime;
}

/// A focused dialog for rescheduling an existing appointment.
///
/// Shows current appointment info (read-only), a date/time picker for the
/// new date, and an optional SMS reminder section.
class RescheduleAppointmentDialog extends HookConsumerWidget {
  const RescheduleAppointmentDialog({
    super.key,
    required this.appointment,
    this.patient,
  });

  final AppointmentSchedule appointment;
  final Patient? patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final hasTime = useState(appointment.hasTime);
    final sendReminder = useState(false);
    final reminderDateTime = useState<DateTime?>(null);

    // Watch templates for SMS section
    final templatesAsync = ref.watch(messageTemplatesControllerProvider);
    final currentBranch = ref.watch(currentBranchControllerProvider).value;

    String replacePlaceholders(String content) {
      if (content.isEmpty) return content;

      var replaced = content;

      // Replace patient data
      if (patient != null) {
        replaced = replaced.replaceAll('{patientName}', patient!.name);
        replaced = replaced.replaceAll(
            '{patientPhone}', patient!.contactNumber ?? '');
        replaced = replaced.replaceAll('{ownerName}', patient!.owner ?? '');
        replaced = replaced.replaceAll('{species}', patient!.species ?? '');
        replaced = replaced.replaceAll('{breed}', patient!.breed ?? '');
        replaced = replaced.replaceAll('{email}', patient!.email ?? '');
        replaced = replaced.replaceAll('{address}', patient!.address ?? '');
      }

      // Replace appointment info
      final date = formKey.currentState?.fields['date']?.value as DateTime?;
      if (date != null) {
        replaced = replaced.replaceAll(
            '{appointmentDate}', DateFormat('MMM d, yyyy').format(date));
      }

      if (appointment.purpose != null && appointment.purpose!.isNotEmpty) {
        replaced = replaced.replaceAll('{purpose}', appointment.purpose!);
      }

      if (appointment.notes != null && appointment.notes!.isNotEmpty) {
        replaced = replaced.replaceAll('{notes}', appointment.notes!);
      }

      // Replace treatment data
      if (appointment.patientTreatmentName.isNotEmpty) {
        final names = appointment.patientTreatmentName;
        final formatted = switch (names.length) {
          1 => names.first,
          2 => '${names[0]} and ${names[1]}',
          _ =>
            '${names.sublist(0, names.length - 1).join(', ')} and ${names.last}',
        };
        replaced = replaced.replaceAll('{treatmentNames}', formatted);
        replaced = replaced.replaceAll('{treatmentName}', formatted);
      }

      // Replace branch data
      if (currentBranch != null) {
        replaced = replaced.replaceAll(
            '{branchName}', currentBranch.displayName ?? currentBranch.name);
        replaced =
            replaced.replaceAll('{branchAddress}', currentBranch.address);
        replaced = replaced.replaceAll(
            '{branchPhone}', currentBranch.contactNumber);
        replaced = replaced.replaceAll(
            '{branchOperatingHours}', currentBranch.operatingHours ?? '');
        replaced = replaced.replaceAll(
            '{branchCutOffTime}', currentBranch.cutOffTime ?? '');
      }

      return replaced;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.icon(
              onPressed: () {
                if (!formKey.currentState!.saveAndValidate()) return;

                final values = formKey.currentState!.value;
                final date = values['date'] as DateTime;
                final time = values['time'] as DateTime?;

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

                final result = RescheduleResult(
                  newDate: finalDate,
                  hasTime: hasTime.value,
                  sendReminder: sendReminder.value,
                  reminderMessage:
                      values['reminderMessage'] as String?,
                  reminderDateTime: reminderDateTime.value ??
                      DateTime(
                        finalDate.year,
                        finalDate.month,
                        finalDate.day - 1,
                        9,
                        0,
                      ),
                );

                context.pop(result);
              },
              icon: const Icon(Icons.event_repeat),
              label: const Text('Reschedule'),
            ),
          ),
        ],
      ),
      body: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current appointment info (read-only)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Appointment',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.pets,
                              size: 20,
                              color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              appointment.patientDisplayName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 20,
                              color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              appointment.displayDate,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      if (appointment.hasTreatments) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.medical_services_outlined,
                                size: 20,
                                color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                appointment.treatmentNamesDisplay,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // New date section
              Text(
                'New Date & Time',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // Date picker
              FormBuilderDateTimePicker(
                name: 'date',
                initialValue: DateTime.now().add(const Duration(days: 1)),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'New Date *',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                firstDate: DateTime.now(),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 12),

              // Has time toggle
              SwitchListTile(
                title: const Text('Include specific time'),
                value: hasTime.value,
                onChanged: (value) => hasTime.value = value,
                contentPadding: EdgeInsets.zero,
              ),

              // Time picker (conditional)
              if (hasTime.value) ...[
                FormBuilderDateTimePicker(
                  name: 'time',
                  initialValue: appointment.hasTime ? appointment.date : null,
                  inputType: InputType.time,
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              const SizedBox(height: 24),

              // SMS Reminder section
              if (patient?.contactNumber != null &&
                  patient!.contactNumber!.isNotEmpty) ...[
                const Divider(),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Send SMS Reminder'),
                  subtitle: Text(
                    'Send a reminder to ${patient!.contactNumber}',
                    style: theme.textTheme.bodySmall,
                  ),
                  value: sendReminder.value,
                  onChanged: (value) {
                    sendReminder.value = value;

                    if (value) {
                      // Apply default template
                      templatesAsync.whenData((templates) {
                        _applyDefaultTemplate(
                          formKey: formKey,
                          templates: templates,
                          hasTreatments: appointment.hasTreatments,
                          replacePlaceholders: replacePlaceholders,
                        );
                      });
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 12),

                if (sendReminder.value) ...[
                  // Reminder send date/time
                  Builder(
                    builder: (context) {
                      final now = DateTime.now();
                      final appointmentDate = formKey.currentState
                              ?.fields['date']?.value as DateTime? ??
                          now.add(const Duration(days: 1));
                      final defaultReminderDate = DateTime(
                        appointmentDate.year,
                        appointmentDate.month,
                        appointmentDate.day - 1,
                        9,
                        0,
                      );
                      final displayDateTime =
                          reminderDateTime.value ?? defaultReminderDate;
                      final today =
                          DateTime(now.year, now.month, now.day);
                      final appointmentDay = DateTime(
                        appointmentDate.year,
                        appointmentDate.month,
                        appointmentDate.day,
                      );
                      final validInitialDate =
                          displayDateTime.isBefore(today)
                              ? today
                              : (displayDateTime.isAfter(appointmentDay)
                                  ? appointmentDay
                                  : displayDateTime);

                      return InkWell(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: validInitialDate,
                            firstDate: today,
                            lastDate: appointmentDay,
                          );
                          if (pickedDate != null && context.mounted) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(displayDateTime),
                            );
                            if (pickedTime != null) {
                              reminderDateTime.value = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule_send,
                                size: 20,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Send Date & Time',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: theme
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      DateFormat('MMM d, yyyy - h:mm a')
                                          .format(displayDateTime),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.edit,
                                size: 18,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Template selector
                  templatesAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (templates) {
                      final category = appointment.hasTreatments
                          ? MessageTemplateCategories.appointmentWithTreatment
                          : MessageTemplateCategories.appointment;
                      final filteredTemplates = templates
                          .where((t) => t.category == category)
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (filteredTemplates.isNotEmpty)
                            FormBuilderDropdown<String>(
                              name: 'template',
                              decoration: const InputDecoration(
                                labelText: 'Message Template',
                                prefixIcon: Icon(Icons.description),
                              ),
                              items: filteredTemplates
                                  .map((t) => DropdownMenuItem(
                                        value: t.id,
                                        child: Text(t.name),
                                      ))
                                  .toList(),
                              onChanged: (templateId) {
                                if (templateId == null) return;
                                final template = filteredTemplates
                                    .firstWhereOrNull(
                                        (t) => t.id == templateId);
                                if (template != null) {
                                  final message = replacePlaceholders(
                                      template.content);
                                  formKey.currentState
                                      ?.fields['reminderMessage']
                                      ?.didChange(message);
                                }
                              },
                            ),
                          const SizedBox(height: 12),
                          FormBuilderTextField(
                            name: 'reminderMessage',
                            decoration: const InputDecoration(
                              labelText: 'Message Content',
                              prefixIcon: Icon(Icons.sms),
                              alignLabelWithHint: true,
                            ),
                            maxLines: 4,
                            validator: FormBuilderValidators.required(),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _applyDefaultTemplate({
    required GlobalKey<FormBuilderState> formKey,
    required List<MessageTemplate> templates,
    required bool hasTreatments,
    required String Function(String) replacePlaceholders,
  }) {
    final category = hasTreatments
        ? MessageTemplateCategories.appointmentWithTreatment
        : MessageTemplateCategories.appointment;

    final firstTemplate = templates.firstWhereOrNull(
      (t) => t.category == category,
    );

    if (firstTemplate == null) return;

    final message = replacePlaceholders(firstTemplate.content);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formKey.currentState?.fields['template']?.didChange(firstTemplate.id);
      formKey.currentState?.fields['reminderMessage']?.didChange(message);
    });
  }
}

/// Shows the reschedule appointment dialog and returns a [RescheduleResult]
/// or null if cancelled.
Future<RescheduleResult?> showRescheduleAppointmentDialog(
  BuildContext context, {
  required AppointmentSchedule appointment,
  Patient? patient,
}) {
  return showConstrainedDialog<RescheduleResult>(
    context: context,
    builder: (context) => RescheduleAppointmentDialog(
      appointment: appointment,
      patient: patient,
    ),
  );
}
