import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/product_adjustments/data/product_adjustment_repository.dart';
import 'package:gym_system/src/features/product_adjustments/domain/product_adjustment.dart';
import 'package:gym_system/src/features/product_adjustments/presentation/controllers/product_adjustment_controller.dart';
import 'package:gym_system/src/features/product_adjustments/presentation/controllers/product_adjustment_form_controller.dart';
import 'package:gym_system/src/features/product_inventories/presentation/controllers/product_inventory_table_controller.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_table_controller.dart';
import 'package:gym_system/src/features/product_stocks/presentation/widgets/product_stock_tile.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_table_controller.dart';
import 'package:gym_system/src/features/products/presentation/widgets/product_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductAdjustmentFormPage extends HookConsumerWidget {
  const ProductAdjustmentFormPage({
    super.key,
    this.id,
    this.productStockId,
    this.productId,
  });

  final String? id;
  final String? productStockId;
  final String? productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(productAdjustmentFormControllerProvider(
      id: id,
      productId: productId,
      productStockId: productStockId,
    ));

    ///
    /// Submit
    ///
    void onSave(
      ProductAdjustment? productAdjustment,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(productAdjustmentRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (productAdjustment == null
          ? repository.create(value, files: files)
          : repository.update(productAdjustment, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(productAdjustmentControllerProvider(r.id));
          ref.invalidate(productInventoryTableControllerProvider);
          if (r.type == ProductAdjustmentType.productStock)
            ref.invalidate(productStockTableControllerProvider);
          if (r.type == ProductAdjustmentType.product)
            ref.invalidate(productTableControllerProvider);
          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ProductAdjustment Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final productAdjustment = formState.productAdjustment;
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
                ///
                /// type
                ///
                if (product is Product)
                  DynamicHiddenField(
                    name: ProductAdjustmentField.type,
                    initialValue: productAdjustment?.type.name ??
                        ProductAdjustmentType.product.name,
                  ),

                if (productStock is ProductStock)
                  DynamicHiddenField(
                    name: ProductAdjustmentField.type,
                    initialValue: productAdjustment?.type.name ??
                        ProductAdjustmentType.productStock.name,
                  ),

                ///
                ///
                ///
                if (product is Product)
                  DynamicViewField(
                    name: ProductAdjustmentField.product,
                    initialValue: product,
                    decoration: InputDecoration(
                      label: Text('Product'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is Product) {
                        return ProductTile(
                            product: product, showQuantity: true);
                      }
                      return const SizedBox();
                    },
                    valueTransformer: (obj) {
                      return obj?.id;
                    },
                  ),

                if (productStock is ProductStock)
                  DynamicViewField(
                    name: ProductAdjustmentField.productStock,
                    initialValue: productStock,
                    decoration: InputDecoration(
                      label: Text('Product Stock'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is ProductStock) {
                        return ProductStockTile(
                            productStock: productStock,
                            showQuantityUpdate: true);
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
                  name: ProductAdjustmentField.reason,
                  initialValue: productAdjustment?.reason,
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
                DynamicHiddenField(
                  name: ProductAdjustmentField.oldValue,
                  initialValue: productAdjustment?.oldValue ??
                      product?.quantity ??
                      productStock?.quantity ??
                      0,
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
                  name: ProductAdjustmentField.newValue,
                  initialValue: productAdjustment?.newValue ?? 0,
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
              onSubmit: (result) => onSave(productAdjustment, result),
            );
          }),
    );
  }
}
