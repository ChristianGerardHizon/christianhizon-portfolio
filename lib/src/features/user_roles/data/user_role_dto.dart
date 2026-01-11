import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../domain/user_role_entity.dart';

part 'user_role_dto.mapper.dart';

/// Data Transfer Object for UserRole from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain UserRoleEntity.
@MappableClass()
class UserRoleDto with UserRoleDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final bool isAdmin;
  final String user;

  const UserRoleDto({
    required this.id,
    required this.user,
    required this.collectionId,
    required this.collectionName,
    this.isAdmin = false,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory UserRoleDto.fromRecord(RecordModel record) =>
      UserRoleDtoMapper.fromMap(record.toJson());

  /// Converts the DTO to a domain UserRoleEntity.
  UserRoleEntity toEntity() {
    return UserRoleEntity(
      id: id,
      userId: id,
      isAdmin: isAdmin,
    );
  }
}
