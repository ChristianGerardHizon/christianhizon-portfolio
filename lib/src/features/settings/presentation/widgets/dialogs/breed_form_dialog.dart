import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/domain/patient_breed.dart';
import '../../../../patients/presentation/controllers/species_breeds_provider.dart';
import '../../controllers/breeds_controller.dart';

/// Dialog for creating or editing a breed.
class BreedFormDialog extends HookConsumerWidget {
  const BreedFormDialog({
    super.key,
    this.breed,
  });

  final PatientBreed? breed;

  bool get isEditing => breed != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final speciesAsync = ref.watch(speciesProvider);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: isEditing
          ? {'name': breed!.name, 'species': breed!.speciesId}
          : null,
    );

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

    return PopScope(
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
                      isEditing ? 'Edit Breed' : 'New Breed',
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
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
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

                      // Species dropdown
                      speciesAsync.when(
                        loading: () => FormBuilderTextField(
                          name: 'species',
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Species *',
                            hintText: 'Loading...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        error: (_, __) => FormBuilderTextField(
                          name: 'species',
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Species *',
                            hintText: 'Error loading species',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        data: (speciesList) => FormBuilderDropdown<String>(
                          name: 'species',
                          initialValue: breed?.speciesId,
                          decoration: const InputDecoration(
                            labelText: 'Species *',
                            border: OutlineInputBorder(),
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
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.required(),
                        textInputAction: TextInputAction.done,
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
    );
  }
}

/// Shows the breed form dialog.
void showBreedFormDialog(BuildContext context, {PatientBreed? breed}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: BreedFormDialog(breed: breed),
    ),
  );
}
