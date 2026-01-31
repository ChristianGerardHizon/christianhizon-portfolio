import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../settings/domain/message_template.dart';
import '../../../../patients/domain/patient.dart';
import '../../../../patients/presentation/controllers/patients_controller.dart';
import '../../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../../settings/presentation/controllers/branch_provider.dart';
import '../../../../settings/presentation/controllers/message_templates_controller.dart';
import '../../../domain/message.dart';

/// Dialog for creating a new message.
class CreateMessageDialog extends HookConsumerWidget {
  const CreateMessageDialog({
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
    final size = MediaQuery.sizeOf(context);

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: formKey);
    final isSaving = useState(false);
    final selectedPatient = useState<Patient?>(initialPatient);

    // Watch patients for dropdown
    final patientsAsync = ref.watch(patientsControllerProvider);

    // Watch templates for dropdown
    final templatesAsync = ref.watch(messageTemplatesControllerProvider);

    String replacePlaceholders(
      String content,
      Patient? patient, {
      String? branchName,
      String? branchAddress,
      String? branchPhone,
      String? branchOperatingHours,
      String? branchCutOffTime,
      DateTime? appointmentDateTime,
    }) {
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

        // Replace pronoun placeholders based on patient sex
        final isMale = patient.sex == PatientSex.male;
        replaced = replaced.replaceAll(
          '{patientPronoun}',
          isMale ? 'he' : 'she',
        );
        replaced = replaced.replaceAll(
          '{patientPronounObject}',
          isMale ? 'him' : 'her',
        );
        replaced = replaced.replaceAll(
          '{patientPronounPossessive}',
          isMale ? 'his' : 'her',
        );
      }

      // Replace branch data
      if (branchName != null) {
        replaced = replaced.replaceAll('{branchName}', branchName);
      }
      if (branchAddress != null) {
        replaced = replaced.replaceAll('{branchAddress}', branchAddress);
      }
      if (branchPhone != null) {
        replaced = replaced.replaceAll('{branchPhone}', branchPhone);
      }
      if (branchOperatingHours != null) {
        replaced = replaced.replaceAll(
            '{branchOperatingHours}', branchOperatingHours);
      }
      if (branchCutOffTime != null) {
        replaced =
            replaced.replaceAll('{branchCutOffTime}', branchCutOffTime);
      }

      // Replace appointment data
      if (appointmentDateTime != null) {
        // Day names
        const dayNames = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ];
        // Month abbreviations
        const monthNames = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];

        final day = dayNames[appointmentDateTime.weekday - 1];
        final month = monthNames[appointmentDateTime.month - 1];
        final year = appointmentDateTime.year.toString();
        final hour24 = appointmentDateTime.hour;
        final hour12 = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);
        final minutes = appointmentDateTime.minute.toString().padLeft(2, '0');
        final amPm = hour24 >= 12 ? 'PM' : 'AM';

        // Full date format: "Jan 15, 2025"
        final dateStr =
            '$month ${appointmentDateTime.day}, ${appointmentDateTime.year}';
        // Time format: "2:30 PM"
        final timeStr = '$hour12:$minutes $amPm';

        replaced = replaced.replaceAll('{appointmentDate}', dateStr);
        replaced = replaced.replaceAll('{appointmentTime}', timeStr);
        replaced = replaced.replaceAll('{appointmentDay}', day);
        replaced = replaced.replaceAll('{appointmentMonth}', month);
        replaced = replaced.replaceAll('{appointmentYear}', year);
        replaced = replaced.replaceAll('{appointmentHour}', hour12.toString());
        replaced = replaced.replaceAll('{appointmentMinutes}', minutes);
        replaced = replaced.replaceAll('{appointmentAmPm}', amPm);
      }

      return replaced;
    }

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
        // Default to 8 AM if no time provided
        sendDateTime = DateTime(date.year, date.month, date.day, 8, 0);
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
          context.pop();
          showSuccessSnackBar(context, message: 'Message scheduled successfully');
        } else {
          isSaving.value = false;
          showErrorSnackBar(context, message: 'Failed to schedule message');
        }
      }
    }

    return DialogCloseHandler(
      onClose: (ctx) => dirtyGuard.confirmDiscard(ctx),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: dirtyGuard.onPopInvokedWithResult,
        child: SizedBox(
        width: size.width,
        height: size.height,
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
                      'New Message',
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
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Schedule'),
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
                            leading:
                                Icon(Icons.pets, color: theme.colorScheme.primary),
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
                                return patient.name
                                        .toLowerCase()
                                        .contains(query) ||
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
                                    constraints:
                                        const BoxConstraints(maxHeight: 200),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: options.length,
                                      itemBuilder: (context, index) {
                                        final patient = options.elementAt(index);
                                        return ListTile(
                                          leading: const Icon(Icons.pets),
                                          title: Text(patient.name),
                                          subtitle:
                                              Text(patient.owner ?? 'No owner'),
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

                      // Template selector
                      templatesAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (templates) {
                          if (templates.isEmpty) return const SizedBox.shrink();

                          // Use the first template as default
                          final defaultTemplate =
                              templates.firstOrNull;

                          return _TemplateSelector(
                            templates: templates,
                            defaultTemplate: defaultTemplate,
                            formKey: formKey,
                            selectedPatient: selectedPatient.value,
                            initialAppointmentId: initialAppointmentId,
                            replacePlaceholders: replacePlaceholders,
                          );
                        },
                      ),

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
                          labelText: 'Send Time *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                          helperText: 'Defaults to 8:00 AM if not specified',
                        ),
                        inputType: InputType.time,
                        initialValue: DateTime.now().copyWith(hour: 8, minute: 0),
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

/// Separate widget to handle template selection with default auto-selection.
class _TemplateSelector extends HookConsumerWidget {
  const _TemplateSelector({
    required this.templates,
    required this.defaultTemplate,
    required this.formKey,
    required this.selectedPatient,
    required this.initialAppointmentId,
    required this.replacePlaceholders,
  });

  final List<MessageTemplate> templates;
  final MessageTemplate? defaultTemplate;
  final GlobalKey<FormBuilderState> formKey;
  final Patient? selectedPatient;
  final String? initialAppointmentId;
  final String Function(
    String content,
    Patient? patient, {
    String? branchName,
    String? branchAddress,
    String? branchPhone,
    String? branchOperatingHours,
    String? branchCutOffTime,
    DateTime? appointmentDateTime,
  }) replacePlaceholders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Track if we've already applied the default template
    final hasAppliedDefault = useState(false);

    // Apply default template content on first build
    useEffect(() {
      if (defaultTemplate != null && !hasAppliedDefault.value) {
        // Schedule the content update for after the current build
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          hasAppliedDefault.value = true;

          // Fetch branch data if template has a branch
          String? branchName;
          String? branchAddress;
          String? branchPhone;
          String? branchOperatingHours;
          String? branchCutOffTime;
          if (defaultTemplate!.branch != null) {
            final branchData = await ref
                .read(branchProvider(defaultTemplate!.branch!).future);
            if (branchData != null) {
              branchName = branchData.displayName ?? branchData.name;
              branchAddress = branchData.address;
              branchPhone = branchData.contactNumber;
              branchOperatingHours = branchData.operatingHours;
              branchCutOffTime = branchData.cutOffTime;
            }
          }

          // Fetch appointment data if linked
          DateTime? appointmentDateTime;
          if (initialAppointmentId != null) {
            final appointmentData = await ref.read(
              appointmentProvider(initialAppointmentId!).future,
            );
            appointmentDateTime = appointmentData?.date;
          }

          final finalContent = replacePlaceholders(
            defaultTemplate!.content,
            selectedPatient,
            branchName: branchName,
            branchAddress: branchAddress,
            branchPhone: branchPhone,
            branchOperatingHours: branchOperatingHours,
            branchCutOffTime: branchCutOffTime,
            appointmentDateTime: appointmentDateTime,
          );
          formKey.currentState?.fields['content']?.didChange(finalContent);
        });
      }
      return null;
    }, [defaultTemplate]);

    return Column(
      children: [
        FormBuilderDropdown<String>(
          name: 'template',
          initialValue: defaultTemplate?.id,
          decoration: const InputDecoration(
            labelText: 'Use Template',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.description_outlined),
            helperText: 'Select a template to auto-fill content',
          ),
          onChanged: (value) async {
            if (value != null) {
              final template = templates.firstWhere((t) => t.id == value);

              // Fetch branch data if template has a branch
              String? branchName;
              String? branchAddress;
              String? branchPhone;
              String? branchOperatingHours;
              String? branchCutOffTime;
              if (template.branch != null) {
                final branchData =
                    await ref.read(branchProvider(template.branch!).future);
                if (branchData != null) {
                  branchName = branchData.displayName ?? branchData.name;
                  branchAddress = branchData.address;
                  branchPhone = branchData.contactNumber;
                  branchOperatingHours = branchData.operatingHours;
                  branchCutOffTime = branchData.cutOffTime;
                }
              }

              // Fetch appointment data if linked
              DateTime? appointmentDateTime;
              if (initialAppointmentId != null) {
                final appointmentData = await ref.read(
                  appointmentProvider(initialAppointmentId!).future,
                );
                appointmentDateTime = appointmentData?.date;
              }

              final finalContent = replacePlaceholders(
                template.content,
                selectedPatient,
                branchName: branchName,
                branchAddress: branchAddress,
                branchPhone: branchPhone,
                branchOperatingHours: branchOperatingHours,
                branchCutOffTime: branchCutOffTime,
                appointmentDateTime: appointmentDateTime,
              );
              formKey.currentState?.fields['content']?.didChange(finalContent);
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
  }
}

/// Shows the create message dialog.
void showCreateMessageDialog(
  BuildContext context, {
  Patient? initialPatient,
  String? initialAppointmentId,
  required Future<Message?> Function(Message message) onSave,
}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: CreateMessageDialog(
        initialPatient: initialPatient,
        initialAppointmentId: initialAppointmentId,
        onSave: onSave,
      ),
    ),
  );
}
