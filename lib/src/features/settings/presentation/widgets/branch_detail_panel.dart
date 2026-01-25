import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/organization.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../domain/branch.dart';
import '../controllers/branches_controller.dart';

/// Detail panel for viewing/editing a branch in tablet layout.
class BranchDetailPanel extends HookConsumerWidget {
  const BranchDetailPanel({
    super.key,
    required this.branchId,
  });

  final String branchId;

  bool get isCreating => branchId == 'new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final branchesAsync = ref.watch(branchesControllerProvider);

    // Find the branch from the list
    final branches = branchesAsync.value;
    final branch = branches?.cast<Branch?>().firstWhere(
      (b) => b?.id == branchId,
      orElse: () => null,
    );

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final isDeleting = useState(false);

    // Reset form when branch changes
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.patchValue({
          'name': branch?.name ?? '',
          'displayName': branch?.displayName ?? '',
          'address': branch?.address ?? '',
          'contactNumber': branch?.contactNumber ?? '',
        });
      });
      return null;
    }, [branch?.id]);

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();
      if (!isValid) return;

      final values = formKey.currentState!.value;
      isSaving.value = true;

      final branchData = Branch(
        id: isCreating ? '' : branchId,
        name: (values['name'] as String).trim(),
        displayName: _nullIfEmpty(values['displayName'] as String?),
        address: (values['address'] as String).trim(),
        contactNumber: (values['contactNumber'] as String).trim(),
      );

      bool success;
      if (isCreating) {
        success = await ref
            .read(branchesControllerProvider.notifier)
            .createBranch(branchData);
      } else {
        success = await ref
            .read(branchesControllerProvider.notifier)
            .updateBranch(branchData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save branch. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        showSuccessSnackBar(
          context,
          message: isCreating
              ? 'Branch created successfully'
              : 'Branch updated successfully',
        );

        if (isCreating) {
          // Navigate back to branches list
          const OrganizationBranchesRoute().go(context);
        }
      }
    }

    Future<void> handleDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Branch'),
          content: Text('Are you sure you want to delete "${branch?.name}"?'),
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
          .read(branchesControllerProvider.notifier)
          .deleteBranch(branchId);

      if (context.mounted) {
        isDeleting.value = false;
        if (success) {
          showSuccessSnackBar(context, message: 'Branch deleted successfully');
          const OrganizationBranchesRoute().go(context);
        } else {
          showFormErrorDialog(
            context,
            errors: ['Failed to delete branch. Please try again.'],
          );
        }
      }
    }

    if (!isCreating && branchesAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isCreating && branch == null) {
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
              'Branch not found',
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
        title: Text(isCreating ? 'New Branch' : 'Edit Branch'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => const OrganizationBranchesRoute().go(context),
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
                initialValue: isCreating ? '' : branch?.name,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter branch name (internal)',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Display Name field
              FormBuilderTextField(
                name: 'displayName',
                initialValue: isCreating ? '' : branch?.displayName,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  hintText: 'Enter formal business name for documents',
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Address field
              FormBuilderTextField(
                name: 'address',
                initialValue: isCreating ? '' : branch?.address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter address',
                ),
                maxLines: 2,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Contact number field
              FormBuilderTextField(
                name: 'contactNumber',
                initialValue: isCreating ? '' : branch?.contactNumber,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  hintText: 'Enter contact number',
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }
}
