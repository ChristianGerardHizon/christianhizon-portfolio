import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/domain/patient_species.dart';
import '../../controllers/species_controller.dart';

/// Dialog for creating or editing a species.
class SpeciesFormDialog extends HookConsumerWidget {
  const SpeciesFormDialog({
    super.key,
    this.species,
  });

  final PatientSpecies? species;

  bool get isEditing => species != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: isEditing ? {'name': species!.name} : null,
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

      final speciesData = PatientSpecies(
        id: species?.id ?? '',
        name: (values['name'] as String).trim(),
      );

      bool success;
      if (isEditing) {
        success = await ref
            .read(speciesControllerProvider.notifier)
            .updateSpecies(speciesData);
      } else {
        success = await ref
            .read(speciesControllerProvider.notifier)
            .createSpecies(speciesData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save species. Please try again.'],
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
              ? 'Species updated successfully'
              : 'Species created successfully',
        );
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
                      isEditing ? 'Edit Species' : 'New Species',
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

                      // Name field
                      FormBuilderTextField(
                        name: 'name',
                        initialValue: species?.name,
                        decoration: const InputDecoration(
                          labelText: 'Name *',
                          hintText: 'Enter species name (e.g., Dog, Cat)',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.required(),
                        textInputAction: TextInputAction.done,
                        autofocus: true,
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

/// Shows the species form dialog.
void showSpeciesFormDialog(BuildContext context, {PatientSpecies? species}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: SpeciesFormDialog(species: species),
    ),
  );
}
