import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_form_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

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
      Map<String, dynamic> value,
      List<MultipartFile> files,
    ) async {
      isLoading.value = true;

      final repository = ref.read(productRepositoryProvider);

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
                  label: 'Name',
                  initialValue: product?.name,
                ),
                // DynamicFileField(
                //   name: 'fileA',
                //   fileTypeLabel: 'Upload File A (PDF/Image)',
                // ),
                DynamicPBImagesField(
                  name: 'image',
                  fileTypeLabel: 'Upload Profile Picture',
                  maxSizeKB: 300,
                  compressionQuality: 85,
                  initialValue: product == null
                      ? []
                      : [
                          product.hasImage
                              ? PBNetworkImage(
                                  field: 'image',
                                  id: product.image!,
                                  uri: product.imageUri!,
                                )
                              : null
                        ].whereType<PBImage>().toList(),
                ),
              ],
              onSubmit: (value, files) => onSave(product, value, files),
            );
          }),
    );
  }
}
