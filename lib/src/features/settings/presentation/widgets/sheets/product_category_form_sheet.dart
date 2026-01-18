import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../../products/domain/product_category.dart';
import '../../controllers/product_categories_controller.dart';

/// Bottom sheet for creating or editing a product category.
class ProductCategoryFormSheet extends HookConsumerWidget {
  const ProductCategoryFormSheet({
    super.key,
    this.category,
    this.scrollController,
  });

  final ProductCategory? category;
  final ScrollController? scrollController;

  bool get isEditing => category != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final categoriesAsync = ref.watch(productCategoriesControllerProvider);

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

      final categoryData = ProductCategory(
        id: category?.id ?? '',
        name: (values['name'] as String).trim(),
        parentId: values['parent'] as String?,
      );

      bool success;
      if (isEditing) {
        success = await ref
            .read(productCategoriesControllerProvider.notifier)
            .updateCategory(categoryData);
      } else {
        success = await ref
            .read(productCategoriesControllerProvider.notifier)
            .createCategory(categoryData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save category. Please try again.'],
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
              ? 'Category updated successfully'
              : 'Category created successfully',
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
                      isEditing ? 'Edit Category' : 'New Category',
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
                initialValue: category?.name,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter category name',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.next,
                autofocus: true,
              ),
              const SizedBox(height: 16),

              // Parent category dropdown
              categoriesAsync.when(
                loading: () => FormBuilderTextField(
                  name: 'parent',
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Parent Category',
                    hintText: 'Loading...',
                  ),
                ),
                error: (_, __) => FormBuilderTextField(
                  name: 'parent',
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Parent Category',
                    hintText: 'Error loading categories',
                  ),
                ),
                data: (categories) {
                  // Filter out self and children to prevent circular reference
                  final availableParents = categories.where((c) {
                    if (category == null) return true;
                    // Can't be own parent
                    if (c.id == category!.id) return false;
                    // Can't select own children as parent
                    if (c.parentId == category!.id) return false;
                    return true;
                  }).toList();

                  return FormBuilderDropdown<String?>(
                    name: 'parent',
                    initialValue: category?.parentId,
                    decoration: const InputDecoration(
                      labelText: 'Parent Category',
                      hintText: 'Select parent (optional)',
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('None (Root Category)'),
                      ),
                      ...availableParents.map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name),
                          )),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
