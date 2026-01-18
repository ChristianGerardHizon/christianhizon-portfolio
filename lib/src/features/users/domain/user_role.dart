import 'package:dart_mappable/dart_mappable.dart';

part 'user_role.mapper.dart';

/// UserRole domain model.
///
/// Role definitions with permissions for access control.
@MappableClass()
class UserRole with UserRoleMappable {
  const UserRole({
    required this.id,
    required this.name,
    this.description,
    this.permissions = const [],
    this.isSystem = false,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Role name (e.g., "Admin", "Veterinarian", "Staff").
  final String name;

  /// Role description.
  final String? description;

  /// List of permission keys.
  final List<String> permissions;

  /// Whether this is a system-defined role (cannot be deleted).
  final bool isSystem;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Check if role has a specific permission.
  bool hasPermission(String permission) => permissions.contains(permission);

  /// Check if role has admin permission.
  bool get isAdmin => permissions.contains('system.admin');

  /// Get permission count display.
  String get permissionCountDisplay =>
      '${permissions.length} permission${permissions.length == 1 ? '' : 's'}';
}

/// Permission keys used in the system.
abstract class Permissions {
  // Patient permissions
  static const patientsView = 'patients.view';
  static const patientsCreate = 'patients.create';
  static const patientsEdit = 'patients.edit';
  static const patientsDelete = 'patients.delete';

  // Records permissions
  static const recordsView = 'records.view';
  static const recordsCreate = 'records.create';
  static const recordsEdit = 'records.edit';
  static const recordsDelete = 'records.delete';

  // Prescriptions permissions
  static const prescriptionsView = 'prescriptions.view';
  static const prescriptionsCreate = 'prescriptions.create';
  static const prescriptionsEdit = 'prescriptions.edit';
  static const prescriptionsDelete = 'prescriptions.delete';

  // Appointments permissions
  static const appointmentsView = 'appointments.view';
  static const appointmentsCreate = 'appointments.create';
  static const appointmentsEdit = 'appointments.edit';
  static const appointmentsDelete = 'appointments.delete';

  // Products permissions
  static const productsView = 'products.view';
  static const productsCreate = 'products.create';
  static const productsEdit = 'products.edit';
  static const productsDelete = 'products.delete';

  // Inventory permissions
  static const inventoryView = 'inventory.view';
  static const inventoryAdjust = 'inventory.adjust';

  // Sales permissions
  static const salesView = 'sales.view';
  static const salesCreate = 'sales.create';

  // Users permissions
  static const usersView = 'users.view';
  static const usersCreate = 'users.create';
  static const usersEdit = 'users.edit';
  static const usersDelete = 'users.delete';

  // Roles permissions
  static const rolesView = 'roles.view';
  static const rolesCreate = 'roles.create';
  static const rolesEdit = 'roles.edit';
  static const rolesDelete = 'roles.delete';

  // Branches permissions
  static const branchesView = 'branches.view';
  static const branchesCreate = 'branches.create';
  static const branchesEdit = 'branches.edit';
  static const branchesDelete = 'branches.delete';

  // Settings permissions
  static const settingsView = 'settings.view';
  static const settingsEdit = 'settings.edit';

  // System permissions
  static const systemAdmin = 'system.admin';

  /// All permissions grouped by category.
  static const Map<String, List<String>> allByCategory = {
    'Patients': [patientsView, patientsCreate, patientsEdit, patientsDelete],
    'Records': [recordsView, recordsCreate, recordsEdit, recordsDelete],
    'Prescriptions': [
      prescriptionsView,
      prescriptionsCreate,
      prescriptionsEdit,
      prescriptionsDelete,
    ],
    'Appointments': [
      appointmentsView,
      appointmentsCreate,
      appointmentsEdit,
      appointmentsDelete,
    ],
    'Products': [productsView, productsCreate, productsEdit, productsDelete],
    'Inventory': [inventoryView, inventoryAdjust],
    'Sales': [salesView, salesCreate],
    'Users': [usersView, usersCreate, usersEdit, usersDelete],
    'Roles': [rolesView, rolesCreate, rolesEdit, rolesDelete],
    'Branches': [branchesView, branchesCreate, branchesEdit, branchesDelete],
    'Settings': [settingsView, settingsEdit],
    'System': [systemAdmin],
  };

  /// Get display name for a permission key.
  static String displayName(String permission) {
    final parts = permission.split('.');
    if (parts.length != 2) return permission;
    final action = parts[1];
    return action[0].toUpperCase() + action.substring(1);
  }
}
