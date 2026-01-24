import 'package:dart_mappable/dart_mappable.dart';

part 'branch.mapper.dart';

/// Branch domain model.
///
/// Represents a physical branch/location of the business.
@MappableClass()
class Branch with BranchMappable {
  const Branch({
    required this.id,
    required this.name,
    this.displayName,
    this.address,
    this.contactNumber,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Branch name (short internal identifier, e.g., "Main Branch").
  final String name;

  /// Display name for formal/external use (e.g., "San Jose Veterinary Clinic").
  final String? displayName;

  /// Branch address.
  final String? address;

  /// Branch contact number.
  final String? contactNumber;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
