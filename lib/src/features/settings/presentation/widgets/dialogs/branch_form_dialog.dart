import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/branch.dart';
import '../../controllers/branches_controller.dart';

/// Dialog for creating or editing a branch.
class BranchFormDialog extends HookConsumerWidget {
  const BranchFormDialog({
    super.key,
    this.branch,
  });

  final Branch? branch;

  bool get isEditing => branch != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

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

    return SizedBox(
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
                  onPressed: isSaving.value ? null : () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    isEditing ? 'Edit Branch' : 'New Branch',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: isSaving.value ? null : () => context.pop(),
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
                      initialValue: branch?.name,
                      decoration: const InputDecoration(
                        labelText: 'Name *',
                        hintText: 'Enter branch name (internal)',
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
          ),
        ],
      ),
    );
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }
}

/// Shows the branch form dialog.
void showBranchFormDialog(BuildContext context, {Branch? branch}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: BranchFormDialog(branch: branch),
    ),
  );
}
