import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_form_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductFormPage extends HookConsumerWidget {
  const ProductFormPage({super.key, this.id});

  final String? id;

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
          ref.invalidate(productsControllerProvider);
          context.pop();
        },
      );
    }

    List<PBImage>? buildInitialImages(Product? product) {
      if (product == null) return null;
      if (!product.hasImage || product.imageUri == null) return null;
      final images = [product.image];
      return images
          .map(
            (e) => PBNetworkImage(
              uri: product.imageUri!,
              field: 'image',
              id: product.id,
            ),
          )
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Form Error')),
          data: (formState) {
            final product = formState.product;

            return DynamicFormBuilder(
              formKey: formKey,
              isLoading: isLoading.value,
              fields: [
                DynamicTextField(
                  name: ProductField.name,
                  initialValue: product?.name,
                ),
                DynamicTypeAheadField(
                  name: ProductField.name,
                  initialValue: product?.name,
                  selectionToString: (x) => x.toString(),
                  itemBuilder: (context, item) {
                    if(item is Product) return Text(item.name);
                    return Text(item.toString());
                  },
                  onSearch: (p0) async {

                    await Future.delayed(Duration(seconds: 2));
                    return Future.value(['test', 'test1', 'test2']);
                  },
                ),
                DynamicPBImagesField(
                  name: 'image',
                  fileTypeLabel: 'Upload Profile Picture',
                  maxFiles: 10,
                  allowCompression: false,
                  maxSizeKB: 300,
                  compressionQuality: 85,
                  previewSize: 200,
                  fieldTransformer: (list) =>
                      PBUtils.defaultFieldTransformer(list, isSingleFile: true),
                  fileTransformer: PBUtils.defaultFileTransformer,
                  initialValue: buildInitialImages(product),
                ),
              ],
              onSubmit: (result) => onSave(product, result),
            );
          }),
    );
  }
}
