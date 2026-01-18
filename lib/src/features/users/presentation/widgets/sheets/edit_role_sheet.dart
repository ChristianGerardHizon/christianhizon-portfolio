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

/// Bottom sheet for editing a user role.
class EditRoleSheet extends HookConsumerWidget {
  const EditRoleSheet({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);

    // Track selected permissions (initialize with existing)
    final selectedPermissions = useState<Set<String>>(
      Set<String>.from(role.permissions),
    );

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

      // Create updated role object
      final updatedRole = UserRole(
        id: role.id,
        name: (values['name'] as String).trim(),
        description: _nullIfEmpty(values['description'] as String?),
        permissions: selectedPermissions.value.toList(),
        isSystem: role.isSystem,
        isDeleted: role.isDeleted,
        created: role.created,
        updated: role.updated,
      );

      final success = await ref
          .read(userRolesControllerProvider.notifier)
          .updateRole(updatedRole);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to update role. Please try again.'],
          );
        }
        return;
      }

      if (context.mounted) {
        isSaving.value = false;
        context.pop();
        showSuccessSnackBar(context, message: 'Role updated successfully');
      }
    }

    // Check if editing is restricted (system role)
    final isRestricted = role.isSystem;

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
                    child: Row(
                      children: [
                        Text('Edit Role', style: theme.textTheme.titleLarge),
                        if (role.isSystem) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'System',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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
              const SizedBox(height: 16),

              // System role warning
              if (isRestricted) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: theme.colorScheme.onTertiaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This is a system role. Some fields may be restricted.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // === BASIC INFORMATION SECTION ===
              _SectionHeader(
                title: 'Role Information',
                icon: Icons.admin_panel_settings,
              ),
              const SizedBox(height: 16),

              // Name (required)
              FormBuilderTextField(
                name: 'name',
                initialValue: role.name,
                decoration: const InputDecoration(
                  labelText: 'Role Name *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                enabled: !isSaving.value && !isRestricted,
                textCapitalization: TextCapitalization.words,
                validator: FormBuilderValidators.required(
                  errorText: 'Role name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Description
              FormBuilderTextField(
                name: 'description',
                initialValue: role.description,
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
              ...Permissions.allByCategory.entries.map((entry) {
                return _PermissionCategory(
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

class _PermissionCategory extends StatelessWidget {
  const _PermissionCategory({
    required this.category,
    required this.permissions,
    required this.selectedPermissions,
    required this.enabled,
    required this.onChanged,
    required this.onSelectAll,
  });

  final String category;
  final List<String> permissions;
  final Set<String> selectedPermissions;
  final bool enabled;
  final void Function(String permission, bool selected) onChanged;
  final void Function(List<String> permissions, bool selectAll) onSelectAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selectedCount = permissions.where(
      (p) => selectedPermissions.contains(p),
    ).length;
    final allSelected = selectedCount == permissions.length;
    final someSelected = selectedCount > 0 && !allSelected;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(_getCategoryIcon(category), color: theme.colorScheme.primary),
        title: Row(
          children: [
            Text(
              category,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            if (selectedCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$selectedCount',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: allSelected ? true : (someSelected ? null : false),
              tristate: true,
              onChanged: enabled
                  ? (value) => onSelectAll(permissions, value == true)
                  : null,
            ),
          ],
        ),
        children: permissions.map((permission) {
          final isSelected = selectedPermissions.contains(permission);
          return CheckboxListTile(
            value: isSelected,
            onChanged: enabled
                ? (value) => onChanged(permission, value ?? false)
                : null,
            title: Text(
              Permissions.displayName(permission),
              style: theme.textTheme.bodyMedium,
            ),
            subtitle: Text(
              permission,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
                fontFamily: 'monospace',
              ),
            ),
            secondary: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              size: 20,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
            ),
            dense: true,
          );
        }).toList(),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'System':
        return Icons.settings;
      case 'Users':
        return Icons.people;
      case 'Patients':
        return Icons.pets;
      case 'Records':
        return Icons.medical_services;
      case 'Prescriptions':
        return Icons.medication;
      case 'Appointments':
        return Icons.calendar_today;
      case 'Products':
        return Icons.inventory;
      case 'Inventory':
        return Icons.warehouse;
      case 'Sales':
        return Icons.point_of_sale;
      case 'Roles':
        return Icons.admin_panel_settings;
      case 'Branches':
        return Icons.business;
      case 'Settings':
        return Icons.tune;
      default:
        return Icons.key;
    }
  }
}

/// Shows the edit role sheet as a modal bottom sheet.
void showEditRoleSheet(BuildContext context, UserRole role) {
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
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: EditRoleSheet(role: role),
      ),
    ),
  );
}
