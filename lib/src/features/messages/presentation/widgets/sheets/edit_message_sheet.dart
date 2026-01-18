import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/message.dart';

/// Bottom sheet for editing a pending message.
///
/// Only allows editing of content, send date/time, and notes.
/// Phone and patient associations cannot be changed.
class EditMessageSheet extends HookConsumerWidget {
  const EditMessageSheet({
    super.key,
    required this.message,
    required this.onSave,
  });

  /// The message to edit.
  final Message message;

  /// Callback when message is saved.
  /// Returns the updated message on success, or null on failure.
  final Future<Message?> Function(Message message) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

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
        // Default to 9:00 AM if no time provided
        sendDateTime = DateTime(date.year, date.month, date.day, 9, 0);
      }

      final updatedMessage = message.copyWith(
        content: values['content'] as String,
        sendDateTime: sendDateTime,
        notes: values['notes'] as String?,
      );

      final updated = await onSave(updatedMessage);

      if (context.mounted) {
        if (updated != null) {
          isSaving.value = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message updated successfully')),
          );
        } else {
          isSaving.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update message')),
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
                      'Edit Message',
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
                        : const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Phone number (read-only)
              TextFormField(
                initialValue: message.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  helperText: 'Phone number cannot be changed',
                ),
                enabled: false,
              ),
              const SizedBox(height: 16),

              // Patient (read-only, if linked)
              if (message.patientDisplayName != null) ...[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.pets, color: theme.colorScheme.primary),
                    title: Text(message.patientDisplayName!),
                    subtitle: const Text('Linked patient'),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Message content (editable)
              FormBuilderTextField(
                name: 'content',
                initialValue: message.content,
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

              // Date picker (editable)
              FormBuilderDateTimePicker(
                name: 'date',
                decoration: const InputDecoration(
                  labelText: 'Send Date *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                inputType: InputType.date,
                initialValue: message.sendDateTime,
                firstDate: DateTime.now(),
                validator: FormBuilderValidators.required(),
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Time picker (editable)
              FormBuilderDateTimePicker(
                name: 'time',
                decoration: const InputDecoration(
                  labelText: 'Send Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                  helperText: 'Defaults to 9:00 AM if not specified',
                ),
                inputType: InputType.time,
                initialValue: message.sendDateTime,
                enabled: !isSaving.value,
              ),
              const SizedBox(height: 16),

              // Notes (editable)
              FormBuilderTextField(
                name: 'notes',
                initialValue: message.notes,
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
