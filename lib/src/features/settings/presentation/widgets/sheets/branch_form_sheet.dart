import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/branch.dart';
import '../../controllers/branches_controller.dart';

/// Bottom sheet for creating or editing a branch.
class BranchFormSheet extends HookConsumerWidget {
  const BranchFormSheet({
    super.key,
    this.branch,
    this.scrollController,
  });

  final Branch? branch;
  final ScrollController? scrollController;

  bool get isEditing => branch != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

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

      final branchData = Branch(
        id: branch?.id ?? '',
        name: (values['name'] as String).trim(),
        address: (values['address'] as String).trim(),
        contactNumber: (values['contactNumber'] as String).trim(),
        displayName: _nullIfEmpty(values['displayName'] as String?),
      );

      bool success;
      if (isEditing) {
        success = await ref
            .read(branchesControllerProvider.notifier)
            .updateBranch(branchData);
      } else {
        success = await ref
            .read(branchesControllerProvider.notifier)
            .createBranch(branchData);
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
        context.pop();

        showSuccessSnackBar(
          context,
          message: isEditing
              ? 'Branch updated successfully'
              : 'Branch created successfully',
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
                      isEditing ? 'Edit Branch' : 'New Branch',
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

              // Name field
              FormBuilderTextField(
                name: 'name',
                initialValue: branch?.name,
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
                initialValue: branch?.displayName,
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
                initialValue: branch?.address,
                decoration: const InputDecoration(
                  labelText: 'Address *',
                  hintText: 'Enter address',
                ),
                maxLines: 2,
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Contact number field
              FormBuilderTextField(
                name: 'contactNumber',
                initialValue: branch?.contactNumber,
                decoration: const InputDecoration(
                  labelText: 'Contact Number *',
                  hintText: 'Enter contact number',
                ),
                keyboardType: TextInputType.phone,
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

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }
}
