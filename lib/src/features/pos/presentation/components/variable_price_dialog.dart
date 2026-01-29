import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// Shows a dialog to enter a custom price for a variable-price product.
///
/// Returns the entered price, or `null` if cancelled.
Future<num?> showVariablePriceDialog(
  BuildContext context, {
  required String productName,
  num? currentPrice,
}) async {
  final formKey = GlobalKey<FormBuilderState>();

  return showDialog<num>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Price'),
      content: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'price',
              initialValue: currentPrice != null && currentPrice > 0
                  ? currentPrice.toString()
                  : null,
              decoration: const InputDecoration(
                labelText: 'Price *',
                border: OutlineInputBorder(),
                prefixText: '₱ ',
                hintText: 'Enter price',
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: 'Price is required',
                ),
                FormBuilderValidators.numeric(
                  errorText: 'Must be a number',
                ),
                FormBuilderValidators.min(
                  0.01,
                  errorText: 'Price must be greater than 0',
                ),
              ]),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState?.saveAndValidate() ?? false) {
              final price = num.tryParse(
                formKey.currentState?.fields['price']?.value ?? '',
              );
              if (price != null && price > 0) {
                Navigator.pop(context, price);
              }
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    ),
  );
}
