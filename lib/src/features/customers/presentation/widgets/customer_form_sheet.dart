import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../domain/customer.dart';
import '../controllers/customers_controller.dart';

/// Shows a bottom sheet form for creating or editing a customer.
///
/// Returns `true` if the customer was saved successfully.
Future<bool?> showCustomerFormSheet(
  BuildContext context, {
  Customer? customer,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _CustomerFormSheet(customer: customer),
  );
}

class _CustomerFormSheet extends HookConsumerWidget {
  const _CustomerFormSheet({this.customer});

  final Customer? customer;

  bool get isEditing => customer != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;

      final customerData = Customer(
        id: customer?.id ?? '',
        name: values['name'] as String,
        phone: values['phone'] as String?,
        address: values['address'] as String?,
        notes: values['notes'] as String?,
      );

      final controller = ref.read(customersControllerProvider.notifier);

      bool success;
      if (isEditing) {
        success = await controller.updateCustomer(customerData);
      } else {
        final created = await controller.createCustomer(customerData);
        success = created != null;
      }

      isSaving.value = false;

      if (success && context.mounted) {
        showSuccessSnackBar(
          context,
          message: isEditing ? 'Customer updated' : 'Customer created',
        );
        Navigator.of(context).pop(true);
      } else if (context.mounted) {
        showErrorSnackBar(
          context,
          message: isEditing
              ? 'Failed to update customer'
              : 'Failed to create customer',
        );
      }
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isEditing ? 'Edit Customer' : 'New Customer',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: isSaving.value ? null : handleSave,
                      child: isSaving.value
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: FormBuilder(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FormBuilderTextField(
                          name: 'name',
                          initialValue: customer?.name,
                          decoration:
                              const InputDecoration(labelText: 'Name *'),
                          validator: FormBuilderValidators.required(),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'phone',
                          initialValue: customer?.phone,
                          decoration:
                              const InputDecoration(labelText: 'Phone'),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'address',
                          initialValue: customer?.address,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                          maxLines: 2,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'notes',
                          initialValue: customer?.notes,
                          decoration: const InputDecoration(labelText: 'Notes'),
                          maxLines: 3,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
