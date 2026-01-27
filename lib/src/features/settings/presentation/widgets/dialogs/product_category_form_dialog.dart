import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../products/domain/product_category.dart';
import '../../controllers/product_categories_controller.dart';

/// Dialog for creating or editing a product category.
class ProductCategoryFormDialog extends HookConsumerWidget {
  const ProductCategoryFormDialog({
    super.key,
    this.category,
  });

  final ProductCategory? category;

  bool get isEditing => category != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
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

    return DialogCloseHandler(
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
                  onPressed: isSaving.value ? null : () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    isEditing ? 'Edit Category' : 'New Category',
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
                      initialValue: category?.name,
                      decoration: const InputDecoration(
                        labelText: 'Name *',
                        hintText: 'Enter category name',
                        border: OutlineInputBorder(),
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
                          border: OutlineInputBorder(),
                        ),
                      ),
                      error: (_, __) => FormBuilderTextField(
                        name: 'parent',
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Parent Category',
                          hintText: 'Error loading categories',
                          border: OutlineInputBorder(),
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
                            border: OutlineInputBorder(),
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
          ),
        ],
      ),
      ),
    );
  }
}

/// Shows the product category form dialog.
void showProductCategoryFormDialog(
  BuildContext context, {
  ProductCategory? category,
}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: ProductCategoryFormDialog(category: category),
    ),
  );
}
