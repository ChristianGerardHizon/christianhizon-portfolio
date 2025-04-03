import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/dynamic_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_update_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

class ProductUpdatePage extends HookConsumerWidget {
  const ProductUpdatePage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateController = productUpdateControllerProvider(id);
    final state = ref.watch(updateController);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final provider = productControllerProvider(id);

    onRefresh() {
      ref.invalidate(updateController);
      ref.invalidate(provider);
    }

    void onSubmit(
      Product product,
      Map<String, dynamic> value,
      List<MultipartFile> files,
    ) async {
      isLoading.value = true;

      final result = await ref
          .read(productRepositoryProvider)
          .update(product, value)
          .run();

      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: "Success");
          if (context.canPop()) context.pop();
        },
      );
    }

    return ref.watch(productUpdateControllerProvider(id)).when(
          error: (error, stack) => Text('Error'),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (updateState) {
            final product = updateState.product;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Product Create Page'),
              ),
              body: DynamicFormBuilder(
                formKey: formKey,
                isLoading: isLoading.value,
                fields: [
                  DynamicTextField(
                    name: ProductField.name,
                    label: 'Name',
                  ),
                  // DynamicFileField(
                  //   name: 'fileA',
                  //   fileTypeLabel: 'Upload File A (PDF/Image)',
                  //   isRequired: false,
                  // ),
                  DynamicImageField(
                    name: 'image',
                    fileTypeLabel: 'Upload Profile Picture',
                    isRequired: true,
                    maxSizeKB: 300,
                    compressionQuality: 85,
                  ),
                ],
                onSubmit: (value, files) => onSubmit(product, value, files),
              ),
            );
          },
        );
  }
}
