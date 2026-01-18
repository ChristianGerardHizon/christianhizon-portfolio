import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/domain/patient_breed.dart';
import '../../../../patients/presentation/controllers/species_breeds_provider.dart';
import '../../controllers/breeds_controller.dart';

/// Bottom sheet for creating or editing a breed.
class BreedFormSheet extends HookConsumerWidget {
  const BreedFormSheet({
    super.key,
    this.breed,
    this.scrollController,
  });

  final PatientBreed? breed;
  final ScrollController? scrollController;

  bool get isEditing => breed != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final speciesAsync = ref.watch(speciesProvider);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      if (!isValid) {
        return;
      }

      final values = formKey.currentState!.value;

      isSaving.value = true;

      final breedData = PatientBreed(
        id: breed?.id ?? '',
        name: (values['name'] as String).trim(),
        speciesId: values['species'] as String,
      );

      bool success;
      if (isEditing) {
        success = await ref
            .read(breedsControllerProvider.notifier)
            .updateBreed(breedData);
      } else {
        success = await ref
            .read(breedsControllerProvider.notifier)
            .createBreed(breedData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save breed. Please try again.'],
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
              ? 'Breed updated successfully'
              : 'Breed created successfully',
        );
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
                      isEditing ? 'Edit Breed' : 'New Breed',
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

              // Species dropdown
              speciesAsync.when(
                loading: () => FormBuilderTextField(
                  name: 'species',
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Species *',
                    hintText: 'Loading...',
                  ),
                ),
                error: (_, __) => FormBuilderTextField(
                  name: 'species',
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Species *',
                    hintText: 'Error loading species',
                  ),
                ),
                data: (speciesList) => FormBuilderDropdown<String>(
                  name: 'species',
                  initialValue: breed?.speciesId,
                  decoration: const InputDecoration(
                    labelText: 'Species *',
                  ),
                  validator: FormBuilderValidators.required(),
                  items: speciesList
                      .map((s) => DropdownMenuItem(
                            value: s.id,
                            child: Text(s.name),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Name field
              FormBuilderTextField(
                name: 'name',
                initialValue: breed?.name,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter breed name',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
