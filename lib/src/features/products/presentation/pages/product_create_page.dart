import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCreatePage extends HookConsumerWidget {
  const ProductCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    ///
    /// Submit
    ///
    void onSubmit() async {
      isLoading.value = true;
      final form = formKey.currentState;
      if (form == null) {
        isLoading.value = false;
        return;
      }
      final isValid = form.saveAndValidate();
      if (!isValid) {
        isLoading.value = false;
        return;
      }

      final result =
          await ref.read(productRepositoryProvider).create(form.value).run();
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
      body: FormBuilder(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            ///
            /// Product Details
            ///
            SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(children: [
                  SizedBox(height: 10),

                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Product Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  SizedBox(height: 10),

                  //
                  /// Name
                  ///
                  FormBuilderTextField(
                    name: ProductField.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Product name',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ])),

            ///
            /// Save Button
            ///
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: LoadingFilledButton(
                  isLoading: isLoading.value,
                  child: Text('Save'),
                  onPressed: onSubmit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
