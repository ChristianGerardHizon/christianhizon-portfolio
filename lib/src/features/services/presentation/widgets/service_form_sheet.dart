import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../domain/service.dart';
import '../controllers/service_categories_provider.dart';
import '../controllers/services_controller.dart';
import 'service_category_form_sheet.dart';

/// Shows a bottom sheet form for creating or editing a service.
///
/// Returns `true` if the service was saved successfully.
Future<bool?> showServiceFormSheet(
  BuildContext context, {
  Service? service,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _ServiceFormSheet(service: service),
  );
}

class _ServiceFormSheet extends HookConsumerWidget {
  const _ServiceFormSheet({this.service});

  final Service? service;

  bool get isEditing => service != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final categoriesAsync = ref.watch(serviceCategoriesProvider);

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;
      final branchId = ref.read(currentBranchIdProvider);

      final serviceData = Service(
        id: service?.id ?? '',
        name: values['name'] as String,
        description: values['description'] as String?,
        categoryId: values['category'] as String?,
        branch: branchId,
        price: num.tryParse(values['price']?.toString() ?? '0') ?? 0,
        isVariablePrice: values['isVariablePrice'] as bool? ?? false,
        estimatedDuration:
            num.tryParse(values['estimatedDuration']?.toString() ?? ''),
        weightBased: values['weightBased'] as bool? ?? false,
      );

      final controller = ref.read(servicesControllerProvider.notifier);

      bool success;
      if (isEditing) {
        success = await controller.updateService(serviceData);
      } else {
        final created = await controller.createService(serviceData);
        success = created != null;
      }

      isSaving.value = false;

      if (success && context.mounted) {
        showSuccessSnackBar(
          context,
          message: isEditing ? 'Service updated' : 'Service created',
        );
        Navigator.of(context).pop(true);
      } else if (context.mounted) {
        showErrorSnackBar(
          context,
          message: isEditing
              ? 'Failed to update service'
              : 'Failed to create service',
        );
      }
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
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
                        isEditing ? 'Edit Service' : 'New Service',
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
                          initialValue: service?.name,
                          decoration:
                              const InputDecoration(labelText: 'Name *'),
                          validator: FormBuilderValidators.required(),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'description',
                          initialValue: service?.description,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),

                        // Category dropdown with add button
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: categoriesAsync.when(
                                data: (categories) =>
                                    FormBuilderDropdown<String>(
                                  name: 'category',
                                  initialValue: service?.categoryId,
                                  decoration: const InputDecoration(
                                    labelText: 'Category',
                                  ),
                                  items: categories
                                      .map((c) => DropdownMenuItem(
                                            value: c.id,
                                            child: Text(c.name),
                                          ))
                                      .toList(),
                                ),
                                loading: () =>
                                    FormBuilderDropdown<String>(
                                  name: 'category',
                                  decoration: const InputDecoration(
                                    labelText: 'Category',
                                  ),
                                  items: const [],
                                ),
                                error: (_, __) =>
                                    FormBuilderDropdown<String>(
                                  name: 'category',
                                  decoration: const InputDecoration(
                                    labelText: 'Category',
                                  ),
                                  items: const [],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                tooltip: 'Add Category',
                                onPressed: () =>
                                    _showAddCategory(context, ref),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        FormBuilderTextField(
                          name: 'price',
                          initialValue: service?.price.toString() ?? '0',
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            prefixText: '₱ ',
                          ),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.numeric(),
                          ]),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),

                        FormBuilderSwitch(
                          name: 'isVariablePrice',
                          initialValue: service?.isVariablePrice ?? false,
                          title: const Text('Variable Price'),
                          subtitle: const Text(
                            'Price will be entered at the cashier',
                          ),
                        ),
                        const SizedBox(height: 8),

                        FormBuilderSwitch(
                          name: 'weightBased',
                          initialValue: service?.weightBased ?? false,
                          title: const Text('Weight Based'),
                          subtitle: const Text(
                            'Pricing depends on weight',
                          ),
                        ),
                        const SizedBox(height: 16),

                        FormBuilderTextField(
                          name: 'estimatedDuration',
                          initialValue:
                              service?.estimatedDuration?.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Estimated Duration (minutes)',
                            suffixText: 'min',
                          ),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.numeric(),
                          ]),
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

  void _showAddCategory(BuildContext context, WidgetRef ref) async {
    final result = await showServiceCategoryFormSheet(context);
    if (result == true) {
      ref.invalidate(serviceCategoriesProvider);
    }
  }
}
