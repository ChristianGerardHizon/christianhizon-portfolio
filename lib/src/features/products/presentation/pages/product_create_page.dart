import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_fields/dynamic_form_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

class ProductCreatePage extends HookConsumerWidget {
  const ProductCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    ///
    /// Submit
    ///
    void onSubmit(Map<String, dynamic> value, List<MultipartFile> files) async {
      isLoading.value = true;

      final result =
          await ref.read(productRepositoryProvider).create(value).run();
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
          DynamicFileField(
            name: 'fileA',
            fileTypeLabel: 'Upload File A (PDF/Image)',
            isRequired: true,
          ),
          DynamicImageField(
            name: 'profilePicture',
            fileTypeLabel: 'Upload Profile Picture',
            isRequired: true,
            maxSizeKB: 300,
            quality: 85,
          ),
        ],
        onSubmit: onSubmit,
      ),
    );
  }
}
