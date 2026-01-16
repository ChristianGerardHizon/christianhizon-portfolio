import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/product.dart';
import '../../controllers/paginated_products_controller.dart';
import '../../controllers/product_categories_provider.dart';
import '../../controllers/product_provider.dart';

/// Bottom sheet for editing an existing product.
class EditProductSheet extends HookConsumerWidget {
  const EditProductSheet({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Watch product
    final productAsync = ref.watch(productProvider(productId));

    return productAsync.when(
      data: (product) {
        if (product == null) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 16),
                const Text('Product not found'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }

        return _EditProductForm(product: product);
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(48),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditProductForm extends HookConsumerWidget {
  const _EditProductForm({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);

    // Watch categories
    final categoriesAsync = ref.watch(productCategoriesProvider);

    Future<void> handleSave() async {
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

      isSaving.value = true;

      // Create updated product
      final updatedProduct = Product(
        id: product.id,
        name: (values['name'] as String).trim(),
        description: _nullIfEmpty(values['description'] as String?),
        categoryId: values['category'] as String?,
        price: _parseNum(values['price'] as String?) ?? 0,
        quantity: _parseNum(values['quantity'] as String?),
        stockThreshold: _parseNum(values['stockThreshold'] as String?),
        forSale: values['forSale'] as bool? ?? true,
        trackByLot: values['trackByLot'] as bool? ?? false,
        expiration: values['expiration'] as DateTime?,
        image: product.image,
        branch: product.branch,
        isDeleted: product.isDeleted,
        created: product.created,
        updated: product.updated,
      );

      final success = await ref
          .read(paginatedProductsControllerProvider.notifier)
          .updateProduct(updatedProduct);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to update product. Please try again.'],
          );
        }
        return;
      }

      // Invalidate the single product provider to refresh
      ref.invalidate(productProvider(product.id));

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(context, message: 'Product updated successfully');
      }
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
        initialValue: {
          'name': product.name,
          'description': product.description ?? '',
          'category': product.categoryId,
          'price': product.price.toString(),
          'quantity': product.quantity?.toString() ?? '',
          'stockThreshold': product.stockThreshold?.toString() ?? '',
          'expiration': product.expiration,
          'forSale': product.forSale,
          'trackByLot': product.trackByLot,
        },
        child: SingleChildScrollView(
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
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // === HEADER WITH ACTIONS ===
              Row(
                children: [
                  Expanded(
                    child:
                        Text('Edit Product', style: theme.textTheme.titleLarge),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed:
                        isSaving.value ? null : () => Navigator.pop(context),
                    child: Text(t.common.cancel),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: isSaving.value ? null : handleSave,
                    child: isSaving.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(t.common.save),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name (required)
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Product Name *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label_outline),
                ),
                enabled: !isSaving.value,
                textCapitalization: TextCapitalization.words,
                validator: FormBuilderValidators.required(
                  errorText: 'Product name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Description
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                enabled: !isSaving.value,
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Category dropdown
              categoriesAsync.when(
                data: (categories) => FormBuilderDropdown<String>(
                  name: 'category',
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  enabled: !isSaving.value,
                  items: categories.map((c) {
                    return DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    );
                  }).toList(),
                ),
                loading: () => const TextField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    suffixIcon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                  enabled: false,
                ),
                error: (_, __) => const TextField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    errorText: 'Failed to load',
                  ),
                  enabled: false,
                ),
              ),
              const SizedBox(height: 16),

              // Price & Quantity
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'price',
                      decoration: const InputDecoration(
                        labelText: 'Price *',
                        border: OutlineInputBorder(),
                        prefixText: '₱ ',
                      ),
                      enabled: !isSaving.value,
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Price is required',
                        ),
                        FormBuilderValidators.numeric(
                          errorText: 'Must be a number',
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'quantity',
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                      enabled: !isSaving.value,
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.numeric(
                        errorText: 'Must be a number',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Stock threshold
              FormBuilderTextField(
                name: 'stockThreshold',
                decoration: const InputDecoration(
                  labelText: 'Low Stock Threshold',
                  border: OutlineInputBorder(),
                  helperText: 'Alert when quantity falls below this value',
                ),
                enabled: !isSaving.value,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.numeric(
                  errorText: 'Must be a number',
                ),
              ),
              const SizedBox(height: 16),

              // Expiration date
              FormBuilderDateTimePicker(
                name: 'expiration',
                decoration: const InputDecoration(
                  labelText: 'Expiration Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                enabled: !isSaving.value,
                inputType: InputType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
              ),
              const SizedBox(height: 16),

              // Switches
              Row(
                children: [
                  Expanded(
                    child: FormBuilderSwitch(
                      name: 'forSale',
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      title: const Text('For Sale'),
                      enabled: !isSaving.value,
                    ),
                  ),
                  Expanded(
                    child: FormBuilderSwitch(
                      name: 'trackByLot',
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      title: const Text('Track by Lot'),
                      enabled: !isSaving.value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Bottom actions removed (moved to header)
            ],
          ),
        ),
      ),
    );
  }

  String? _nullIfEmpty(String? text) {
    if (text == null) return null;
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  num? _parseNum(String? text) {
    if (text == null || text.trim().isEmpty) return null;
    return num.tryParse(text.trim());
  }

  static const _fieldLabels = {
    'name': 'Product Name',
    'description': 'Description',
    'category': 'Category',
    'price': 'Price',
    'quantity': 'Quantity',
    'stockThreshold': 'Stock Threshold',
    'expiration': 'Expiration Date',
    'forSale': 'For Sale',
    'trackByLot': 'Track by Lot',
  };
}
