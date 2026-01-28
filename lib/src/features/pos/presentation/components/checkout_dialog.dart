import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/currency_format.dart';
import '../../../../core/widgets/dialog_close_handler.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/data/repositories/patient_repository.dart';
import '../../../patients/domain/patient.dart';
import '../../domain/cart_item.dart';
import '../../domain/payment_method.dart';
import '../../domain/sale_item.dart';
import '../cart_controller.dart';
import '../checkout_controller.dart';
import 'receipt_dialog.dart';

/// Shows the checkout dialog.
Future<void> showCheckoutDialog(BuildContext context) {
  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => const Dialog(
      insetPadding: EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: CheckoutDialog(),
    ),
  );
}

/// Checkout dialog for completing a sale.
class CheckoutDialog extends HookConsumerWidget {
  const CheckoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final selectedPaymentMethod = useState<PaymentMethod>(PaymentMethod.cash);
    final amountTendered = useState<double>(0);

    // Customer selection state
    final selectedPatient = useState<Patient?>(null);
    final customerType = useState<String>('patient'); // 'patient' or 'walkin'
    final customerNameController = useTextEditingController();
    final patientSearchController = useTextEditingController();
    final patientSearchResults = useState<List<Patient>>([]);
    final isSearchingPatients = useState(false);
    final showPatientDropdown = useState(false);

    // Watch cart state
    final cartState = ref.watch(cartControllerProvider);
    final cartItems = cartState.value?.items ?? [];
    final total = cartState.value?.total ?? 0;

    // Calculate change for cash payments
    final change = amountTendered.value - total;

    // Patient search function
    Future<void> searchPatients(String query) async {
      if (query.length < 2) {
        patientSearchResults.value = [];
        showPatientDropdown.value = false;
        return;
      }

      isSearchingPatients.value = true;
      final result = await ref.read(patientRepositoryProvider).search(
        query,
        fields: ['name', 'owner'],
      );

      result.fold(
        (failure) {
          patientSearchResults.value = [];
        },
        (patients) {
          patientSearchResults.value = patients.take(5).toList();
          showPatientDropdown.value = patients.isNotEmpty;
        },
      );
      isSearchingPatients.value = false;
    }

    void selectPatient(Patient patient) {
      selectedPatient.value = patient;
      patientSearchController.text = patient.name;
      customerNameController.text = patient.name;
      showPatientDropdown.value = false;
      patientSearchResults.value = [];
    }

    void clearPatientSelection() {
      selectedPatient.value = null;
      patientSearchController.clear();
      customerNameController.clear();
      patientSearchResults.value = [];
      showPatientDropdown.value = false;
    }

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
            errors: ['Amount tendered must be at least ${total.toCurrency()}'],
          );
          return;
        }
      }

      isSaving.value = true;

      // Determine customer info
      // When patient is linked, use patient's owner name; otherwise use walk-in name
      final customerId = selectedPatient.value?.id;
      final customerName = selectedPatient.value != null
          ? selectedPatient.value!.owner // Use patient owner's name
          : (customerNameController.text.trim().isNotEmpty
              ? customerNameController.text.trim()
              : null);

      // Process checkout
      final result =
          await ref.read(checkoutControllerProvider.notifier).processCheckout(
                paymentMethod: selectedPaymentMethod.value,
                paymentRef: values['paymentRef'] as String?,
                notes: values['notes'] as String?,
                amountTendered:
                    selectedPaymentMethod.value == PaymentMethod.cash
                        ? double.tryParse(values['amountTendered'] ?? '')
                        : null,
                customerId: customerId,
                customerName: customerName,
              );

      isSaving.value = false;

      if (!context.mounted) return;

      result.fold(
        (failure) {
          showErrorSnackBar(context, message: failure.message);
        },
        (sale) {
          // Convert cart items to sale items for receipt
          final saleItems = cartItems
              .where((item) => item.product != null)
              .map((item) => SaleItem(
                    id: '',
                    saleId: sale.id,
                    productId: item.productId,
                    productName: item.product!.name,
                    quantity: item.quantity,
                    unitPrice: item.product!.price,
                    subtotal: item.total,
                    productLotId: item.productLotId,
                    lotNumber: item.lotNumber,
                  ))
              .toList();

          // Close checkout dialog
          context.pop();

          // Show receipt with items
          showReceiptDialog(context, sale: sale, saleItems: saleItems);
        },
      );
    }

    return DialogCloseHandler(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: isSaving.value ? null : () => context.pop(),
                    ),
                    Expanded(
                      child:
                          Text('Checkout', style: theme.textTheme.titleLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextButton(
                        onPressed: isSaving.value ? null : () => context.pop(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    FilledButton(
                      onPressed: isSaving.value || cartItems.isEmpty
                          ? null
                          : handleCheckout,
                      child: isSaving.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Complete Sale'),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),

                      // Order summary
                      _buildOrderSummary(context, cartItems, total),
                      const SizedBox(height: 24),

                      // Customer section (optional)
                      Card(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header with icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: theme.colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Customer (Optional)',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              if (selectedPatient.value == null) ...[
                                // SegmentedButton for customer type
                                SizedBox(
                                  width: double.infinity,
                                  child: SegmentedButton<String>(
                                    segments: const [
                                      ButtonSegment(
                                        value: 'patient',
                                        label: Text('Patient'),
                                        icon: Icon(Icons.pets),
                                      ),
                                      ButtonSegment(
                                        value: 'walkin',
                                        label: Text('Walk-in'),
                                        icon: Icon(Icons.person_add_outlined),
                                      ),
                                    ],
                                    selected: {customerType.value},
                                    onSelectionChanged: (values) {
                                      customerType.value = values.first;
                                      // Clear the other field when switching
                                      if (values.first == 'patient') {
                                        customerNameController.clear();
                                      } else {
                                        patientSearchController.clear();
                                        patientSearchResults.value = [];
                                        showPatientDropdown.value = false;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Conditional content based on customer type
                                if (customerType.value == 'patient') ...[
                                  // Patient search
                                  TextField(
                                    controller: patientSearchController,
                                    decoration: InputDecoration(
                                      labelText: 'Search patient...',
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: isSearchingPatients.value
                                          ? const Padding(
                                              padding: EdgeInsets.all(12),
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2),
                                              ),
                                            )
                                          : null,
                                      border: const OutlineInputBorder(),
                                    ),
                                    onChanged: searchPatients,
                                  ),
                                  if (showPatientDropdown.value &&
                                      patientSearchResults.value.isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface,
                                        border: Border.all(
                                            color: theme.colorScheme.outline),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: patientSearchResults.value
                                            .map((patient) {
                                          return ListTile(
                                            dense: true,
                                            leading: CircleAvatar(
                                              radius: 16,
                                              child: Text(
                                                patient.name.isNotEmpty
                                                    ? patient.name[0]
                                                        .toUpperCase()
                                                    : '?',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                            title: Text(patient.name),
                                            subtitle: patient.owner != null
                                                ? Text(
                                                    'Owner: ${patient.owner}',
                                                    style: theme
                                                        .textTheme.bodySmall,
                                                  )
                                                : null,
                                            onTap: () => selectPatient(patient),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                ] else ...[
                                  // Walk-in customer name
                                  TextField(
                                    controller: customerNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Customer name',
                                      prefixIcon: Icon(Icons.person_outline),
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter customer name',
                                    ),
                                  ),
                                ],
                              ] else ...[
                                // Selected patient display
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer
                                        .withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.5)),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        child: Text(
                                          selectedPatient.value!.name.isNotEmpty
                                              ? selectedPatient.value!.name[0]
                                                  .toUpperCase()
                                              : '?',
                                          style: TextStyle(
                                            color: theme.colorScheme.onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              selectedPatient.value!.name,
                                              style: theme.textTheme.titleSmall
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (selectedPatient.value!.owner !=
                                                null)
                                              Text(
                                                'Owner: ${selectedPatient.value!.owner}',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: theme.colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: clearPatientSelection,
                                        tooltip: 'Remove customer',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Payment method selection
                      Card(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Section header with icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.payment,
                                    color: theme.colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Payment Method',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              FormBuilderChoiceChips<PaymentMethod>(
                                name: 'paymentMethod',
                                initialValue: PaymentMethod.cash,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                spacing: 8,
                                runSpacing: 8,
                                options: [
                                  FormBuilderChipOption(
                                    value: PaymentMethod.cash,
                                    avatar: Icon(
                                      Icons.payments_outlined,
                                      size: 18,
                                      color: selectedPaymentMethod.value ==
                                              PaymentMethod.cash
                                          ? theme
                                              .colorScheme.onSecondaryContainer
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    child: const Text('Cash'),
                                  ),
                                  FormBuilderChipOption(
                                    value: PaymentMethod.card,
                                    avatar: Icon(
                                      Icons.credit_card_outlined,
                                      size: 18,
                                      color: selectedPaymentMethod.value ==
                                              PaymentMethod.card
                                          ? theme
                                              .colorScheme.onSecondaryContainer
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    child: const Text('Card'),
                                  ),
                                  FormBuilderChipOption(
                                    value: PaymentMethod.bankTransfer,
                                    avatar: Icon(
                                      Icons.account_balance_outlined,
                                      size: 18,
                                      color: selectedPaymentMethod.value ==
                                              PaymentMethod.bankTransfer
                                          ? theme
                                              .colorScheme.onSecondaryContainer
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    child: const Text('Transfer'),
                                  ),
                                  FormBuilderChipOption(
                                    value: PaymentMethod.check,
                                    avatar: Icon(
                                      Icons.receipt_long_outlined,
                                      size: 18,
                                      color: selectedPaymentMethod.value ==
                                              PaymentMethod.check
                                          ? theme
                                              .colorScheme.onSecondaryContainer
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    child: const Text('Check'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedPaymentMethod.value = value;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Cash payment fields
                      if (selectedPaymentMethod.value ==
                          PaymentMethod.cash) ...[
                        Card(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section header
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payments,
                                      color: theme.colorScheme.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Cash Payment',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Amount tendered field
                                FormBuilderTextField(
                                  name: 'amountTendered',
                                  decoration: InputDecoration(
                                    labelText: 'Amount Tendered *',
                                    prefixIcon: const Icon(Icons.money),
                                    prefixText: '₱ ',
                                    border: const OutlineInputBorder(),
                                    helperText:
                                        'Minimum: ${total.toCurrency()}',
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ]),
                                  onChanged: (value) {
                                    amountTendered.value =
                                        double.tryParse(value ?? '') ?? 0;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Change preview card
                        if (amountTendered.value > 0)
                          Card(
                            color: amountTendered.value >= total
                                ? theme.colorScheme.primaryContainer
                                : theme.colorScheme.errorContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Status icon
                                  Icon(
                                    amountTendered.value >= total
                                        ? Icons.check_circle_outline
                                        : Icons.warning_amber_outlined,
                                    color: amountTendered.value >= total
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.error,
                                  ),
                                  const SizedBox(width: 12),

                                  // Change label and amount
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          amountTendered.value >= total
                                              ? 'Change'
                                              : 'Amount Short',
                                          style: theme.textTheme.labelMedium
                                              ?.copyWith(
                                            color: amountTendered.value >= total
                                                ? theme.colorScheme
                                                    .onPrimaryContainer
                                                : theme.colorScheme
                                                    .onErrorContainer,
                                          ),
                                        ),
                                        Text(
                                          (amountTendered.value - total)
                                              .abs()
                                              .toCurrency(),
                                          style: theme.textTheme.headlineMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: amountTendered.value >= total
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.error,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Delta badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: amountTendered.value >= total
                                          ? Colors.green.withValues(alpha: 0.2)
                                          : Colors.red.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      amountTendered.value >= total
                                          ? '+${change.toCurrency()}'
                                          : '-${(total - amountTendered.value).toCurrency()}',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: amountTendered.value >= total
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],

                      // Card/Transfer payment reference
                      if (selectedPaymentMethod.value !=
                          PaymentMethod.cash) ...[
                        Card(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section header with dynamic icon
                                Row(
                                  children: [
                                    Icon(
                                      _getPaymentSectionIcon(
                                          selectedPaymentMethod.value),
                                      color: theme.colorScheme.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _getPaymentSectionTitle(
                                          selectedPaymentMethod.value),
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                FormBuilderTextField(
                                  name: 'paymentRef',
                                  decoration: InputDecoration(
                                    labelText: _getPaymentRefLabel(
                                        selectedPaymentMethod.value),
                                    prefixIcon: Icon(_getPaymentRefIcon(
                                        selectedPaymentMethod.value)),
                                    border: const OutlineInputBorder(),
                                    helperText: _getPaymentRefHelperText(
                                        selectedPaymentMethod.value),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Notes section
                      Card(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.notes,
                                    color: theme.colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Additional Notes',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              FormBuilderTextField(
                                name: 'notes',
                                decoration: const InputDecoration(
                                  labelText: 'Notes (Optional)',
                                  hintText:
                                      'Add any special instructions or comments',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.edit_note),
                                ),
                                maxLines: 2,
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary(
      BuildContext context, List<CartItem> items, double total) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header with icon and item count
            Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Order Summary',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Total items count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${items.fold<int>(0, (sum, item) => sum + item.quantity.toInt())} items',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Item rows with enhanced styling
            ...items.map((item) {
              final product = item.product;
              if (product == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    // Quantity badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${item.quantity.toInt()}x',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Product name and unit price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '@ ${product.price.toCurrency()}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Subtotal
                    Text(
                      item.total.toCurrency(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),

            // Total row with primary container background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    total.toCurrency(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

// Helper methods for payment section
IconData _getPaymentSectionIcon(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.card:
      return Icons.credit_card;
    case PaymentMethod.bankTransfer:
      return Icons.account_balance;
    case PaymentMethod.check:
      return Icons.receipt_long;
    default:
      return Icons.payment;
  }
}

String _getPaymentSectionTitle(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.card:
      return 'Card Details';
    case PaymentMethod.bankTransfer:
      return 'Transfer Details';
    case PaymentMethod.check:
      return 'Check Details';
    default:
      return 'Payment Details';
  }
}

String _getPaymentRefLabel(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.card:
      return 'Card Reference / Last 4 Digits';
    case PaymentMethod.bankTransfer:
      return 'Transaction Reference Number';
    case PaymentMethod.check:
      return 'Check Number';
    default:
      return 'Reference';
  }
}

IconData _getPaymentRefIcon(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.card:
      return Icons.pin;
    case PaymentMethod.bankTransfer:
      return Icons.tag;
    case PaymentMethod.check:
      return Icons.numbers;
    default:
      return Icons.info_outline;
  }
}

String _getPaymentRefHelperText(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.card:
      return 'Enter card last 4 digits or approval code';
    case PaymentMethod.bankTransfer:
      return 'Enter GCash, Maya, or bank reference number';
    case PaymentMethod.check:
      return 'Enter check number for records';
    default:
      return '';
  }
}
