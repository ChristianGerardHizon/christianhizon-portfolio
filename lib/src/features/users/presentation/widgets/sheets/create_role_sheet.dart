import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/user_role.dart';
import '../../controllers/user_roles_controller.dart';
import '../permission_category_widget.dart';

/// Bottom sheet for creating a new user role.
class CreateRoleSheet extends HookConsumerWidget {
  const CreateRoleSheet({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);

    // Track selected permissions
    final selectedPermissions = useState<Set<String>>({});

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

      // Create role object
      final role = UserRole(
        id: '',
        name: (values['name'] as String).trim(),
        description: _nullIfEmpty(values['description'] as String?),
        permissions: selectedPermissions.value.toList(),
        isSystem: false,
      );

      final success = await ref
          .read(userRolesControllerProvider.notifier)
          .createRole(role);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to create role. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();
        showSuccessSnackBar(context, message: 'Role created successfully');
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
                    child:
                        Text('Create Role', style: theme.textTheme.titleLarge),
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

              // === BASIC INFORMATION SECTION ===
              _SectionHeader(
                title: 'Role Information',
                icon: Icons.admin_panel_settings,
              ),
              const SizedBox(height: 16),

              // Name (required)
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Role Name *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                enabled: !isSaving.value,
                textCapitalization: TextCapitalization.words,
                validator: FormBuilderValidators.required(
                  errorText: 'Role name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Description
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                enabled: !isSaving.value,
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // === PERMISSIONS SECTION ===
              _SectionHeader(
                title: 'Permissions',
                icon: Icons.security,
              ),
              const SizedBox(height: 8),

              // Permission count badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${selectedPermissions.value.length} permission${selectedPermissions.value.length == 1 ? '' : 's'} selected',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Permission categories
              ...Permissions.allPermissionsByCategory.entries.map((entry) {
                return PermissionCategoryWidget(
                  category: entry.key,
                  permissions: entry.value,
                  selectedPermissions: selectedPermissions.value,
                  enabled: !isSaving.value,
                  onChanged: (permission, selected) {
                    final newSet = Set<String>.from(selectedPermissions.value);
                    if (selected) {
                      newSet.add(permission);
                    } else {
                      newSet.remove(permission);
                    }
                    selectedPermissions.value = newSet;
                  },
                  onSelectAll: (permissions, selectAll) {
                    final newSet = Set<String>.from(selectedPermissions.value);
                    if (selectAll) {
                      newSet.addAll(permissions);
                    } else {
                      newSet.removeAll(permissions);
                    }
                    selectedPermissions.value = newSet;
                  },
                );
              }),
              const SizedBox(height: 24),
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

  static const _fieldLabels = {
    'name': 'Role Name',
    'description': 'Description',
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

/// Shows the create role sheet as a modal bottom sheet.
void showCreateRoleSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => CreateRoleSheet(
        scrollController: scrollController,
      ),
    ),
  );
}
