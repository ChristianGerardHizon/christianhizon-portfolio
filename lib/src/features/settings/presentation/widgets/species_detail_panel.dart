import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/domain/patient_breed.dart';
import '../../../patients/domain/patient_species.dart';
import '../controllers/breeds_controller.dart';
import '../controllers/species_controller.dart';

/// Detail panel for viewing/editing a species in tablet layout.
class SpeciesDetailPanel extends HookConsumerWidget {
  const SpeciesDetailPanel({
    super.key,
    required this.speciesId,
  });

  final String speciesId;

  bool get isCreating => speciesId == 'new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final speciesAsync = ref.watch(speciesControllerProvider);

    // Find the species from the list
    final speciesList = speciesAsync.value;
    final species = speciesList?.cast<PatientSpecies?>().firstWhere(
      (s) => s?.id == speciesId,
      orElse: () => null,
    );

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final isDeleting = useState(false);

    // Reset form when species changes
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.patchValue({
          'name': species?.name ?? '',
        });
      });
      return null;
    }, [species?.id]);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();
      if (!isValid) return;

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final speciesData = PatientSpecies(
        id: isCreating ? '' : speciesId,
        name: (values['name'] as String).trim(),
      );

      bool success;
      if (isCreating) {
        success = await ref
            .read(speciesControllerProvider.notifier)
            .createSpecies(speciesData);
      } else {
        success = await ref
            .read(speciesControllerProvider.notifier)
            .updateSpecies(speciesData);
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
        showSuccessSnackBar(
          context,
          message: isCreating
              ? 'Species created successfully'
              : 'Species updated successfully',
        );

        if (isCreating) {
          const SpeciesRoute().go(context);
        }
      }
    }

    Future<void> handleDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Species'),
          content: Text('Are you sure you want to delete "${species?.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      isDeleting.value = true;
      final success = await ref
          .read(speciesControllerProvider.notifier)
          .deleteSpecies(speciesId);

      if (context.mounted) {
        isDeleting.value = false;
        if (success) {
          showSuccessSnackBar(context, message: 'Species deleted successfully');
          const SpeciesRoute().go(context);
        } else {
          showFormErrorDialog(
            context,
            errors: ['Failed to delete species. Please try again.'],
          );
        }
      }
    }

    if (!isCreating && speciesAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isCreating && species == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Species not found',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isCreating ? 'New Species' : 'Edit Species'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => const SpeciesRoute().go(context),
        ),
        actions: [
          if (!isCreating)
            IconButton(
              icon: isDeleting.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              onPressed: isDeleting.value ? null : handleDelete,
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
          const SizedBox(width: 16),
        ],
      ),
      body: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name field
              FormBuilderTextField(
                name: 'name',
                initialValue: isCreating ? '' : species?.name,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter species name (e.g., Dog, Cat)',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.done,
                autofocus: isCreating,
              ),

              // Breeds section (only for existing species)
              if (!isCreating) ...[
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                _BreedsSection(speciesId: speciesId),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Section displaying breeds for a species with add/edit/delete functionality.
class _BreedsSection extends ConsumerWidget {
  const _BreedsSection({required this.speciesId});

  final String speciesId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final breedsAsync = ref.watch(breedsControllerProvider);

    // Filter breeds by species
    final breeds = breedsAsync.value
            ?.where((b) => b.speciesId == speciesId)
            .toList() ??
        [];

    Future<void> showBreedDialog({PatientBreed? breed}) async {
      final result = await showDialog<PatientBreed>(
        context: context,
        builder: (context) => _BreedFormDialog(
          speciesId: speciesId,
          breed: breed,
        ),
      );

      if (result != null && context.mounted) {
        bool success;
        if (breed == null) {
          // Creating new breed
          success = await ref
              .read(breedsControllerProvider.notifier)
              .createBreed(result);
        } else {
          // Updating existing breed
          success = await ref
              .read(breedsControllerProvider.notifier)
              .updateBreed(result);
        }

        if (context.mounted) {
          if (success) {
            showSuccessSnackBar(
              context,
              message: breed == null
                  ? 'Breed created successfully'
                  : 'Breed updated successfully',
            );
          } else {
            showFormErrorDialog(
              context,
              errors: ['Failed to save breed. Please try again.'],
            );
          }
        }
      }
    }

    Future<void> handleDeleteBreed(PatientBreed breed) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Breed'),
          content: Text('Are you sure you want to delete "${breed.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      final success = await ref
          .read(breedsControllerProvider.notifier)
          .deleteBreed(breed.id);

      if (context.mounted) {
        if (success) {
          showSuccessSnackBar(context, message: 'Breed deleted successfully');
        } else {
          showFormErrorDialog(
            context,
            errors: ['Failed to delete breed. Please try again.'],
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header with add button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Breeds',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: () => showBreedDialog(),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Breeds list or empty state
        if (breedsAsync.isLoading)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (breeds.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 48,
                  color: theme.colorScheme.outline.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  'No breeds yet',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Add breeds for this species',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          )
        else
          Card(
            margin: EdgeInsets.zero,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: breeds.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final breed = breeds[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.category_outlined,
                      size: 20,
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                  title: Text(breed.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => showBreedDialog(breed: breed),
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => handleDeleteBreed(breed),
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

/// Dialog for creating or editing a breed.
class _BreedFormDialog extends HookWidget {
  const _BreedFormDialog({
    required this.speciesId,
    this.breed,
  });

  final String speciesId;
  final PatientBreed? breed;

  bool get isEditing => breed != null;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    void handleSave() {
      if (!formKey.currentState!.saveAndValidate()) return;

      final values = formKey.currentState!.value;
      final name = (values['name'] as String).trim();

      final result = PatientBreed(
        id: isEditing ? breed!.id : '',
        name: name,
        speciesId: speciesId,
      );

      Navigator.of(context).pop(result);
    }

    return AlertDialog(
      title: Text(isEditing ? 'Edit Breed' : 'Add Breed'),
      content: FormBuilder(
        key: formKey,
        child: SizedBox(
          width: 300,
          child: FormBuilderTextField(
            name: 'name',
            initialValue: breed?.name ?? '',
            decoration: const InputDecoration(
              labelText: 'Breed Name *',
              hintText: 'e.g., Labrador, Persian',
            ),
            validator: FormBuilderValidators.required(),
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => handleSave(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: isSaving.value ? null : handleSave,
          child: Text(isEditing ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
