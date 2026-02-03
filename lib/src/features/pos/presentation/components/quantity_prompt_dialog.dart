import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// Shows a dialog to enter a quantity for a service.
///
/// Returns the entered quantity, or `null` if cancelled.
Future<int?> showQuantityPromptDialog(
  BuildContext context, {
  required String serviceName,
  int? maxQuantity,
  int initialQuantity = 1,
}) async {
  final formKey = GlobalKey<FormBuilderState>();

  return showDialog<int>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Quantity'),
      content: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            if (maxQuantity != null) ...[
              const SizedBox(height: 4),
              Text(
                'Max: $maxQuantity',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'quantity',
              initialValue: initialQuantity.toString(),
              decoration: InputDecoration(
                labelText: 'Quantity *',
                border: const OutlineInputBorder(),
                hintText: maxQuantity != null
                    ? 'Enter quantity (1-$maxQuantity)'
                    : 'Enter quantity',
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: 'Quantity is required',
                ),
                FormBuilderValidators.integer(
                  errorText: 'Must be a whole number',
                ),
                FormBuilderValidators.min(
                  1,
                  errorText: 'Quantity must be at least 1',
                ),
                if (maxQuantity != null)
                  FormBuilderValidators.max(
                    maxQuantity,
                    errorText: 'Maximum quantity is $maxQuantity',
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
              final quantity = int.tryParse(
                formKey.currentState?.fields['quantity']?.value ?? '',
              );
              if (quantity != null && quantity >= 1) {
                Navigator.pop(context, quantity);
              }
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    ),
  );
}
