import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/product_stock_adjustment/data/product_stock_adjustment_repository.dart';
import 'package:gym_system/src/features/product_stock_adjustment/domain/product_stock_adjustment.dart';
import 'package:gym_system/src/features/product_stock_adjustment/presentation/controllers/product_stock_adjustment_controller.dart';
import 'package:gym_system/src/features/product_stock_adjustment/presentation/controllers/product_stock_adjustment_form_controller.dart';
import 'package:gym_system/src/features/product_stock_adjustment/presentation/controllers/product_stock_adjustment_table_controller.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStockAdjustmentFormPage extends HookConsumerWidget {
  const ProductStockAdjustmentFormPage(
      {super.key, this.id, this.productStockId, this.productId});

  final String? id;
  final String? productStockId;
  final String? productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(productStockAdjustmentFormControllerProvider(
      id: id,
      productId: productId,
      productStockId: productStockId,
    ));

    ///
    /// Submit
    ///
    void onSave(
      ProductStockAdjustment? productStockAdjustment,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(productStockAdjustmentRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (productStockAdjustment == null
          ? repository.create(value, files: files)
          : repository.update(productStockAdjustment, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(productStockAdjustmentTableControllerProvider);
          ref.invalidate(productStockAdjustmentControllerProvider(r.id));
          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ProductStockAdjustment Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final productStockAdjustment = formState.productStockAdjustment;
            final productStock = formState.productStock;
            final product = formState.product;

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
                if (product is Product)
                  DynamicViewField(
                    name: ProductStockAdjustmentField.product,
                    initialValue: product,
                    decoration: InputDecoration(
                      label: Text('Product'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is Product) {
                        return ListTile(
                          title: Text(obj.name),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product: ${obj.name.optional()}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    valueTransformer: (obj) {
                      return obj?.id;
                    },
                  ),

                ///
                /// Product Stock
                ///
                if (productStock is ProductStock)
                  DynamicViewField(
                    name: ProductStockAdjustmentField.productStock,
                    initialValue: productStock,
                    decoration: InputDecoration(
                      label: Text('Product Stock'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is ProductStock) {
                        return ListTile(
                          title: Text(obj.lotNo.optional()),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Stock: ${obj.lotNo.optional()}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    valueTransformer: (obj) {
                      return obj?.id;
                    },
                  ),

                ///
                /// Reason
                ///
                DynamicTextField(
                  name: ProductStockAdjustmentField.reason,
                  initialValue: productStockAdjustment?.reason,
                  minLines: 2,
                  maxLines: 10,
                  decoration: InputDecoration(
                    label: Text('Reason'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                ///
                /// oldValue
                ///
                DynamicNumberField(
                  enabled: false,
                  name: ProductStockAdjustmentField.oldValue,
                  initialValue: productStockAdjustment?.oldValue ??
                      product?.quantity ??
                      productStock?.quantity ??
                      0,
                  decoration: InputDecoration(
                    label: Text('Current Value'),
                    helperText: 'the current value',
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
                /// New Value
                ///
                DynamicNumberField(
                  name: ProductStockAdjustmentField.newValue,
                  initialValue: productStockAdjustment?.newValue ?? 0,
                  decoration: InputDecoration(
                    label: Text('New Value'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.min(0)
                    ],
                  ),
                )
              ],
              onSubmit: (result) => onSave(productStockAdjustment, result),
            );
          }),
    );
  }
}
