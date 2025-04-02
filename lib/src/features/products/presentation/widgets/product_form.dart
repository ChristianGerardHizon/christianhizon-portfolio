import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';

class ProductForm extends StatelessWidget {
  final Function() onSubmit;

  final Map<String, dynamic>? initialValue;

  final bool isLoading;

  final GlobalKey<FormBuilderState> formKey;

  const ProductForm({
    super.key,
    required this.onSubmit,
    required this.formKey,
    this.isLoading = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: initialValue ?? const <String, dynamic>{},
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
                    contentPadding:
                        EdgeInsets.only(bottom: 10, right: 8, left: 8, top: 30),
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
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: LoadingFilledButton(
                isLoading: isLoading,
                child: Text('Save'),
                onPressed: onSubmit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
