import 'package:dart_mappable/dart_mappable.dart';

part 'patient.mapper.dart';

/// Sex enum for patients.
@MappableEnum()
enum PatientSex { male, female }

/// Patient domain model.
///
/// Represents an animal patient in the veterinary system.
@MappableClass()
class Patient with PatientMappable {
  const Patient({
    required this.id,
    required this.name,
    this.species,
    this.speciesId,
    this.breed,
    this.breedId,
    this.owner,
    this.contactNumber,
    this.email,
    this.address,
    this.color,
    this.sex,
    this.branch,
    this.dateOfBirth,
    this.avatar,
    this.images = const [],
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Patient name.
  final String name;

  /// Species name (expanded from FK).
  final String? species;

  /// Species FK ID.
  final String? speciesId;

  /// Breed name (expanded from FK).
  final String? breed;

  /// Breed FK ID.
  final String? breedId;

  /// Owner name.
  final String? owner;

  /// Contact phone number.
  final String? contactNumber;

  /// Email address.
  final String? email;

  /// Physical address.
  final String? address;

  /// Animal color/markings.
  final String? color;

  /// Animal sex.
  final PatientSex? sex;

  /// Branch FK ID.
  final String? branch;

  /// Date of birth.
  final DateTime? dateOfBirth;

  /// Avatar URL (full path).
  final String? avatar;

  /// List of image filenames.
  final List<String> images;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns true if patient has an avatar.
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  /// Calculates age from date of birth.
  String? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int years = now.year - dateOfBirth!.year;
    int months = now.month - dateOfBirth!.month;

    // Adjust for incomplete years
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      years--;
      months += 12;
    }

    if (now.day < dateOfBirth!.day) {
      months--;
    }

    if (months < 0) months = 0;

    if (years > 0) {
      return '$years year${years == 1 ? '' : 's'}';
    } else if (months > 0) {
      return '$months month${months == 1 ? '' : 's'}';
    } else {
      final days = now.difference(dateOfBirth!).inDays;
      return '$days day${days == 1 ? '' : 's'}';
    }
  }

  /// Display name combining owner and contact.
  String get ownerDisplay {
    if (owner == null || owner!.isEmpty) return '';
    if (contactNumber == null || contactNumber!.isEmpty) return owner!;
    return '$owner ($contactNumber)';
  }
}
