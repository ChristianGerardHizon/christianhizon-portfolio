import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../patients/domain/patient.dart';
import '../../../../patients/presentation/controllers/patients_controller.dart';
import '../../../domain/message.dart';

/// Bottom sheet for creating a new message.
class CreateMessageSheet extends HookConsumerWidget {
  const CreateMessageSheet({
    super.key,
    this.initialPatient,
    this.initialAppointmentId,
    required this.onSave,
  });

  /// Pre-selected patient (when creating from patient context).
  final Patient? initialPatient;

  /// Pre-selected appointment ID (when creating from appointment context).
  final String? initialAppointmentId;

  /// Callback when message is saved.
  /// Returns the created message on success, or null on failure.
  final Future<Message?> Function(Message message) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final selectedPatient = useState<Patient?>(initialPatient);

    // Watch patients for dropdown
    final patientsAsync = ref.watch(patientsControllerProvider);

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final date = values['date'] as DateTime;
      final time = values['time'] as DateTime?;

      // Combine date and time
      DateTime sendDateTime;
      if (time != null) {
        sendDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      } else {
        // Default to start of day if no time provided
        sendDateTime = DateTime(date.year, date.month, date.day, 9, 0);
      }

      final message = Message(
        id: '', // Will be assigned by PocketBase
        phone: values['phone'] as String,
        content: values['content'] as String,
        sendDateTime: sendDateTime,
        status: MessageStatus.pending,
        patient: selectedPatient.value?.id,
        appointment: initialAppointmentId,
        notes: values['notes'] as String?,
      );

      final created = await onSave(message);

      if (context.mounted) {
        if (created != null) {
          isSaving.value = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message scheduled successfully')),
          );
        } else {
          isSaving.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to schedule message')),
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
                      'New Message',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed:
                        isSaving.value ? null : () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
                        : const Text('Schedule'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Phone number
              FormBuilderTextField(
                name: 'phone',
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: '+63 9XX XXX XXXX',
                ),
                keyboardType: TextInputType.phone,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(10),
                ]),
                initialValue: selectedPatient.value?.contactNumber,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Patient selector (optional)
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
                // Searchable patient dropdown (optional)
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
                      // Auto-fill phone number if available
                      if (patient.contactNumber != null) {
                        formKey.currentState?.fields['phone']
                            ?.didChange(patient.contactNumber);
                      }
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
                          labelText: 'Patient (optional)',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.pets),
                          helperText: 'Link to a patient for context',
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

              // Message content
              FormBuilderTextField(
                name: 'content',
                decoration: const InputDecoration(
                  labelText: 'Message *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Enter your message here...',
                ),
                maxLines: 4,
                maxLength: 160,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(160),
                ]),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Date picker
              FormBuilderDateTimePicker(
                name: 'date',
                decoration: const InputDecoration(
                  labelText: 'Send Date *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                inputType: InputType.date,
                initialValue: DateTime.now(),
                firstDate: DateTime.now(),
                validator: FormBuilderValidators.required(),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Time picker
              FormBuilderDateTimePicker(
                name: 'time',
                decoration: const InputDecoration(
                  labelText: 'Send Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                  helperText: 'Defaults to 9:00 AM if not specified',
                ),
                inputType: InputType.time,
                initialValue: DateTime.now().copyWith(hour: 9, minute: 0),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Notes (internal)
              FormBuilderTextField(
                name: 'notes',
                decoration: const InputDecoration(
                  labelText: 'Internal Notes',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                  helperText: 'For internal reference only (not sent)',
                ),
                maxLines: 2,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
