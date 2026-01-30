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
import '../../../../../core/widgets/form/async_form_dropdown.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../../appointments/presentation/widgets/dialogs/create_appointment_dialog.dart';
import '../../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../../domain/patient.dart';
import '../../../domain/patient_breed.dart';
import '../../../domain/patient_record.dart';
import '../../../domain/patient_species.dart';
import '../../../domain/prescription.dart';
import '../../controllers/patient_records_controller.dart';
import '../../controllers/patients_controller.dart';
import '../../controllers/prescription_controller.dart';
import '../../controllers/species_breeds_provider.dart';

/// Enhanced dialog for creating a new patient with full form support.
///
/// Features:
/// - Patient info + Owner info
/// - Medical Record + Prescription sections
/// - Progressive disclosure: Sections unlock as required fields are filled
/// - Integrated appointment scheduling
class CreatePatientFullDialog extends HookConsumerWidget {
  const CreatePatientFullDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: formKey);

    // UI state
    final isSaving = useState(false);

    // Section expansion state
    final ownerExpanded = useState(true);
    final recordExpanded = useState(false);
    final prescriptionExpanded = useState(false);

    // Track if sections were ever opened (for validation)
    final recordEverOpened = useState(false);
    final prescriptionEverOpened = useState(false);

    // Section error tracking
    final ownerHasError = useState(false);
    final recordHasError = useState(false);
    final prescriptionHasError = useState(false);

    // Progressive disclosure: track if required fields are complete
    final requiredFieldsComplete = useState(false);
    final recordHasDiagnosis = useState(false);

    // Track selected species for breed filtering
    final selectedSpeciesId = useState<String?>(null);

    // Watch providers
    final speciesAsync = ref.watch(speciesProvider);
    final breedsAsync =
        ref.watch(breedsBySpeciesProvider(selectedSpeciesId.value));

    // Helper to check if required fields are complete
    void updateRequiredFieldsStatus() {
      final fields = formKey.currentState?.fields;
      if (fields == null) {
        requiredFieldsComplete.value = false;
        return;
      }

      final name = fields['name']?.value as String?;
      final owner = fields['owner']?.value as String?;
      final phone = fields['contactNumber']?.value as String?;

      requiredFieldsComplete.value = (name?.trim().isNotEmpty ?? false) &&
          (owner?.trim().isNotEmpty ?? false) &&
          (phone?.trim().isNotEmpty ?? false);
    }

    // Helper to check if diagnosis is filled
    void updateDiagnosisStatus() {
      final fields = formKey.currentState?.fields;
      if (fields == null) {
        recordHasDiagnosis.value = false;
        return;
      }

      final diagnosis = fields['diagnosis']?.value as String?;
      recordHasDiagnosis.value = diagnosis?.trim().isNotEmpty ?? false;
    }

    // Helper to check if owner fields have errors
    bool checkOwnerErrors() {
      final fields = formKey.currentState?.fields;
      if (fields == null) return false;

      final ownerFields = ['owner', 'contactNumber', 'email', 'address'];
      return ownerFields.any((name) => fields[name]?.hasError ?? false);
    }

    // Helper to check if record fields have errors
    bool checkRecordErrors() {
      final fields = formKey.currentState?.fields;
      if (fields == null) return false;

      final recordFields = [
        'recordDate',
        'diagnosis',
        'weight',
        'temperature',
        'treatment',
        'notes',
      ];
      return recordFields.any((name) => fields[name]?.hasError ?? false);
    }

    // Helper to check if prescription fields have errors
    bool checkPrescriptionErrors() {
      final fields = formKey.currentState?.fields;
      if (fields == null) return false;

      final prescriptionFields = [
        'medication',
        'prescriptionDate',
        'dosage',
        'instructions',
      ];
      return prescriptionFields.any((name) => fields[name]?.hasError ?? false);
    }

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      // Check section errors and update state
      ownerHasError.value = checkOwnerErrors();
      if (recordEverOpened.value) {
        recordHasError.value = checkRecordErrors();
      }
      if (prescriptionEverOpened.value) {
        prescriptionHasError.value = checkPrescriptionErrors();
      }

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

      // Additional validation for prescription (if user opened the section)
      if (prescriptionEverOpened.value) {
        final medication = values['medication'] as String?;
        if (medication == null || medication.trim().isEmpty) {
          showFormErrorDialog(
            context,
            errors: ['Medication is required when adding a prescription'],
          );
          return;
        }
        // Prescription requires a record
        if (!recordEverOpened.value) {
          showFormErrorDialog(
            context,
            errors: [
              'A medical record is required to add a prescription. Please fill in the Medical Record section.',
            ],
          );
          return;
        }
      }

      isSaving.value = true;

      // Get current working branch
      final userBranch = ref.read(currentBranchIdProvider);

      // 1. Create patient
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
        branch: userBranch,
      );

      final patientSuccess = await ref
          .read(patientsControllerProvider.notifier)
          .createPatient(patient);

      if (!patientSuccess) {
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

      String? createdRecordId;

      // 2. Create medical record if user opened the section
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

        final createdRecord = await ref
            .read(patientRecordsControllerProvider(createdPatient.id).notifier)
            .createRecordAndReturn(record);

        createdRecordId = createdRecord?.id;
      }

      // 3. Create prescription if user opened the section and record exists
      if (prescriptionEverOpened.value && createdRecordId != null) {
        final prescription = Prescription(
          id: '',
          recordId: createdRecordId,
          medication: (values['medication'] as String).trim(),
          dosage: _nullIfEmpty(values['dosage'] as String?),
          instructions: _nullIfEmpty(values['instructions'] as String?),
          date: values['prescriptionDate'] as DateTime?,
        );

        await ref
            .read(prescriptionControllerProvider(createdRecordId).notifier)
            .createPrescription(prescription);
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

    void openCreateAppointmentDialog(Patient patient) {
      showCreateAppointmentDialog(
        context,
        initialPatient: patient,
        onSave: (appointment) async {
          return await ref
              .read(appointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);
        },
      );
    }

    return DialogCloseHandler(
      onClose: (ctx) => dirtyGuard.confirmDiscard(ctx),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: dirtyGuard.onPopInvokedWithResult,
        child: ConstrainedDialogContent(
          fullScreen: true,
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
                        'Create Patient',
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),

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
                          onChanged: (_) => updateRequiredFieldsStatus(),
                        ),
                        const SizedBox(height: 16),

                        // Species & Breed typeaheads
                        Row(
                          children: [
                            Expanded(
                              child: AsyncFormDropdown<PatientSpecies>(
                                name: 'species',
                                label: 'Species',
                                asyncData: speciesAsync,
                                displayString: (s) => s.name,
                                enabled: !isSaving.value,
                                valueTransformer: (s) => s?.id,
                                onChanged: (species) {
                                  selectedSpeciesId.value = species?.id;
                                  // Clear breed when species changes
                                  formKey.currentState?.fields['breed']
                                      ?.didChange(null);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AsyncFormDropdown<PatientBreed>(
                                name: 'breed',
                                label: 'Breed',
                                asyncData: breedsAsync,
                                displayString: (b) => b.name,
                                enabled: !isSaving.value &&
                                    selectedSpeciesId.value != null,
                                valueTransformer: (b) => b?.id,
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
                          onToggle: () =>
                              ownerExpanded.value = !ownerExpanded.value,
                          hasError: ownerHasError.value,
                          maintainState: true,
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              FormBuilderTextField(
                                name: 'owner',
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
                                onChanged: (_) => updateRequiredFieldsStatus(),
                              ),
                              const SizedBox(height: 16),
                              FormBuilderTextField(
                                name: 'contactNumber',
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
                                onChanged: (_) => updateRequiredFieldsStatus(),
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
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return null;
                                  }
                                  return FormBuilderValidators.email(
                                    errorText: 'Invalid email format',
                                  )(value);
                                },
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

                        // === MEDICAL RECORD SECTION ===
                        _DisabledSection(
                          isDisabled: !requiredFieldsComplete.value,
                          message: 'Complete required patient details above',
                          child: _CollapsibleSection(
                            title: 'Medical Record (Optional)',
                            icon: Icons.medical_services,
                            isExpanded: recordExpanded.value,
                            onToggle: requiredFieldsComplete.value
                                ? () {
                                    recordExpanded.value =
                                        !recordExpanded.value;
                                    if (recordExpanded.value) {
                                      recordEverOpened.value = true;
                                    }
                                  }
                                : null,
                            hasError: recordHasError.value,
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
                                  onChanged: (_) => updateDiagnosisStatus(),
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
                                        validator:
                                            FormBuilderValidators.numeric(
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
                                        validator:
                                            FormBuilderValidators.numeric(
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
                        ),
                        const SizedBox(height: 16),

                        // === PRESCRIPTION SECTION ===
                        _DisabledSection(
                          isDisabled: !recordHasDiagnosis.value,
                          message: 'Add a diagnosis in Medical Record first',
                          child: _CollapsibleSection(
                            title: 'Prescription (Optional)',
                            icon: Icons.medication,
                            isExpanded: prescriptionExpanded.value,
                            onToggle: recordHasDiagnosis.value
                                ? () {
                                    prescriptionExpanded.value =
                                        !prescriptionExpanded.value;
                                    if (prescriptionExpanded.value) {
                                      prescriptionEverOpened.value = true;
                                    }
                                  }
                                : null,
                            hasError: prescriptionHasError.value,
                            maintainState: false,
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                FormBuilderTextField(
                                  name: 'medication',
                                  decoration: const InputDecoration(
                                    labelText: 'Medication *',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.medication),
                                  ),
                                  enabled: !isSaving.value,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                const SizedBox(height: 16),
                                FormBuilderDateTimePicker(
                                  name: 'prescriptionDate',
                                  decoration: const InputDecoration(
                                    labelText: 'Date',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  enabled: !isSaving.value,
                                  inputType: InputType.date,
                                  initialValue: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                ),
                                const SizedBox(height: 16),
                                FormBuilderTextField(
                                  name: 'dosage',
                                  decoration: const InputDecoration(
                                    labelText: 'Dosage',
                                    border: OutlineInputBorder(),
                                    hintText: 'e.g., 250mg, 2x daily',
                                  ),
                                  enabled: !isSaving.value,
                                ),
                                const SizedBox(height: 16),
                                FormBuilderTextField(
                                  name: 'instructions',
                                  decoration: const InputDecoration(
                                    labelText: 'Instructions',
                                    border: OutlineInputBorder(),
                                  ),
                                  enabled: !isSaving.value,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // === SCHEDULE APPOINTMENT BUTTON ===
                        _ActionCard(
                          icon: Icons.calendar_month,
                          title: 'Schedule Appointment',
                          subtitle:
                              'Save patient first, then schedule a follow-up',
                          enabled: !isSaving.value,
                          onTap: () async {
                            // First save the patient, then open appointment dialog
                            final isValid =
                                formKey.currentState!.saveAndValidate();
                            if (!isValid) {
                              showFormErrorDialog(
                                context,
                                errors: [
                                  'Please fill in required fields before scheduling',
                                ],
                              );
                              return;
                            }

                            await handleSave();

                            // Get the created patient and open appointment dialog
                            if (context.mounted) {
                              final patients =
                                  ref.read(patientsControllerProvider).value;
                              final createdPatient = patients?.firstOrNull;
                              if (createdPatient != null) {
                                openCreateAppointmentDialog(createdPatient);
                              }
                            }
                          },
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
    'recordDate': 'Visit Date',
    'diagnosis': 'Diagnosis',
    'weight': 'Weight',
    'temperature': 'Temperature',
    'treatment': 'Treatment',
    'notes': 'Notes',
    'medication': 'Medication',
    'prescriptionDate': 'Prescription Date',
    'dosage': 'Dosage',
    'instructions': 'Instructions',
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
    this.hasError = false,
    this.maintainState = false,
  });

  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback? onToggle;
  final Widget child;
  final bool hasError;

  /// If true, the child is kept in the widget tree when collapsed (using Offstage).
  /// If false, the child is completely removed when collapsed.
  final bool maintainState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onToggle != null;
    final borderColor = hasError
        ? theme.colorScheme.error
        : isEnabled
            ? theme.colorScheme.outlineVariant
            : theme.colorScheme.outlineVariant.withValues(alpha: 0.5);
    final headerColor = hasError
        ? theme.colorScheme.error
        : isEnabled
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.38);

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
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isEnabled
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.38),
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

/// Widget that shows a disabled overlay with a message.
class _DisabledSection extends StatelessWidget {
  const _DisabledSection({
    required this.isDisabled,
    required this.message,
    required this.child,
  });

  final bool isDisabled;
  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!isDisabled) return child;

    final theme = Theme.of(context);

    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: IgnorePointer(
            ignoring: true,
            child: child,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    message,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Action card for triggering additional actions like scheduling appointments.
class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: enabled
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface
                                .withValues(alpha: 0.38),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: enabled
                    ? theme.colorScheme.onSurfaceVariant
                    : theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows the enhanced create patient dialog.
///
/// This dialog shows the full form with all sections for patient creation,
/// including medical records, prescriptions, and appointment scheduling.
void showCreatePatientFullDialog(BuildContext context) {
  showConstrainedDialog(
    context: context,
    fullScreen: true,
    builder: (context) => const CreatePatientFullDialog(),
  );
}
