import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/product_inventories/presentation/controllers/product_inventory_controller.dart';
import 'package:gym_system/src/features/product_stocks/data/product_stock_repository.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_controller.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_form_controller.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_table_controller.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
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

    final theme = Theme.of(context);

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
          ref.invalidate(productInventoryControllerProvider);
          ref.invalidate(productStockTableControllerProvider);
          ref.invalidate(productStockControllerProvider(r.id));
          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New Product Stock'),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    builder: (value) {
                      if (value is! Product) return SizedBox();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Product'),
                          ),
                          Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              leading: Icon(MIcons.shoppingOutline),
                              title: Text(
                                value.name,
                                style: theme.textTheme.titleSmall,
                              ),
                              subtitle: Text('Creating Stock for this product'),
                            ),
                          ),
                        ],
                      );
                    },
                    valueTransformer: (value) {
                      if (value is Product) return value.id;
                      return value;
                    }),

                ///
                /// Expiry Date
                ///
                DynamicTextField(
                  name: ProductStockField.lotNo,
                  decoration: const InputDecoration(
                    label: Text('Lot Number'),
                    border: OutlineInputBorder(),
                  ),
                ),

                ///
                /// Expiry Date
                ///
                DynamicDateField(
                  name: ProductStockField.expiration,
                  decoration: const InputDecoration(
                    label: Text('Expiry Date'),
                    helperText: 'When this stock will expire',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: productStock?.expiration,
                  valueTransformer: (date) {
                    if (date is DateTime) return date.toUtc().toIso8601String();
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
                    helperText: 'Total quantity of this stock',
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
              ],
              onSubmit: (result) => onSave(productStock, result),
            );
          }),
    );
  }
}
