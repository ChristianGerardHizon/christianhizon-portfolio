import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/product_lot.dart';
import '../../controllers/product_lots_controller.dart';

/// Bottom sheet for creating a new product lot.
class CreateLotSheet extends HookConsumerWidget {
  const CreateLotSheet({
    super.key,
    required this.productId,
    this.scrollController,
  });

  final String productId;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: formKey);

    // UI state
    final isSaving = useState(false);

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

      // Create lot
      final lot = ProductLot(
        id: '',
        productId: productId,
        lotNumber: (values['lotNumber'] as String).trim(),
        quantity: _parseNum(values['quantity'] as String?) ?? 0,
        expiration: values['expiration'] as DateTime?,
        notes: _nullIfEmpty(values['notes'] as String?),
      );

      final success = await ref
          .read(productLotsControllerProvider(productId).notifier)
          .createLot(lot);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to create lot. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(context, message: 'Lot created successfully');
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: dirtyGuard.onPopInvokedWithResult,
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
      child: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          controller: scrollController,
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
                    child: Text('Add Lot', style: theme.textTheme.titleLarge),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: isSaving.value
                        ? null
                        : () async {
                            if (await dirtyGuard.confirmDiscard(context)) {
                              if (context.mounted) Navigator.pop(context);
                            }
                          },
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

              // Lot Number (required)
              FormBuilderTextField(
                name: 'lotNumber',
                decoration: const InputDecoration(
                  labelText: 'Lot Number *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.tag),
                  hintText: 'e.g., LOT-2024-001',
                ),
                enabled: !isSaving.value,
                textCapitalization: TextCapitalization.characters,
                validator: FormBuilderValidators.required(
                  errorText: 'Lot number is required',
                ),
              ),
              const SizedBox(height: 16),

              // Quantity (required)
              FormBuilderTextField(
                name: 'quantity',
                decoration: const InputDecoration(
                  labelText: 'Quantity *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
                enabled: !isSaving.value,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Quantity is required',
                  ),
                  FormBuilderValidators.numeric(
                    errorText: 'Must be a number',
                  ),
                ]),
              ),
              const SizedBox(height: 16),

              // Expiration date
              FormBuilderDateTimePicker(
                name: 'expiration',
                decoration: const InputDecoration(
                  labelText: 'Expiration Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                enabled: !isSaving.value,
                inputType: InputType.date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
              ),
              const SizedBox(height: 16),

              // Notes
              FormBuilderTextField(
                name: 'notes',
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
                enabled: !isSaving.value,
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Bottom actions removed (moved to header)
            ],
          ),
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
    'lotNumber': 'Lot Number',
    'quantity': 'Quantity',
    'expiration': 'Expiration Date',
    'notes': 'Notes',
  };
}

/// Shows the create lot sheet as a modal bottom sheet.
void showCreateLotSheet(BuildContext context, String productId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => CreateLotSheet(
        productId: productId,
        scrollController: scrollController,
      ),
    ),
  );
}
