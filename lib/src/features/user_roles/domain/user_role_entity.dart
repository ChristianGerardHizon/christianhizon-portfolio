import 'package:dart_mappable/dart_mappable.dart';

part 'user_role_entity.mapper.dart';

/// User role entity from the user_roles collection.
///
/// Represents the role assigned to a user with permission flags.
@MappableClass()
class UserRoleEntity with UserRoleEntityMappable {
  /// The role's unique ID.
  final String id;

  /// Whether this role has admin privileges.
  final bool isAdmin;

  final String userId;

  const UserRoleEntity({
    required this.id,
    required this.userId,
    this.isAdmin = false,
  });
}
