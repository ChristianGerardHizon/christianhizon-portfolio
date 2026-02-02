import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../data/repositories/service_category_repository.dart';
import '../../domain/service_category.dart';
import '../controllers/service_categories_provider.dart';

/// Shows a bottom sheet form for creating or editing a service category.
///
/// Returns `true` if the category was saved successfully.
Future<bool?> showServiceCategoryFormSheet(
  BuildContext context, {
  ServiceCategory? category,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _ServiceCategoryFormSheet(category: category),
  );
}

class _ServiceCategoryFormSheet extends HookConsumerWidget {
  const _ServiceCategoryFormSheet({this.category});

  final ServiceCategory? category;

  bool get isEditing => category != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;
      final repo = ref.read(serviceCategoryRepositoryProvider);

      final categoryData = ServiceCategory(
        id: category?.id ?? '',
        name: values['name'] as String,
      );

      final result = isEditing
          ? await repo.update(categoryData)
          : await repo.create(categoryData);

      isSaving.value = false;

      result.fold(
        (failure) {
          if (context.mounted) {
            showErrorSnackBar(
              context,
              message: isEditing
                  ? 'Failed to update category'
                  : 'Failed to create category',
            );
          }
        },
        (_) {
          ref.invalidate(serviceCategoriesProvider);
          if (context.mounted) {
            showSuccessSnackBar(
              context,
              message:
                  isEditing ? 'Category updated' : 'Category created',
            );
            Navigator.of(context).pop(true);
          }
        },
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  isEditing ? 'Edit Category' : 'New Category',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
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
          const SizedBox(height: 16),
          FormBuilder(
            key: formKey,
            child: FormBuilderTextField(
              name: 'name',
              initialValue: category?.name,
              decoration: const InputDecoration(
                labelText: 'Category Name *',
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.required(),
              autofocus: true,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
