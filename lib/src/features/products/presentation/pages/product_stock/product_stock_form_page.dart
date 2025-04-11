import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product/products_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_stock/product_stock_form_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_stock/product_stocks_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductStockFormPage extends HookConsumerWidget {
  const ProductStockFormPage({super.key, this.id, required this.productId});

  final String? id;
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider =
        ref.watch(productStockFormControllerProvider(id, productId));

    ///
    /// Submit
    ///
    void onSave(
      ProductStock? stock,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(productStockRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (stock == null
          ? repository.create(value, files: files)
          : repository.update(stock, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(productStocksControllerProvider);
          context.pop();
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final product = formState.product;
            final productStock = formState.productStock;

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
                /// Product Display
                ///
                DynamicViewField(
                    name: ProductStockField.product,
                    initialValue: product,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    builder: (value) {
                      if (value is! Product) return SizedBox();
                      return ListTile(
                        title: Text(value.name),
                        subtitle: Text('Product'),
                      );
                    },
                    valueTransformer: (value) {
                      if (value is Product) return value.id;
                      return value;
                    }),

                ///
                /// Expiry Date
                ///
                DynamicDateField(
                  name: ProductStockField.expiration,
                  decoration: const InputDecoration(
                    label: Text('Expiry Date'),
                    border: OutlineInputBorder(),
                  ),
                  valueTransformer: (date) {
                    if (date is DateTime) return date.toIso8601String();
                    return date;
                  },
                ),

                ///
                /// Quantity
                ///
                DynamicNumberField(
                  name: ProductStockField.quantity,
                  initialValue: productStock?.quantity,
                  decoration: InputDecoration(
                    label: Text('Quantity'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                ),
              ],
              onSubmit: (result) => onSave(productStock, result),
            );
          }),
    );
  }
}
