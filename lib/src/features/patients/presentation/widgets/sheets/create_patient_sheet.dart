import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/routing/routes/patients.routes.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient.dart';
import '../../../domain/patient_record.dart';
import '../../controllers/patient_records_controller.dart';
import '../../controllers/patients_controller.dart';
import '../../controllers/species_breeds_provider.dart';

/// Bottom sheet for creating a new patient with all data fields
/// and an optional first medical record.
class CreatePatientSheet extends HookConsumerWidget {
  const CreatePatientSheet({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final ownerExpanded = useState(true);
    final recordExpanded = useState(false);
    final ownerHasError = useState(false);

    // Track if user has ever expanded the record section (means they want to add a record)
    final recordEverOpened = useState(false);

    // Track selected species for breed filtering
    final selectedSpeciesId = useState<String?>(null);

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

      // Additional validation for medical record (if user opened the section)
      if (recordEverOpened.value) {
        final diagnosis = values['diagnosis'] as String?;
        if (diagnosis == null || diagnosis.trim().isEmpty) {
          showFormErrorDialog(
            context,
            errors: ['Diagnosis is required when adding a medical record'],
          );
          return;
        }
      }

      isSaving.value = true;

      // Create patient
      final patient = Patient(
        id: '',
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
      );

      final success = await ref
          .read(patientsControllerProvider.notifier)
          .createPatient(patient);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to create patient. Please try again.'],
          );
        }
        return;
      }

      // Get created patient ID from state
      final patients = ref.read(patientsControllerProvider).value;
      final createdPatient = patients?.firstOrNull;

      // Create medical record if user opened the section
      if (recordEverOpened.value && createdPatient != null) {
        final weight = values['weight'] as String?;
        final temperature = values['temperature'] as String?;

        final record = PatientRecord(
          id: '',
          patientId: createdPatient.id,
          date: values['recordDate'] as DateTime? ?? DateTime.now(),
          diagnosis: (values['diagnosis'] as String).trim(),
          weight: weight?.isEmpty ?? true ? '' : '$weight kg',
          temperature: temperature?.isEmpty ?? true ? '' : '$temperature °C',
          treatment: _nullIfEmpty(values['treatment'] as String?),
          notes: _nullIfEmpty(values['notes'] as String?),
        );

        await ref
            .read(patientRecordsControllerProvider(createdPatient.id).notifier)
            .createRecord(record);
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(context, message: 'Patient created successfully');

        // Navigate to patient detail
        if (createdPatient != null) {
          PatientDetailRoute(id: createdPatient.id).go(context);
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
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text('Create Patient', style: theme.textTheme.titleLarge),
              const SizedBox(height: 24),

              // === PATIENT INFORMATION SECTION ===
              _SectionHeader(
                title: 'Patient Information',
                icon: Icons.pets,
              ),
              const SizedBox(height: 16),

              // Pet Name (required)
              FormBuilderTextField(
                name: 'name',
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
                              child: CircularProgressIndicator(strokeWidth: 2),
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
                      data: (breedsList) => FormBuilderDropdown<String>(
                        name: 'breed',
                        decoration: const InputDecoration(
                          labelText: 'Breed',
                          border: OutlineInputBorder(),
                        ),
                        enabled:
                            !isSaving.value && selectedSpeciesId.value != null,
                        items: breedsList.map((b) {
                          return DropdownMenuItem(
                            value: b.id,
                            child: Text(b.name),
                          );
                        }).toList(),
                      ),
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
                spacing: 8,
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
                      decoration: const InputDecoration(
                        labelText: 'Owner Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      enabled: !isSaving.value,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'contactNumber',
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      enabled: !isSaving.value,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      enabled: !isSaving.value,
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.email(
                        errorText: 'Invalid email format',
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'address',
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
              const SizedBox(height: 16),

              // === MEDICAL RECORD SECTION (Optional, Collapsible) ===
              _CollapsibleSection(
                title: 'First Medical Record (Optional)',
                icon: Icons.medical_services,
                isExpanded: recordExpanded.value,
                onToggle: () {
                  recordExpanded.value = !recordExpanded.value;
                  // Mark as opened when user expands (they want to add a record)
                  if (recordExpanded.value) {
                    recordEverOpened.value = true;
                  }
                },
                maintainState: false,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    FormBuilderDateTimePicker(
                      name: 'recordDate',
                      decoration: const InputDecoration(
                        labelText: 'Visit Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      enabled: !isSaving.value,
                      inputType: InputType.date,
                      initialValue: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'diagnosis',
                      decoration: const InputDecoration(
                        labelText: 'Diagnosis *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                      enabled: !isSaving.value,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'weight',
                            decoration: const InputDecoration(
                              labelText: 'Weight',
                              border: OutlineInputBorder(),
                              suffixText: 'kg',
                            ),
                            enabled: !isSaving.value,
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.numeric(
                              errorText: 'Must be a number',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'temperature',
                            decoration: const InputDecoration(
                              labelText: 'Temperature',
                              border: OutlineInputBorder(),
                              suffixText: '°C',
                            ),
                            enabled: !isSaving.value,
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.numeric(
                              errorText: 'Must be a number',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'treatment',
                      decoration: const InputDecoration(
                        labelText: 'Treatment',
                        border: OutlineInputBorder(),
                      ),
                      enabled: !isSaving.value,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'notes',
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        border: OutlineInputBorder(),
                      ),
                      enabled: !isSaving.value,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // === ACTION BUTTONS ===
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:
                          isSaving.value ? null : () => Navigator.pop(context),
                      child: Text(t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: isSaving.value ? null : handleSave,
                      child: isSaving.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(t.common.save),
                    ),
                  ),
                ],
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
    'recordDate': 'Visit Date',
    'diagnosis': 'Diagnosis',
    'weight': 'Weight',
    'temperature': 'Temperature',
    'treatment': 'Treatment',
    'notes': 'Notes',
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

  /// If true, the child is kept in the widget tree when collapsed (using Offstage).
  /// If false, the child is completely removed when collapsed.
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

/// Shows the create patient sheet as a modal bottom sheet.
void showCreatePatientSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => CreatePatientSheet(
        scrollController: scrollController,
      ),
    ),
  );
}
