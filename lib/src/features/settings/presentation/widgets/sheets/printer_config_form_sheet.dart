import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/printer_config.dart';
import '../../../domain/printer_connection_type.dart';
import '../../../domain/printer_paper_width.dart';
import '../../controllers/printer_configs_controller.dart';
import 'printer_discovery_sheet.dart';

/// Bottom sheet for creating or editing a printer configuration.
class PrinterConfigFormSheet extends HookConsumerWidget {
  const PrinterConfigFormSheet({
    super.key,
    this.config,
    this.scrollController,
  });

  final PrinterConfig? config;
  final ScrollController? scrollController;

  bool get isEditing => config != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);
    final selectedConnectionType = useState<PrinterConnectionType>(
      config?.connectionType ?? PrinterConnectionType.bluetooth,
    );

    Future<void> handleSave() async {
      final isValid = formKey.currentState!.saveAndValidate();

      if (!isValid) {
        return;
      }

      final values = formKey.currentState!.value;

      isSaving.value = true;

      final configData = PrinterConfig(
        id: config?.id ?? '',
        name: (values['name'] as String).trim(),
        connectionType:
            values['connectionType'] as PrinterConnectionType? ??
                PrinterConnectionType.bluetooth,
        address: _nullIfEmpty(values['address'] as String?),
        port: int.tryParse(values['port'] as String? ?? '9100') ?? 9100,
        paperWidth:
            values['paperWidth'] as PrinterPaperWidth? ?? PrinterPaperWidth.mm80,
        isDefault: values['isDefault'] as bool? ?? false,
        isEnabled: values['isEnabled'] as bool? ?? true,
      );

      bool success;
      if (isEditing) {
        success = await ref
            .read(printerConfigsControllerProvider.notifier)
            .updateConfig(configData);
      } else {
        success = await ref
            .read(printerConfigsControllerProvider.notifier)
            .createConfig(configData);
      }

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to save printer configuration. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(
          context,
          message: isEditing
              ? 'Printer updated successfully'
              : 'Printer added successfully',
        );
      }
    }

    void showDiscoverySheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        useRootNavigator: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => PrinterDiscoverySheet(
            scrollController: scrollController,
            onPrinterSelected: (name, address) {
              formKey.currentState?.fields['name']?.didChange(name);
              formKey.currentState?.fields['address']?.didChange(address);
              context.pop();
            },
          ),
        ),
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
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isEditing ? 'Edit Printer' : 'New Printer',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
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
              const SizedBox(height: 24),

              // Name field
              FormBuilderTextField(
                name: 'name',
                initialValue: config?.name,
                decoration: const InputDecoration(
                  labelText: 'Printer Name *',
                  hintText: 'Enter a name for this printer',
                ),
                validator: FormBuilderValidators.required(),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Connection Type
              FormBuilderChoiceChips<PrinterConnectionType>(
                name: 'connectionType',
                initialValue: config?.connectionType ?? PrinterConnectionType.bluetooth,
                decoration: const InputDecoration(
                  labelText: 'Connection Type *',
                  border: InputBorder.none,
                ),
                options: PrinterConnectionType.values
                    .map(
                      (type) => FormBuilderChipOption<PrinterConnectionType>(
                        value: type,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(type.icon, size: 18),
                            const SizedBox(width: 4),
                            Text(type.displayName),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedConnectionType.value = value;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Address field with discovery button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'address',
                      initialValue: config?.address,
                      decoration: InputDecoration(
                        labelText: selectedConnectionType.value ==
                                PrinterConnectionType.bluetooth
                            ? 'MAC Address *'
                            : 'IP Address *',
                        hintText: selectedConnectionType.value ==
                                PrinterConnectionType.bluetooth
                            ? 'e.g., 00:11:22:33:44:55'
                            : 'e.g., 192.168.1.100',
                      ),
                      validator: FormBuilderValidators.required(),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  if (selectedConnectionType.value ==
                      PrinterConnectionType.bluetooth) ...[
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: IconButton.outlined(
                        onPressed: showDiscoverySheet,
                        icon: const Icon(Icons.search),
                        tooltip: 'Discover Printers',
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // Port field (only for network)
              if (selectedConnectionType.value == PrinterConnectionType.network)
                FormBuilderTextField(
                  name: 'port',
                  initialValue: (config?.port ?? 9100).toString(),
                  decoration: const InputDecoration(
                    labelText: 'Port',
                    hintText: '9100 (default)',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              if (selectedConnectionType.value == PrinterConnectionType.network)
                const SizedBox(height: 16),

              // Paper Width
              FormBuilderDropdown<PrinterPaperWidth>(
                name: 'paperWidth',
                initialValue: config?.paperWidth ?? PrinterPaperWidth.mm80,
                decoration: const InputDecoration(
                  labelText: 'Paper Width',
                ),
                items: PrinterPaperWidth.values
                    .map(
                      (width) => DropdownMenuItem(
                        value: width,
                        child: Text(width.displayName),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Default printer toggle
              FormBuilderSwitch(
                name: 'isDefault',
                initialValue: config?.isDefault ?? false,
                title: const Text('Set as default printer'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),

              // Enabled toggle
              FormBuilderSwitch(
                name: 'isEnabled',
                initialValue: config?.isEnabled ?? true,
                title: const Text('Printer enabled'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  String? _nullIfEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim();
  }
}
