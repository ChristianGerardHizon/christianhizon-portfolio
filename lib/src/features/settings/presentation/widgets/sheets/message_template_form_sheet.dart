import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/message_template.dart';
import '../../controllers/message_templates_controller.dart';

/// Bottom sheet for creating or editing a message template.
class MessageTemplateFormSheet extends HookConsumerWidget {
  const MessageTemplateFormSheet({
    super.key,
    this.template,
    this.scrollController,
  });

  final MessageTemplate? template;
  final ScrollController? scrollController;

  bool get isEditing => template != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);

    // Categories from existing templates
    final categories = ref.watch(messageTemplatesControllerProvider).maybeWhen(
          data: (templates) {
            final cats = templates
                .map((t) => t.category)
                .whereType<String>()
                .toSet()
                .toList()
              ..sort();
            return cats;
          },
          orElse: () => <String>[],
        );

    // Common category suggestions
    final defaultCategories = [
      'Appointment Reminders',
      'Follow-up',
      'Billing',
      'Promotions',
      'General',
    ];

    final allCategories = {...defaultCategories, ...categories}.toList()
      ..sort();

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      if (!isValid) {
        return;
      }

      final values = formKey.currentState!.value;

      isSaving.value = true;

      final templateData = MessageTemplate(
        id: template?.id ?? '',
        name: (values['name'] as String).trim(),
        content: (values['content'] as String).trim(),
        category: _nullIfEmpty(values['category'] as String?),
        branch: template?.branch,
        isDefault: values['isDefault'] as bool? ?? false,
      );

      bool success;
      if (isEditing) {
        success = await ref
            .read(messageTemplatesControllerProvider.notifier)
            .updateTemplate(templateData);
      } else {
        success = await ref
            .read(messageTemplatesControllerProvider.notifier)
            .createTemplate(templateData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save template. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(
          context,
          message: isEditing
              ? 'Template updated successfully'
              : 'Template created successfully',
        );
      }
    }

    void insertPlaceholder(String placeholder) {
      final field = formKey.currentState?.fields['content'];
      if (field != null) {
        final controller = (field.widget as FormBuilderTextField).controller;
        if (controller != null) {
          final text = controller.text;
          final selection = controller.selection;
          final newText = text.replaceRange(
            selection.start,
            selection.end,
            placeholder,
          );
          controller.text = newText;
          controller.selection = TextSelection.collapsed(
            offset: selection.start + placeholder.length,
          );
        } else {
          // Fallback: append to end
          final currentValue = field.value as String? ?? '';
          field.didChange('$currentValue$placeholder');
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
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isEditing ? 'Edit Template' : 'New Template',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: isSaving.value ? null : handleSave,
                    child: isSaving.value
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name field
              FormBuilderTextField(
                name: 'name',
                initialValue: template?.name,
                decoration: const InputDecoration(
                  labelText: 'Template Name *',
                  hintText: 'e.g., Appointment Reminder',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Category field (autocomplete)
              FormBuilderDropdown<String>(
                name: 'category',
                initialValue: template?.category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  hintText: 'Select or type a category',
                ),
                items: allCategories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Is default toggle
              FormBuilderSwitch(
                name: 'isDefault',
                initialValue: template?.isDefault ?? false,
                title: const Text('Default Template'),
                subtitle: const Text(
                  'Use as default for this category/treatment type',
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),

              // Content field
              FormBuilderTextField(
                name: 'content',
                initialValue: template?.content,
                decoration: const InputDecoration(
                  labelText: 'Message Content *',
                  hintText: 'Enter message with placeholders...',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              // Placeholder buttons
              Text(
                'Insert Placeholder',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 8),

              // Patient placeholders
              Text(
                'Patient Data',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _PlaceholderChip(
                    label: '{patientName}',
                    onTap: () => insertPlaceholder('{patientName}'),
                  ),
                  _PlaceholderChip(
                    label: '{patientPhone}',
                    onTap: () => insertPlaceholder('{patientPhone}'),
                  ),
                  _PlaceholderChip(
                    label: '{ownerName}',
                    onTap: () => insertPlaceholder('{ownerName}'),
                  ),
                  _PlaceholderChip(
                    label: '{species}',
                    onTap: () => insertPlaceholder('{species}'),
                  ),
                  _PlaceholderChip(
                    label: '{breed}',
                    onTap: () => insertPlaceholder('{breed}'),
                  ),
                  _PlaceholderChip(
                    label: '{email}',
                    onTap: () => insertPlaceholder('{email}'),
                  ),
                  _PlaceholderChip(
                    label: '{address}',
                    onTap: () => insertPlaceholder('{address}'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Appointment placeholders
              Text(
                'Appointment Data',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _PlaceholderChip(
                    label: '{appointmentDate}',
                    onTap: () => insertPlaceholder('{appointmentDate}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentTime}',
                    onTap: () => insertPlaceholder('{appointmentTime}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentDay}',
                    onTap: () => insertPlaceholder('{appointmentDay}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentMonth}',
                    onTap: () => insertPlaceholder('{appointmentMonth}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentYear}',
                    onTap: () => insertPlaceholder('{appointmentYear}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentHour}',
                    onTap: () => insertPlaceholder('{appointmentHour}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentMinutes}',
                    onTap: () => insertPlaceholder('{appointmentMinutes}'),
                    isAppointment: true,
                  ),
                  _PlaceholderChip(
                    label: '{appointmentAmPm}',
                    onTap: () => insertPlaceholder('{appointmentAmPm}'),
                    isAppointment: true,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Branch placeholders
              Text(
                'Branch Data',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _PlaceholderChip(
                    label: '{branchName}',
                    onTap: () => insertPlaceholder('{branchName}'),
                    isBranch: true,
                  ),
                  _PlaceholderChip(
                    label: '{branchAddress}',
                    onTap: () => insertPlaceholder('{branchAddress}'),
                    isBranch: true,
                  ),
                  _PlaceholderChip(
                    label: '{branchPhone}',
                    onTap: () => insertPlaceholder('{branchPhone}'),
                    isBranch: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }
}

class _PlaceholderChip extends StatelessWidget {
  const _PlaceholderChip({
    required this.label,
    required this.onTap,
    this.isAppointment = false,
    this.isBranch = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isAppointment;
  final bool isBranch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color textColor;

    if (isAppointment) {
      backgroundColor = theme.colorScheme.tertiaryContainer;
      textColor = theme.colorScheme.onTertiaryContainer;
    } else if (isBranch) {
      backgroundColor = theme.colorScheme.secondaryContainer;
      textColor = theme.colorScheme.onSecondaryContainer;
    } else {
      backgroundColor = theme.colorScheme.primaryContainer;
      textColor = theme.colorScheme.onPrimaryContainer;
    }

    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
      onPressed: onTap,
    );
  }
}
