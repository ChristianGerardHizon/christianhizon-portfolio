import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../messages/domain/message.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
import '../../../domain/patient_treatment_record.dart';
import '../../controllers/patient_provider.dart';
import '../../controllers/patient_treatments_controller.dart';

/// Bottom sheet for adding or editing a treatment record.
///
/// If [appointmentId] is provided, the record will be linked to that appointment.
class AddTreatmentRecordSheet extends HookConsumerWidget {
  const AddTreatmentRecordSheet({
    super.key,
    required this.patientId,
    required this.scrollController,
    this.existingRecord,
    required this.onSave,
    this.appointmentId,
  });

  final String patientId;
  final ScrollController scrollController;
  final PatientTreatmentRecord? existingRecord;

  /// Optional appointment ID to link the treatment record to.
  final String? appointmentId;

  /// Callback when saving. Returns the created/updated record on success, null on failure.
  final Future<PatientTreatmentRecord?> Function(PatientTreatmentRecord record)
      onSave;

  static const _fieldLabels = {
    'treatment': 'Treatment Type',
    'date': 'Date',
    'notes': 'Notes',
    'reminderMessage': 'Reminder Message',
    'reminderDateTime': 'Send Date/Time',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isEditing = existingRecord != null;

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final sendReminder = useState(false);

    // Watch treatment catalog
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);

    // Watch patient data for phone number
    final patientAsync = ref.watch(patientProvider(patientId));

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
        appointment: appointmentId ?? existingRecord?.appointment,
      );

      final created = await onSave(record);

      // Create reminder message if enabled
      if (created != null && sendReminder.value) {
        final patient = patientAsync.value;
        final messageContent = values['reminderMessage'] as String?;
        final reminderDateTime = values['reminderDateTime'] as DateTime?;

        if (patient != null &&
            patient.contactNumber != null &&
            patient.contactNumber!.isNotEmpty &&
            messageContent != null &&
            messageContent.isNotEmpty &&
            reminderDateTime != null) {
          final message = Message(
            id: '',
            phone: patient.contactNumber!,
            content: messageContent,
            sendDateTime: reminderDateTime,
            patient: patientId,
            appointment: appointmentId ?? existingRecord?.appointment,
            notes: 'Treatment reminder for ${created.treatmentName}',
          );

          await ref
              .read(messagesControllerProvider.notifier)
              .createMessage(message);
        }
      }

      if (context.mounted) {
        isSaving.value = false;
        if (created != null) {
          context.pop();
          showSuccessSnackBar(
            context,
            message: isEditing
                ? 'Treatment record updated'
                : sendReminder.value
                    ? 'Treatment record added with reminder'
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

                // === HEADER WITH ACTIONS ===
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isEditing
                            ? 'Edit Treatment Record'
                            : 'Add Treatment Record',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: isSaving.value ? null : () => context.pop(),
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

                // === REMINDER MESSAGE SECTION ===
                if (!isEditing) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.message,
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
                            const SizedBox(height: 16),
                            // Show patient phone info
                            patientAsync.when(
                              loading: () =>
                                  const LinearProgressIndicator(),
                              error: (_, __) => Text(
                                'Could not load patient info',
                                style: TextStyle(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                              data: (patient) {
                                if (patient == null) {
                                  return Text(
                                    'Patient not found',
                                    style: TextStyle(
                                      color: theme.colorScheme.error,
                                    ),
                                  );
                                }
                                if (patient.contactNumber == null ||
                                    patient.contactNumber!.isEmpty) {
                                  return Container(
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
                                  );
                                }
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // Phone number display
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
                                            'To: ${patient.contactNumber}',
                                            style: theme
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (patient.owner != null &&
                                              patient.owner!.isNotEmpty)
                                            Text(
                                              ' (${patient.owner})',
                                              style: theme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Reminder date/time
                                    FormBuilderDateTimePicker(
                                      name: 'reminderDateTime',
                                      initialValue: DateTime.now()
                                          .add(const Duration(days: 1)),
                                      decoration: const InputDecoration(
                                        labelText: 'Send Date & Time *',
                                        border: OutlineInputBorder(),
                                        prefixIcon:
                                            Icon(Icons.schedule),
                                      ),
                                      enabled: !isSaving.value,
                                      inputType: InputType.both,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)),
                                      validator:
                                          FormBuilderValidators.required(
                                        errorText:
                                            'Send date/time is required',
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Message content
                                    FormBuilderTextField(
                                      name: 'reminderMessage',
                                      initialValue: _getDefaultReminderMessage(
                                          patient.name),
                                      decoration: const InputDecoration(
                                        labelText: 'Message *',
                                        hintText:
                                            'Enter reminder message',
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.sms),
                                      ),
                                      maxLines: 3,
                                      enabled: !isSaving.value,
                                      validator:
                                          FormBuilderValidators.required(
                                        errorText:
                                            'Message content is required',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Buttons
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

  String _getDefaultReminderMessage(String patientName) {
    return 'Hello! This is a reminder about the treatment for $patientName. '
        'Please contact us if you have any questions.';
  }
}

/// Shows the add/edit treatment record sheet with fullscreen draggable functionality.
///
/// If [appointmentId] is provided, the record will be linked to that appointment.
void showTreatmentRecordSheet(
  BuildContext context, {
  required String patientId,
  PatientTreatmentRecord? existingRecord,
  required Future<PatientTreatmentRecord?> Function(
          PatientTreatmentRecord record)
      onSave,
  String? appointmentId,
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
        appointmentId: appointmentId,
      ),
    ),
  );
}
