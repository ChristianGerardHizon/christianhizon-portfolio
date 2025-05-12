import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/product_categories/data/product_category_repository.dart';
import 'package:gym_system/src/features/product_categories/domain/product_category.dart';
import 'package:gym_system/src/features/product_categories/presentation/controllers/product_category_controller.dart';
import 'package:gym_system/src/features/product_categories/presentation/controllers/product_category_form_controller.dart';
import 'package:gym_system/src/features/product_categories/presentation/controllers/product_category_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCategoryFormPage extends HookConsumerWidget {
  const ProductCategoryFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(productCategoryFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      ProductCategory? productCategory,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(productCategoryRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (productCategory == null
          ? repository.create(value, files: files)
          : repository.update(productCategory, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(productCategoryTableControllerProvider);
          ref.invalidate(productCategoryControllerProvider(r.id));

          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ProductCategory Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final productCategory = formState.category;
            final categories = formState.categories;

            return DynamicFormBuilder(
              itemPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 0,
              ),
              formKey: formKey,
              isLoading: isLoading.value,
              fields: [
                ///
                /// ProductCategory Name
                ///
                DynamicTextField(
                  name: ProductCategoryField.name,
                  initialValue: productCategory?.name,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                ///
                /// Parent
                ///
                // DynamicSelectField(
                //   name: ProductCategoryField.parent,
                //   options: categories
                //       .map(
                //         (e) => SelectOption(
                //           value: e.id,
                //           display: e.name,
                //         ),
                //       )
                //       .toList(),
                //   decoration: InputDecoration(
                //     label: Text('Category'),
                //     border: OutlineInputBorder(),
                //   ),
                // ),
              ],
              onSubmit: (result) => onSave(productCategory, result),
            );
          }),
    );
  }
}
