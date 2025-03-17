import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_update_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    void onSubmit(Product product) async {
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

      final result = await ref
          .read(productRepositoryProvider)
          .update(product, form.value)
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Update Page'),
        actions: [
          IconButton(
            onPressed: onRefresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        error: (error, stack) {
          return Text(error.toString());
        },
        loading: () => CenteredProgressIndicator(),
        data: (updateState) {
          final product = updateState.product;
          // final settings = updateState.settings;
          final map = product.toForm();
          return FormBuilder(
            key: formKey,
            initialValue: map,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                  sliver: SliverList.list(children: [
                    SizedBox(height: 10),

                    ///
                    /// name
                    ///
                    FormBuilderTextField(
                      name: ProductField.name,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Product Name',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                  ]),
                ),

                ///
                /// Save button
                ///
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: LoadingFilledButton(
                        isLoading: isLoading.value,
                        child: Text('Save'),
                        onPressed: () => onSubmit(product),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 20))
              ],
            ),
          );
        },
      ),
    );
  }
}
