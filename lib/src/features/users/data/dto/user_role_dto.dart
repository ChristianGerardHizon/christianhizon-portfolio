import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/user_role.dart';

part 'user_role_dto.mapper.dart';

/// Data Transfer Object for UserRole from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain UserRole.
@MappableClass()
class UserRoleDto with UserRoleDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? description;
  final List<String> permissions;
  final bool isSystem;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const UserRoleDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.description,
    this.permissions = const [],
    this.isSystem = false,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory UserRoleDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return UserRoleDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      permissions:
          (json['permissions'] as List<dynamic>?)?.cast<String>() ?? [],
      isSystem: json['isSystem'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain UserRole entity.
  UserRole toEntity() {
    return UserRole(
      id: id,
      name: name,
      description: description,
      permissions: permissions,
      isSystem: isSystem,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }
}
