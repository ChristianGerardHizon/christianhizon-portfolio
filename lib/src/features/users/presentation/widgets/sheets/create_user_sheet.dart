import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/routing/routes/users.routes.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../settings/presentation/controllers/branches_controller.dart';
import '../../../domain/user.dart';
import '../../controllers/paginated_users_controller.dart';
import '../../controllers/user_roles_controller.dart';

/// Bottom sheet for creating a new user.
class CreateUserSheet extends HookConsumerWidget {
  const CreateUserSheet({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Form key
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // UI state
    final isSaving = useState(false);

    // Watch providers for dropdown data
    final rolesAsync = ref.watch(userRolesControllerProvider);
    final branchesAsync = ref.watch(branchesControllerProvider);

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

      // Create user object
      final user = User(
        id: '',
        name: (values['name'] as String).trim(),
        email: (values['email'] as String).trim().toLowerCase(),
        roleId: values['role'] as String?,
        branchId: values['branch'] as String?,
      );

      final password = values['password'] as String;

      final success = await ref
          .read(paginatedUsersControllerProvider.notifier)
          .createUser(user, password);

      if (!success) {
        if (context.mounted) {
          isSaving.value = false;
          showFormErrorDialog(
            context,
            errors: ['Failed to create user. Please try again.'],
          );
        }
        return;
      }

      // Get created user ID from state
      final users = ref.read(paginatedUsersControllerProvider).value;
      final createdUser = users?.items.firstOrNull;

      if (context.mounted) {
        isSaving.value = false;
        context.pop();

        showSuccessSnackBar(context, message: 'User created successfully');

        // Navigate to user detail
        if (createdUser != null) {
          UserDetailRoute(id: createdUser.id).go(context);
        }
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
                        Text('Create User', style: theme.textTheme.titleLarge),
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
                title: 'Basic Information',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              // Name (required)
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                enabled: !isSaving.value,
                textCapitalization: TextCapitalization.words,
                validator: FormBuilderValidators.required(
                  errorText: 'Name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Email (required)
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                enabled: !isSaving.value,
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Email is required',
                  ),
                  FormBuilderValidators.email(
                    errorText: 'Invalid email format',
                  ),
                ]),
              ),
              const SizedBox(height: 16),

              // Password (required for create)
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(
                  labelText: 'Password *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                enabled: !isSaving.value,
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Password is required',
                  ),
                  FormBuilderValidators.minLength(
                    8,
                    errorText: 'Password must be at least 8 characters',
                  ),
                ]),
              ),
              const SizedBox(height: 16),

              // Confirm Password
              FormBuilderTextField(
                name: 'confirmPassword',
                decoration: const InputDecoration(
                  labelText: 'Confirm Password *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                enabled: !isSaving.value,
                obscureText: true,
                validator: (value) {
                  final password =
                      formKey.currentState?.fields['password']?.value as String?;
                  if (value == null || value.isEmpty) {
                    return 'Please confirm password';
                  }
                  if (value != password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // === ASSIGNMENT SECTION ===
              _SectionHeader(
                title: 'Assignment',
                icon: Icons.assignment_ind,
              ),
              const SizedBox(height: 16),

              // Role dropdown
              rolesAsync.when(
                data: (roles) => FormBuilderDropdown<String>(
                  name: 'role',
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.admin_panel_settings),
                  ),
                  enabled: !isSaving.value,
                  items: roles.map((role) {
                    return DropdownMenuItem(
                      value: role.id,
                      child: Row(
                        children: [
                          Text(role.name),
                          if (role.isSystem) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
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
                    );
                  }).toList(),
                ),
                loading: () => const TextField(
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.admin_panel_settings),
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
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.admin_panel_settings),
                    errorText: 'Failed to load roles',
                  ),
                  enabled: false,
                ),
              ),
              const SizedBox(height: 16),

              // Branch dropdown
              branchesAsync.when(
                data: (branches) => FormBuilderDropdown<String>(
                  name: 'branch',
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
                        child: CircularProgressIndicator(strokeWidth: 2),
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
                    errorText: 'Failed to load branches',
                  ),
                  enabled: false,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  static const _fieldLabels = {
    'name': 'Name',
    'email': 'Email',
    'password': 'Password',
    'confirmPassword': 'Confirm Password',
    'role': 'Role',
    'branch': 'Branch',
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

/// Shows the create user sheet as a modal bottom sheet.
void showCreateUserSheet(BuildContext context) {
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
      builder: (context, scrollController) => CreateUserSheet(
        scrollController: scrollController,
      ),
    ),
  );
}
