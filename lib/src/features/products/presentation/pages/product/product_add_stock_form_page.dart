import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/product_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/product_form_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/product_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductAddStockFormPage extends HookConsumerWidget {
  const ProductAddStockFormPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(productFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      Product? product,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(productRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (product == null
          ? repository.create(value, files: files)
          : repository.update(product, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(productTableControllerProvider);
          ref.invalidate(productControllerProvider(r.id));

          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final product = formState.product;
            final branches = formState.branches;
            final images = formState.images;
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
                /// Image
                ///
                DynamicPBImagesField(
                  name: ProductField.image,
                  maxFiles: 1,
                  allowCompression: false,
                  maxSizeKB: 300,
                  compressionQuality: 85,
                  previewSize: 200,
                  fieldTransformer: (list) =>
                      PBUtils.defaultFieldTransformer(list, isSingleFile: true),
                  fileTransformer: PBUtils.defaultFileTransformer,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  initialValue: images,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Product Name
                ///
                DynamicTextField(
                  name: ProductField.name,
                  initialValue: product?.name,
                  decoration: InputDecoration(
                    label: Text('Product Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                ///
                /// Description
                ///
                DynamicTextField(
                  name: ProductField.description,
                  initialValue: product?.name,
                  minLines: 2,
                  maxLines: 10,
                  decoration: InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Branch and Category
                ///
                DynamicFieldTwoColumn(
                  contentPadding: EdgeInsets.only(bottom: 8, top: 8),
                  axis: getValueForScreenType(
                    context: context,
                    mobile: Axis.horizontal,
                    tablet: Axis.vertical,
                  ),

                  ///
                  /// Category
                  ///
                  first: DynamicSelectField(
                    name: ProductField.category,
                    options: categories
                        .map(
                          (e) => SelectOption(
                            value: e.id,
                            display: e.name,
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      label: Text('Category'),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///
                  /// Branch
                  ///
                  second: DynamicSelectField(
                    name: ProductField.branch,
                    initialValue: product?.branch ?? branches.first.id,
                    options: branches
                        .map(
                          (e) => SelectOption(
                            value: e.id,
                            display: e.name,
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      label: Text('Branch'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                ),

                /// For Sale
                DynamicCheckboxField(
                  name: ProductField.forSale,
                  initialValue: product?.forSale,
                  title: 'Available For Sale',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    helperText:
                        'If not checked, the product will not be visible in cashier.',
                  ),
                ),

                DynamicFieldGroup(
                  padding: EdgeInsets.only(top: 10),
                  title: Text('Tracking'),
                  fields: [
                    DynamicFieldTwoColumn(
                      axis: getValueForScreenType(
                        context: context,
                        mobile: Axis.horizontal,
                        tablet: Axis.vertical,
                      ),

                      ///
                      /// Stock Threshold
                      ///
                      first: DynamicNumberField(
                        name: ProductField.stockThreshold,
                        initialValue: product?.stockThreshold,
                        decoration: InputDecoration(
                          label: Text('Stock Threshold'),
                          helperText: 'How much stock to notify',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.min(0)
                          ],
                        ),
                      ),

                      ///
                      /// Track By Lot
                      ///
                      second: DynamicCheckboxField(
                        name: ProductField.trackByLot,
                        initialValue: product?.trackByLot,
                        title: 'Track By Lot',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          helperText:
                              'When checked, the product will be tracked by lot',
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
              onSubmit: (result) => onSave(product, result),
            );
          }),
    );
  }
}
