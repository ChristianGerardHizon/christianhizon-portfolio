import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/domain/patient_treatment.dart';
import '../../../patients/presentation/controllers/patient_treatments_controller.dart';

/// Detail panel for viewing/editing a treatment type in tablet layout.
class TreatmentTypeDetailPanel extends HookConsumerWidget {
  const TreatmentTypeDetailPanel({
    super.key,
    required this.treatmentId,
  });

  final String treatmentId;

  bool get isCreating => treatmentId == 'new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final treatmentsAsync = ref.watch(patientTreatmentsControllerProvider);

    // Find the treatment from the list
    final treatmentsList = treatmentsAsync.value;
    final treatment = treatmentsList?.cast<PatientTreatment?>().firstWhere(
      (t) => t?.id == treatmentId,
      orElse: () => null,
    );

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final isDeleting = useState(false);

    // Reset form when treatment changes
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.patchValue({
          'name': treatment?.name ?? '',
        });
      });
      return null;
    }, [treatment?.id]);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();
      if (!isValid) return;

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final treatmentData = PatientTreatment(
        id: isCreating ? '' : treatmentId,
        name: (values['name'] as String).trim(),
      );

      bool success;
      if (isCreating) {
        success = await ref
            .read(patientTreatmentsControllerProvider.notifier)
            .createTreatment(treatmentData);
      } else {
        success = await ref
            .read(patientTreatmentsControllerProvider.notifier)
            .updateTreatment(treatmentData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save treatment type. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        showSuccessSnackBar(
          context,
          message: isCreating
              ? 'Treatment type created successfully'
              : 'Treatment type updated successfully',
        );

        if (isCreating) {
          const TreatmentTypesRoute().go(context);
        }
      }
    }

    Future<void> handleDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Treatment Type'),
          content: Text('Are you sure you want to delete "${treatment?.name}"?'),
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
          .read(patientTreatmentsControllerProvider.notifier)
          .deleteTreatment(treatmentId);

      if (context.mounted) {
        isDeleting.value = false;
        if (success) {
          showSuccessSnackBar(context, message: 'Treatment type deleted successfully');
          const TreatmentTypesRoute().go(context);
        } else {
          showFormErrorDialog(
            context,
            errors: ['Failed to delete treatment type. Please try again.'],
          );
        }
      }
    }

    if (!isCreating && treatmentsAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isCreating && treatment == null) {
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
              'Treatment type not found',
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
        title: Text(isCreating ? 'New Treatment Type' : 'Edit Treatment Type'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => const TreatmentTypesRoute().go(context),
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
                initialValue: isCreating ? '' : treatment?.name,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter treatment type name (e.g., Vaccination, Deworming)',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.done,
                autofocus: isCreating,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
