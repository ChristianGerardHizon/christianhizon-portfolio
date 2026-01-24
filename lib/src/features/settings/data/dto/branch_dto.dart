import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/branch.dart';

part 'branch_dto.mapper.dart';

/// Data Transfer Object for Branch from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain Branch.
@MappableClass()
class BranchDto with BranchDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? displayName;
  final String? address;
  final String? contactNumber;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const BranchDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.displayName,
    this.address,
    this.contactNumber,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory BranchDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return BranchDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      displayName: json['displayName'] as String?,
      address: json['address'] as String?,
      contactNumber: json['contactNumber'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain Branch entity.
  Branch toEntity() {
    return Branch(
      id: id,
      name: name,
      displayName: displayName,
      address: address,
      contactNumber: contactNumber,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
