import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/routing/routes/patients.routes.dart';
import '../../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../../domain/patient.dart';
import '../../controllers/patients_controller.dart';
import '../../controllers/species_breeds_provider.dart';

/// Dialog for editing patient information.
class EditPatientDialog extends HookConsumerWidget {
  const EditPatientDialog({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: {
        'name': patient.name,
        'species': patient.speciesId,
        'breed': patient.breedId,
        'sex': patient.sex,
        'color': patient.color,
        'dateOfBirth': patient.dateOfBirth,
        'owner': patient.owner,
        'contactNumber': patient.contactNumber,
        'email': patient.email,
        'address': patient.address,
      },
    );

    // UI state
    final isSaving = useState(false);
    final ownerExpanded = useState(true);
    final ownerHasError = useState(false);

    // Track selected species for breed filtering
    final selectedSpeciesId = useState<String?>(patient.speciesId);

    // Watch providers
    final speciesAsync = ref.watch(speciesProvider);
    final breedsAsync =
        ref.watch(breedsBySpeciesProvider(selectedSpeciesId.value));

    // Helper to check if owner fields have errors
    bool checkOwnerErrors() {
      final fields = formKey.currentState?.fields;
      if (fields == null) return false;

      final ownerFields = ['owner', 'contactNumber', 'email', 'address'];
      return ownerFields.any((name) => fields[name]?.hasError ?? false);
    }

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      // Check owner section errors and update state
      ownerHasError.value = checkOwnerErrors();

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

      // Get current working branch (preserve existing branch if no branch selected)
      final userBranch = ref.read(currentBranchIdProvider) ?? patient.branch;

      // Create updated patient
      final updatedPatient = Patient(
        id: patient.id,
        name: (values['name'] as String).trim(),
        speciesId: values['species'] as String?,
        breedId: values['breed'] as String?,
        owner: _nullIfEmpty(values['owner'] as String?),
        contactNumber: _nullIfEmpty(values['contactNumber'] as String?),
        email: _nullIfEmpty(values['email'] as String?),
        address: _nullIfEmpty(values['address'] as String?),
        color: _nullIfEmpty(values['color'] as String?),
        sex: values['sex'] as PatientSex?,
        dateOfBirth: values['dateOfBirth'] as DateTime?,
        branch: userBranch,
      );

      final success = await ref
          .read(patientsControllerProvider.notifier)
          .updatePatient(updatedPatient);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(context,
              errors: ['Failed to update patient. Please try again.']);
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();
        showSuccessSnackBar(context, message: 'Patient updated successfully');
        // Refresh detail view
        PatientDetailRoute(id: patient.id).go(context);
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
                      child:
                          Text('Edit Patient', style: theme.textTheme.titleLarge),
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
                      child: Text(t.common.cancel),
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
                        : Text(t.common.save),
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

                      // === PATIENT INFORMATION SECTION ===
                      const _SectionHeader(
                        title: 'Patient Information',
                        icon: Icons.pets,
                      ),
                      const SizedBox(height: 16),

                      // Pet Name (required)
                      FormBuilderTextField(
                        name: 'name',
                        initialValue: patient.name,
                        decoration: const InputDecoration(
                          labelText: 'Pet Name *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.pets),
                        ),
                        enabled: !isSaving.value,
                        textCapitalization: TextCapitalization.words,
                        validator: FormBuilderValidators.required(
                          errorText: 'Pet name is required',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Species & Breed dropdowns
                      Row(
                        children: [
                          Expanded(
                            child: speciesAsync.when(
                              data: (speciesList) => FormBuilderDropdown<String>(
                                name: 'species',
                                decoration: const InputDecoration(
                                  labelText: 'Species',
                                  border: OutlineInputBorder(),
                                ),
                                enabled: !isSaving.value,
                                initialValue: patient.speciesId,
                                items: speciesList.map((s) {
                                  return DropdownMenuItem(
                                    value: s.id,
                                    child: Text(s.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  selectedSpeciesId.value = value;
                                  // Clear breed when species changes
                                  formKey.currentState?.fields['breed']
                                      ?.didChange(null);
                                },
                              ),
                              loading: () => const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Species',
                                  border: OutlineInputBorder(),
                                  suffixIcon: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child:
                                          CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                ),
                                enabled: false,
                              ),
                              error: (_, __) => const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Species',
                                  border: OutlineInputBorder(),
                                  errorText: 'Failed to load',
                                ),
                                enabled: false,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: breedsAsync.when(
                              data: (breedsList) {
                                // Only use patient's breedId if it exists in the list
                                final breedExists = breedsList.any(
                                  (b) => b.id == patient.breedId,
                                );
                                return FormBuilderDropdown<String>(
                                  name: 'breed',
                                  decoration: const InputDecoration(
                                    labelText: 'Breed',
                                    border: OutlineInputBorder(),
                                  ),
                                  enabled:
                                      !isSaving.value && selectedSpeciesId.value != null,
                                  initialValue: breedExists ? patient.breedId : null,
                                  items: breedsList.map((b) {
                                    return DropdownMenuItem(
                                      value: b.id,
                                      child: Text(b.name),
                                    );
                                  }).toList(),
                                );
                              },
                              loading: () => const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Breed',
                                  border: OutlineInputBorder(),
                                ),
                                enabled: false,
                              ),
                              error: (_, __) => const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Breed',
                                  border: OutlineInputBorder(),
                                ),
                                enabled: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Sex selection
                      FormBuilderChoiceChips<PatientSex>(
                        name: 'sex',
                        decoration: const InputDecoration(
                          labelText: 'Sex',
                          border: OutlineInputBorder(),
                        ),
                        enabled: !isSaving.value,
                        initialValue: patient.sex,
                        spacing: 8,
                        showCheckmark: true,
                        options: const [
                          FormBuilderChipOption(
                            value: PatientSex.male,
                            avatar: Icon(Icons.male, size: 18),
                            child: Text('Male'),
                          ),
                          FormBuilderChipOption(
                            value: PatientSex.female,
                            avatar: Icon(Icons.female, size: 18),
                            child: Text('Female'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Color & Date of Birth
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              name: 'color',
                              initialValue: patient.color,
                              decoration: const InputDecoration(
                                labelText: 'Color/Markings',
                                border: OutlineInputBorder(),
                              ),
                              enabled: !isSaving.value,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'dateOfBirth',
                              initialValue: patient.dateOfBirth,
                              decoration: const InputDecoration(
                                labelText: 'Date of Birth',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              enabled: !isSaving.value,
                              inputType: InputType.date,
                              firstDate: DateTime(1990),
                              lastDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // === OWNER INFORMATION SECTION (Collapsible) ===
                      _CollapsibleSection(
                        title: 'Owner Information',
                        icon: Icons.person,
                        isExpanded: ownerExpanded.value,
                        onToggle: () => ownerExpanded.value = !ownerExpanded.value,
                        hasError: ownerHasError.value,
                        maintainState: true,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            FormBuilderTextField(
                              name: 'owner',
                              initialValue: patient.owner,
                              decoration: const InputDecoration(
                                labelText: 'Owner Name *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              enabled: !isSaving.value,
                              textCapitalization: TextCapitalization.words,
                              validator: FormBuilderValidators.required(
                                errorText: 'Owner name is required',
                              ),
                            ),
                            const SizedBox(height: 16),
                            FormBuilderTextField(
                              name: 'contactNumber',
                              initialValue: patient.contactNumber,
                              decoration: const InputDecoration(
                                labelText: 'Phone *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              enabled: !isSaving.value,
                              keyboardType: TextInputType.phone,
                              validator: FormBuilderValidators.required(
                                errorText: 'Phone number is required',
                              ),
                            ),
                            const SizedBox(height: 16),
                            FormBuilderTextField(
                              name: 'email',
                              initialValue: patient.email,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                              enabled: !isSaving.value,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) return null;
                                return FormBuilderValidators.email(
                                  errorText: 'Invalid email format',
                                )(value);
                              },
                            ),
                            const SizedBox(height: 16),
                            FormBuilderTextField(
                              name: 'address',
                              initialValue: patient.address,
                              decoration: const InputDecoration(
                                labelText: 'Address',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.location_on),
                              ),
                              enabled: !isSaving.value,
                              maxLines: 2,
                            ),
                          ],
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

  String? _nullIfEmpty(String? text) {
    if (text == null) return null;
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static const _fieldLabels = {
    'name': 'Pet Name',
    'species': 'Species',
    'breed': 'Breed',
    'sex': 'Sex',
    'color': 'Color',
    'dateOfBirth': 'Date of Birth',
    'owner': 'Owner Name',
    'contactNumber': 'Contact Number',
    'email': 'Email',
    'address': 'Address',
  };
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _CollapsibleSection extends StatelessWidget {
  const _CollapsibleSection({
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
    this.trailing,
    this.hasError = false,
    this.maintainState = false,
  });

  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;
  final Widget? trailing;
  final bool hasError;
  final bool maintainState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor =
        hasError ? theme.colorScheme.error : theme.colorScheme.outlineVariant;
    final headerColor =
        hasError ? theme.colorScheme.error : theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: headerColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: headerColor,
                      ),
                    ),
                  ),
                  if (trailing != null) trailing!,
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (maintainState)
            Offstage(
              offstage: !isExpanded,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: child,
              ),
            )
          else if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: child,
            ),
        ],
      ),
    );
  }
}

/// Shows the edit patient dialog.
void showEditPatientDialog(BuildContext context, {required Patient patient}) {
  showConstrainedDialog(
    context: context,
    builder: (context) => EditPatientDialog(patient: patient),
  );
}
