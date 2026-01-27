import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/routing/routes/patients.routes.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../domain/patient.dart';
import '../../controllers/patients_controller.dart';
import '../../controllers/species_breeds_provider.dart';

/// Entry data for a single patient in the multi-patient form.
class _PatientEntry {
  _PatientEntry()
      : nameController = TextEditingController(),
        colorController = TextEditingController(),
        speciesId = ValueNotifier<String?>(null),
        breedId = ValueNotifier<String?>(null),
        sex = ValueNotifier<PatientSex?>(null),
        dateOfBirth = ValueNotifier<DateTime?>(null),
        isExpanded = ValueNotifier<bool>(true);

  final TextEditingController nameController;
  final TextEditingController colorController;
  final ValueNotifier<String?> speciesId;
  final ValueNotifier<String?> breedId;
  final ValueNotifier<PatientSex?> sex;
  final ValueNotifier<DateTime?> dateOfBirth;
  final ValueNotifier<bool> isExpanded;

  void dispose() {
    nameController.dispose();
    colorController.dispose();
    speciesId.dispose();
    breedId.dispose();
    sex.dispose();
    dateOfBirth.dispose();
    isExpanded.dispose();
  }

  bool get isValid => nameController.text.trim().isNotEmpty;

  Patient toPatient({
    required String owner,
    required String phone,
    String? email,
    String? address,
    String? branch,
  }) {
    return Patient(
      id: '',
      name: nameController.text.trim(),
      speciesId: speciesId.value,
      breedId: breedId.value,
      owner: owner,
      contactNumber: phone,
      email: email,
      address: address,
      color: colorController.text.trim().isEmpty
          ? null
          : colorController.text.trim(),
      sex: sex.value,
      dateOfBirth: dateOfBirth.value,
      branch: branch,
    );
  }
}

/// Multi-step wizard for creating multiple patients with the same owner.
///
/// Steps:
/// 0 - Owner Information (shared across all patients)
/// 1 - Patient Entries (dynamic list)
/// 2 - Confirmation Review
class CreateMultiplePatientsDialog extends HookConsumerWidget {
  const CreateMultiplePatientsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);

    // Step management
    final currentStep = useState(0);
    final isSaving = useState(false);

    // Owner form key and state
    final ownerFormKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: ownerFormKey);
    final ownerName = useState('');
    final ownerPhone = useState('');
    final ownerEmail = useState<String?>(null);
    final ownerAddress = useState<String?>(null);

    // Patient entries
    final entries = useState<List<_PatientEntry>>([_PatientEntry()]);

    // Watch species for display in confirmation
    final speciesAsync = ref.watch(speciesProvider);

    // Dispose entries on unmount
    useEffect(() {
      return () {
        for (final entry in entries.value) {
          entry.dispose();
        }
      };
    }, []);

    void addEntry() {
      entries.value = [...entries.value, _PatientEntry()];
    }

    void removeEntry(int index) {
      if (entries.value.length <= 1) return;
      final entry = entries.value[index];
      final newList = [...entries.value]..removeAt(index);
      entry.dispose();
      entries.value = newList;
    }

    bool validateOwnerStep() {
      if (!ownerFormKey.currentState!.saveAndValidate()) {
        final errors = ownerFormKey.currentState?.errors ?? {};
        final errorMessages = formatFormErrors(errors, _ownerFieldLabels);
        if (errorMessages.isNotEmpty) {
          showFormErrorDialog(context, errors: errorMessages);
        }
        return false;
      }

      final values = ownerFormKey.currentState!.value;
      ownerName.value = (values['owner'] as String).trim();
      ownerPhone.value = (values['contactNumber'] as String).trim();
      ownerEmail.value = _nullIfEmpty(values['email'] as String?);
      ownerAddress.value = _nullIfEmpty(values['address'] as String?);
      return true;
    }

    bool validatePatientsStep() {
      final validEntries = entries.value.where((e) => e.isValid).toList();
      if (validEntries.isEmpty) {
        showFormErrorDialog(
          context,
          errors: ['Add at least one patient with a name'],
        );
        return false;
      }

      // Check for entries with data but no name
      final invalidEntries = entries.value.where((e) {
        final hasData = e.colorController.text.trim().isNotEmpty ||
            e.speciesId.value != null ||
            e.breedId.value != null ||
            e.sex.value != null ||
            e.dateOfBirth.value != null;
        return hasData && !e.isValid;
      }).toList();

      if (invalidEntries.isNotEmpty) {
        showFormErrorDialog(
          context,
          errors: ['Some patients are missing a name'],
        );
        return false;
      }

      return true;
    }

    void goToStep(int step) {
      if (step == 1 && currentStep.value == 0) {
        if (!validateOwnerStep()) return;
      }
      if (step == 2 && currentStep.value == 1) {
        if (!validatePatientsStep()) return;
      }
      currentStep.value = step;
    }

    Future<void> handleSubmit() async {
      isSaving.value = true;

      final currentUser = ref.read(currentAuthProvider);
      final branch = currentUser?.user.branch;

      final validEntries = entries.value.where((e) => e.isValid).toList();
      int successCount = 0;
      int failCount = 0;
      Patient? firstCreatedPatient;

      for (final entry in validEntries) {
        final patient = entry.toPatient(
          owner: ownerName.value,
          phone: ownerPhone.value,
          email: ownerEmail.value,
          address: ownerAddress.value,
          branch: branch,
        );

        final success = await ref
            .read(patientsControllerProvider.notifier)
            .createPatient(patient);

        if (success) {
          successCount++;
          if (firstCreatedPatient == null) {
            final patients = ref.read(patientsControllerProvider).value;
            firstCreatedPatient = patients?.firstOrNull;
          }
        } else {
          failCount++;
        }
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        if (failCount == 0) {
          showSuccessSnackBar(
            context,
            message:
                '$successCount patient${successCount > 1 ? 's' : ''} created',
          );
        } else {
          showErrorSnackBar(
            context,
            message: '$successCount created, $failCount failed',
          );
        }

        if (firstCreatedPatient != null) {
          PatientDetailRoute(id: firstCreatedPatient.id).go(context);
        }
      }
    }

    final size = MediaQuery.sizeOf(context);

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
                        'Add Multiple Patients',
                        style: Theme.of(context).textTheme.titleLarge,
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
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Step indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _StepIndicator(
                currentStep: currentStep.value,
                onStepTap: (step) {
                  if (step < currentStep.value) {
                    currentStep.value = step;
                  }
                },
              ),
            ),
            const SizedBox(height: 16),

            // Step content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: IndexedStack(
                  index: currentStep.value,
                  children: [
                    // Step 0: Owner Information
                    _OwnerStep(
                      formKey: ownerFormKey,
                      isSaving: isSaving.value,
                      initialOwner: ownerName.value,
                      initialPhone: ownerPhone.value,
                      initialEmail: ownerEmail.value,
                      initialAddress: ownerAddress.value,
                    ),

                    // Step 1: Patient Entries
                    _PatientsStep(
                      entries: entries.value,
                      onAddEntry: addEntry,
                      onRemoveEntry: removeEntry,
                      isSaving: isSaving.value,
                    ),

                    // Step 2: Confirmation
                    _ConfirmationStep(
                      ownerName: ownerName.value,
                      ownerPhone: ownerPhone.value,
                      ownerEmail: ownerEmail.value,
                      ownerAddress: ownerAddress.value,
                      entries: entries.value.where((e) => e.isValid).toList(),
                      speciesAsync: speciesAsync,
                      onEditOwner: () => currentStep.value = 0,
                      onEditPatients: () => currentStep.value = 1,
                    ),
                  ],
                ),
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                children: [
                  if (currentStep.value > 0)
                    OutlinedButton(
                      onPressed: isSaving.value
                          ? null
                          : () => currentStep.value = currentStep.value - 1,
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  if (currentStep.value < 2)
                    FilledButton(
                      onPressed: isSaving.value
                          ? null
                          : () => goToStep(currentStep.value + 1),
                      child: const Text('Next'),
                    ),
                  if (currentStep.value == 2)
                    FilledButton(
                      onPressed: isSaving.value ? null : handleSubmit,
                      child: isSaving.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Create All'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  static String? _nullIfEmpty(String? text) {
    if (text == null) return null;
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static const _ownerFieldLabels = {
    'owner': 'Owner Name',
    'contactNumber': 'Phone',
    'email': 'Email',
    'address': 'Address',
  };
}

/// Step indicator showing progress through the wizard.
class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.currentStep,
    required this.onStepTap,
  });

  final int currentStep;
  final ValueChanged<int> onStepTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildStep(int index, String label, IconData icon) {
      final isActive = currentStep == index;
      final isComplete = currentStep > index;
      final color = isActive || isComplete
          ? theme.colorScheme.primary
          : theme.colorScheme.outlineVariant;

      return Expanded(
        child: GestureDetector(
          onTap: () => onStepTap(index),
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive || isComplete
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(
                  isComplete ? Icons.check : icon,
                  size: 16,
                  color: isActive || isComplete
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildConnector(bool isComplete) {
      final theme = Theme.of(context);
      return Container(
        height: 2,
        width: 24,
        color: isComplete
            ? theme.colorScheme.primary
            : theme.colorScheme.outlineVariant,
      );
    }

    return Row(
      children: [
        buildStep(0, 'Owner', Icons.person),
        buildConnector(currentStep > 0),
        buildStep(1, 'Patients', Icons.pets),
        buildConnector(currentStep > 1),
        buildStep(2, 'Review', Icons.check_circle),
      ],
    );
  }
}

/// Step 0: Owner Information form.
class _OwnerStep extends StatelessWidget {
  const _OwnerStep({
    required this.formKey,
    required this.isSaving,
    this.initialOwner,
    this.initialPhone,
    this.initialEmail,
    this.initialAddress,
  });

  final GlobalKey<FormBuilderState> formKey;
  final bool isSaving;
  final String? initialOwner;
  final String? initialPhone;
  final String? initialEmail;
  final String? initialAddress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Owner Information',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This information will be shared across all patients.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FormBuilderTextField(
            name: 'owner',
            initialValue: initialOwner,
            decoration: const InputDecoration(
              labelText: 'Owner Name *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            enabled: !isSaving,
            textCapitalization: TextCapitalization.words,
            validator: FormBuilderValidators.required(
              errorText: 'Owner name is required',
            ),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'contactNumber',
            initialValue: initialPhone,
            decoration: const InputDecoration(
              labelText: 'Phone *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
            enabled: !isSaving,
            keyboardType: TextInputType.phone,
            validator: FormBuilderValidators.required(
              errorText: 'Phone number is required',
            ),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'email',
            initialValue: initialEmail,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            enabled: !isSaving,
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
            initialValue: initialAddress,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            enabled: !isSaving,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

/// Step 1: Patient entries list.
class _PatientsStep extends HookConsumerWidget {
  const _PatientsStep({
    required this.entries,
    required this.onAddEntry,
    required this.onRemoveEntry,
    required this.isSaving,
  });

  final List<_PatientEntry> entries;
  final VoidCallback onAddEntry;
  final void Function(int index) onRemoveEntry;
  final bool isSaving;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final validCount = entries.where((e) => e.isValid).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.pets, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Patients',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            if (validCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$validCount',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Add details for each patient. Only name is required.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        ...entries.asMap().entries.map((mapEntry) {
          final index = mapEntry.key;
          final entry = mapEntry.value;
          return _PatientEntryCard(
            key: ValueKey(entry),
            index: index,
            entry: entry,
            canRemove: entries.length > 1,
            onRemove: () => onRemoveEntry(index),
            isSaving: isSaving,
          );
        }),
        const SizedBox(height: 16),
        Center(
          child: OutlinedButton.icon(
            onPressed: isSaving ? null : onAddEntry,
            icon: const Icon(Icons.add),
            label: const Text('Add another patient'),
          ),
        ),
      ],
    );
  }
}

/// Individual patient entry card.
class _PatientEntryCard extends HookConsumerWidget {
  const _PatientEntryCard({
    super.key,
    required this.index,
    required this.entry,
    required this.canRemove,
    required this.onRemove,
    required this.isSaving,
  });

  final int index;
  final _PatientEntry entry;
  final bool canRemove;
  final VoidCallback onRemove;
  final bool isSaving;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final isExpanded = useValueListenable(entry.isExpanded);
    final speciesId = useValueListenable(entry.speciesId);
    final breedId = useValueListenable(entry.breedId);
    final sex = useValueListenable(entry.sex);
    final dateOfBirth = useValueListenable(entry.dateOfBirth);

    final speciesAsync = ref.watch(speciesProvider);
    final breedsAsync = ref.watch(breedsBySpeciesProvider(speciesId));

    // Force rebuild when text changes
    useListenable(entry.nameController);
    useListenable(entry.colorController);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: entry.isValid
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: entry.isValid
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: entry.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Pet Name *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    enabled: !isSaving,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                if (canRemove)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: isSaving ? null : onRemove,
                    iconSize: 20,
                  ),
              ],
            ),
          ),

          // Toggle more details
          InkWell(
            onTap: () => entry.isExpanded.value = !isExpanded,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isExpanded ? 'Hide details' : 'More details',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),

          // Expanded content
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                children: [
                  // Species & Breed
                  Row(
                    children: [
                      Expanded(
                        child: speciesAsync.when(
                          data: (speciesList) =>
                              DropdownButtonFormField<String>(
                            value: speciesId,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Species',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text('Select...'),
                              ),
                              ...speciesList.map((s) => DropdownMenuItem(
                                    value: s.id,
                                    child: Text(s.name),
                                  )),
                            ],
                            onChanged: isSaving
                                ? null
                                : (value) {
                                    entry.speciesId.value = value;
                                    entry.breedId.value = null;
                                  },
                          ),
                          loading: () => const TextField(
                            decoration: InputDecoration(
                              labelText: 'Species',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            enabled: false,
                          ),
                          error: (_, __) => const TextField(
                            decoration: InputDecoration(
                              labelText: 'Species',
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorText: 'Failed to load',
                            ),
                            enabled: false,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: breedsAsync.when(
                          data: (breedsList) => DropdownButtonFormField<String>(
                            value: breedId,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Breed',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text('Select...'),
                              ),
                              ...breedsList.map((b) => DropdownMenuItem(
                                    value: b.id,
                                    child: Text(b.name),
                                  )),
                            ],
                            onChanged: isSaving || speciesId == null
                                ? null
                                : (value) => entry.breedId.value = value,
                          ),
                          loading: () => const TextField(
                            decoration: InputDecoration(
                              labelText: 'Breed',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            enabled: false,
                          ),
                          error: (_, __) => const TextField(
                            decoration: InputDecoration(
                              labelText: 'Breed',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Sex selection
                  Row(
                    children: [
                      Text(
                        'Sex:',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 16),
                      ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.male, size: 16),
                            const SizedBox(width: 4),
                            const Text('Male'),
                          ],
                        ),
                        selected: sex == PatientSex.male,
                        showCheckmark: true,
                        onSelected: isSaving
                            ? null
                            : (selected) {
                                entry.sex.value =
                                    selected ? PatientSex.male : null;
                              },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.female, size: 16),
                            const SizedBox(width: 4),
                            const Text('Female'),
                          ],
                        ),
                        selected: sex == PatientSex.female,
                        showCheckmark: true,
                        onSelected: isSaving
                            ? null
                            : (selected) {
                                entry.sex.value =
                                    selected ? PatientSex.female : null;
                              },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Color & Date of Birth
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: entry.colorController,
                          decoration: const InputDecoration(
                            labelText: 'Color/Markings',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          enabled: !isSaving,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: isSaving
                              ? null
                              : () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: dateOfBirth ?? DateTime.now(),
                                    firstDate: DateTime(1990),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    entry.dateOfBirth.value = picked;
                                  }
                                },
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Date of Birth',
                              border: OutlineInputBorder(),
                              isDense: true,
                              suffixIcon: Icon(Icons.calendar_today, size: 18),
                            ),
                            child: Text(
                              dateOfBirth != null
                                  ? DateFormat.yMMMd().format(dateOfBirth)
                                  : 'Select...',
                              style: dateOfBirth == null
                                  ? theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Step 2: Confirmation review.
class _ConfirmationStep extends HookConsumerWidget {
  const _ConfirmationStep({
    required this.ownerName,
    required this.ownerPhone,
    this.ownerEmail,
    this.ownerAddress,
    required this.entries,
    required this.speciesAsync,
    required this.onEditOwner,
    required this.onEditPatients,
  });

  final String ownerName;
  final String ownerPhone;
  final String? ownerEmail;
  final String? ownerAddress;
  final List<_PatientEntry> entries;
  final AsyncValue<List<dynamic>> speciesAsync;
  final VoidCallback onEditOwner;
  final VoidCallback onEditPatients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle,
                size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Review & Confirm',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Please review the information before creating the patients.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),

        // Owner info card
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Owner Information',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: onEditOwner,
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InfoRow(icon: Icons.person, text: ownerName),
              const SizedBox(height: 8),
              _InfoRow(icon: Icons.phone, text: ownerPhone),
              if (ownerEmail != null && ownerEmail!.isNotEmpty) ...[
                const SizedBox(height: 8),
                _InfoRow(icon: Icons.email, text: ownerEmail!),
              ],
              if (ownerAddress != null && ownerAddress!.isNotEmpty) ...[
                const SizedBox(height: 8),
                _InfoRow(icon: Icons.location_on, text: ownerAddress!),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Patients section
        Row(
          children: [
            Icon(Icons.pets, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Patients (${entries.length})',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onEditPatients,
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Edit'),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...entries.map((entry) {
          return _PatientReviewCard(entry: entry, speciesAsync: speciesAsync);
        }),
      ],
    );
  }
}

/// Info row for confirmation display.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

/// Patient review card for confirmation step.
class _PatientReviewCard extends HookConsumerWidget {
  const _PatientReviewCard({
    required this.entry,
    required this.speciesAsync,
  });

  final _PatientEntry entry;
  final AsyncValue<List<dynamic>> speciesAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Watch for species/breed names
    final speciesId = useValueListenable(entry.speciesId);
    final breedId = useValueListenable(entry.breedId);
    final sex = useValueListenable(entry.sex);
    final dateOfBirth = useValueListenable(entry.dateOfBirth);

    String? speciesName;
    if (speciesId != null) {
      speciesAsync.whenData((list) {
        final species = list.cast<dynamic>().firstWhere(
              (s) => s.id == speciesId,
              orElse: () => null,
            );
        if (species != null) {
          speciesName = species.name as String?;
        }
      });
    }

    String? breedName;
    if (breedId != null && speciesId != null) {
      final breedsAsync = ref.watch(breedsBySpeciesProvider(speciesId));
      breedsAsync.whenData((list) {
        for (final breed in list) {
          if (breed.id == breedId) {
            breedName = breed.name;
            break;
          }
        }
      });
    }

    final details = <String>[];
    if (speciesName != null) details.add(speciesName!);
    if (breedName != null) details.add(breedName!);
    if (sex != null) details.add(sex == PatientSex.male ? 'Male' : 'Female');

    final secondaryDetails = <String>[];
    if (entry.colorController.text.trim().isNotEmpty) {
      secondaryDetails.add(entry.colorController.text.trim());
    }
    if (dateOfBirth != null) {
      secondaryDetails.add('Born: ${DateFormat.yMMMd().format(dateOfBirth)}');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pets,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.nameController.text,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              details.join(' • '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (secondaryDetails.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              secondaryDetails.join(' • '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Shows the create multiple patients dialog.
void showCreateMultiplePatientsDialog(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => const Dialog(
      insetPadding: EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: CreateMultiplePatientsDialog(),
    ),
  );
}
