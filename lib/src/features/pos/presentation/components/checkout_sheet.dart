import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../domain/cart_item.dart';
import '../../domain/payment_method.dart';
import '../cart_controller.dart';
import '../checkout_controller.dart';
import 'receipt_sheet.dart';

/// Shows the checkout bottom sheet.
Future<void> showCheckoutSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => CheckoutSheet(
        scrollController: scrollController,
      ),
    ),
  );
}

/// Checkout sheet for completing a sale.
class CheckoutSheet extends HookConsumerWidget {
  const CheckoutSheet({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final selectedPaymentMethod = useState<PaymentMethod>(PaymentMethod.cash);
    final amountTendered = useState<double>(0);

    // Watch cart state
    final cartState = ref.watch(cartControllerProvider);
    final cartItems = cartState.value?.items ?? [];
    final total = cartState.value?.total ?? 0;

    // Calculate change for cash payments
    final change = amountTendered.value - total;

    Future<void> handleCheckout() async {
      final isValid = formKey.currentState!.saveAndValidate();
      if (!isValid) {
        final errors = formKey.currentState?.errors ?? {};
        final errorMessages = formatFormErrors(errors, _fieldLabels);
        if (errorMessages.isNotEmpty) {
          showFormErrorDialog(context, errors: errorMessages);
        }
        return;
      }

      final values = formKey.currentState!.value;

      // Validate cash payment
      if (selectedPaymentMethod.value == PaymentMethod.cash) {
        final tenderedStr = values['amountTendered'] as String?;
        final tendered = double.tryParse(tenderedStr ?? '') ?? 0;
        if (tendered < total) {
          showFormErrorDialog(
            context,
            errors: ['Amount tendered must be at least ₱${total.toStringAsFixed(2)}'],
          );
          return;
        }
      }

      isSaving.value = true;

      // Process checkout
      final result = await ref.read(checkoutControllerProvider.notifier).processCheckout(
        paymentMethod: selectedPaymentMethod.value,
        paymentRef: values['paymentRef'] as String?,
        notes: values['notes'] as String?,
        amountTendered: selectedPaymentMethod.value == PaymentMethod.cash
            ? double.tryParse(values['amountTendered'] ?? '')
            : null,
      );

      isSaving.value = false;

      if (!context.mounted) return;

      result.fold(
        (failure) {
          showErrorSnackBar(context, message: failure.message);
        },
        (sale) {
          // Close checkout sheet
          Navigator.of(context).pop();

          // Show receipt
          showReceiptSheet(context, sale: sale);
        },
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header with actions
            Row(
              children: [
                Expanded(
                  child: Text('Checkout', style: theme.textTheme.titleLarge),
                ),
                TextButton(
                  onPressed: isSaving.value ? null : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: isSaving.value || cartItems.isEmpty ? null : handleCheckout,
                  child: isSaving.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Complete Sale'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Order summary
                    _buildOrderSummary(context, cartItems, total),
                    const SizedBox(height: 24),

                    // Payment method selection
                    Text('Payment Method', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 12),
                    FormBuilderChoiceChips<PaymentMethod>(
                      name: 'paymentMethod',
                      initialValue: PaymentMethod.cash,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      spacing: 8,
                      runSpacing: 8,
                      options: PaymentMethod.values
                          .map((method) => FormBuilderChipOption(
                                value: method,
                                child: Text(method.displayName),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedPaymentMethod.value = value;
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Cash payment fields
                    if (selectedPaymentMethod.value == PaymentMethod.cash) ...[
                      FormBuilderTextField(
                        name: 'amountTendered',
                        decoration: const InputDecoration(
                          labelText: 'Amount Tendered *',
                          prefixText: '₱ ',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ]),
                        onChanged: (value) {
                          amountTendered.value = double.tryParse(value ?? '') ?? 0;
                        },
                      ),
                      const SizedBox(height: 12),
                      if (amountTendered.value >= total)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Change:',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                '₱${change.toStringAsFixed(2)}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],

                    // Card/Transfer payment reference
                    if (selectedPaymentMethod.value != PaymentMethod.cash) ...[
                      FormBuilderTextField(
                        name: 'paymentRef',
                        decoration: InputDecoration(
                          labelText: selectedPaymentMethod.value == PaymentMethod.card
                              ? 'Card Reference / Last 4 Digits'
                              : 'Transaction Reference',
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),

                    // Notes
                    FormBuilderTextField(
                      name: 'notes',
                      decoration: const InputDecoration(
                        labelText: 'Notes (Optional)',
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, List<CartItem> items, double total) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          ...items.map((item) {
            final product = item.product;
            if (product == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item.quantity}x ${product.name}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    '₱${item.total.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₱${total.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const _fieldLabels = {
  'paymentMethod': 'Payment Method',
  'amountTendered': 'Amount Tendered',
  'paymentRef': 'Payment Reference',
  'notes': 'Notes',
};
