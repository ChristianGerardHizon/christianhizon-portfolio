import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/routing/routes/products.routes.dart';
import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../../settings/presentation/controllers/branches_controller.dart';
import '../../../domain/product.dart';
import '../../controllers/paginated_products_controller.dart';
import '../../controllers/product_categories_provider.dart';

/// Dialog for creating a new product.
class CreateProductDialog extends HookConsumerWidget {
  const CreateProductDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final size = MediaQuery.sizeOf(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: formKey);

    // UI state
    final isSaving = useState(false);
    final trackByLot = useState(false);

    // Watch categories and branches
    final categoriesAsync = ref.watch(productCategoriesProvider);
    final branchesAsync = ref.watch(branchesControllerProvider);
    final currentAuth = ref.watch(currentAuthProvider);
    final userBranchId = currentAuth?.user.branch;

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

      // Create product
      final product = Product(
        id: '',
        name: (values['name'] as String).trim(),
        description: _nullIfEmpty(values['description'] as String?),
        categoryId: values['category'] as String?,
        price: _parseNum(values['price'] as String?) ?? 0,
        quantity: _parseNum(values['quantity'] as String?),
        stockThreshold: _parseNum(values['stockThreshold'] as String?),
        forSale: values['forSale'] as bool? ?? true,
        trackByLot: values['trackByLot'] as bool? ?? false,
        requireStock: values['requireStock'] as bool? ?? false,
        expiration: values['expiration'] as DateTime?,
        branch: values['branch'] as String?,
      );

      final createdProduct = await ref
          .read(paginatedProductsControllerProvider.notifier)
          .createProduct(product);

      if (createdProduct == null) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to create product. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(context, message: 'Product created successfully');

        // Navigate to product detail
        ProductDetailRoute(id: createdProduct.id).go(context);
      }
    }

    return DialogCloseHandler(
      onClose: (ctx) => dirtyGuard.confirmDiscard(ctx),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: dirtyGuard.onPopInvokedWithResult,
        child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: isSaving.value
                        ? null
                        : () async {
                            if (await dirtyGuard.confirmDiscard(context)) {
                              if (context.mounted) context.pop();
                            }
                          },
                  ),
                  Expanded(
                    child: Text('Create Product',
                        style: theme.textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: isSaving.value
                          ? null
                          : () async {
                              if (await dirtyGuard.confirmDiscard(context)) {
                                if (context.mounted) context.pop();
                              }
                            },
                      child: Text(t.common.cancel),
                    ),
                  ),
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
                  const SizedBox(width: 8),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Content
            Expanded(
              child: FormBuilder(
                key: formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),

                      // === PRODUCT INFORMATION ===
                      _SectionHeader(
                        title: 'Product Information',
                        icon: Icons.inventory_2_outlined,
                      ),
                      const SizedBox(height: 16),

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
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
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

                      // Branch dropdown
                      branchesAsync.when(
                        data: (branches) => FormBuilderDropdown<String>(
                          name: 'branch',
                          initialValue: userBranchId,
                          decoration: const InputDecoration(
                            labelText: 'Branch',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.business),
                          ),
                          enabled: !isSaving.value,
                          items: branches.map((branch) {
                            return DropdownMenuItem(
                              value: branch.id,
                              child: Text(branch.name),
                            );
                          }).toList(),
                        ),
                        loading: () => const TextField(
                          decoration: InputDecoration(
                            labelText: 'Branch',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.business),
                            suffixIcon: SizedBox(
                              width: 20,
                              height: 20,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          ),
                          enabled: false,
                        ),
                        error: (_, __) => const TextField(
                          decoration: InputDecoration(
                            labelText: 'Branch',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.business),
                            errorText: 'Failed to load',
                          ),
                          enabled: false,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // === PRICING & STOCK ===
                      _SectionHeader(
                        title: 'Pricing & Stock',
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: 16),

                      // Price & Quantity (quantity hidden when tracking by lot)
                      if (trackByLot.value) ...[
                        FormBuilderTextField(
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
                      ] else ...[
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
                      ],
                      const SizedBox(height: 16),

                      // Stock threshold
                      FormBuilderTextField(
                        name: 'stockThreshold',
                        decoration: const InputDecoration(
                          labelText: 'Low Stock Threshold',
                          border: OutlineInputBorder(),
                          helperText:
                              'Alert when quantity falls below this value',
                        ),
                        enabled: !isSaving.value,
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.numeric(
                          errorText: 'Must be a number',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Expiration date (hidden when tracking by lot)
                      if (!trackByLot.value) ...[
                        FormBuilderDateTimePicker(
                          name: 'expiration',
                          decoration: const InputDecoration(
                            labelText: 'Expiration Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          enabled: !isSaving.value,
                          inputType: InputType.date,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365 * 10)),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Switches
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderSwitch(
                              name: 'forSale',
                              initialValue: true,
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
                              initialValue: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              title: const Text('Track by Lot'),
                              enabled: !isSaving.value,
                              onChanged: (value) =>
                                  trackByLot.value = value ?? false,
                            ),
                          ),
                        ],
                      ),
                      FormBuilderSwitch(
                        name: 'requireStock',
                        initialValue: false,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        title: const Text('Require Stock'),
                        subtitle: const Text(
                          'Block sales when out of stock',
                        ),
                        enabled: !isSaving.value,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
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
    'branch': 'Branch',
    'price': 'Price',
    'quantity': 'Quantity',
    'stockThreshold': 'Stock Threshold',
    'expiration': 'Expiration Date',
    'forSale': 'For Sale',
    'trackByLot': 'Track by Lot',
    'requireStock': 'Require Stock',
  };
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

/// Shows the create product dialog.
void showCreateProductDialog(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => const Dialog(
      insetPadding: EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: CreateProductDialog(),
    ),
  );
}
