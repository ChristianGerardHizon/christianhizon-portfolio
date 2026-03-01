import 'package:dart_mappable/dart_mappable.dart';

part 'profile.mapper.dart';

/// Represents a skill with name and category.
@MappableClass()
class Skill with SkillMappable {
  final String name;
  final String category;

  const Skill({
    required this.name,
    required this.category,
  });
}

/// Represents a work experience entry.
@MappableClass()
class Experience with ExperienceMappable {
  final String company;
  final String role;
  final String startDate;
  final String? endDate;
  final String description;

  const Experience({
    required this.company,
    required this.role,
    required this.startDate,
    this.endDate,
    required this.description,
  });
}

/// Represents a stat displayed on the portfolio hero section.
@MappableClass()
class ProfileStat with ProfileStatMappable {
  final String value;
  final String label;

  const ProfileStat({
    required this.value,
    required this.label,
  });
}

/// Portfolio profile model.
@MappableClass()
class Profile with ProfileMappable {
  final String id;
  final String name;
  final String title;
  final String bio;
  final String photo;
  final String email;
  final String phone;
  final String location;
  final String githubUrl;
  final String linkedinUrl;
  final String websiteUrl;
  final String resumeUrl;
  final String availabilityStatus;
  final String stackOverflowUrl;
  final List<Skill> skills;
  final List<Experience> experience;
  final List<ProfileStat> stats;
  final String collectionId;

  const Profile({
    required this.id,
    required this.name,
    this.title = '',
    this.bio = '',
    this.photo = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.githubUrl = '',
    this.linkedinUrl = '',
    this.websiteUrl = '',
    this.resumeUrl = '',
    this.availabilityStatus = '',
    this.stackOverflowUrl = '',
    this.skills = const [],
    this.experience = const [],
    this.stats = const [],
    this.collectionId = '',
  });

  static const collectionName = 'profile';

  /// Gets the full URL for the profile photo.
  String photoUrl(String baseUrl) {
    if (photo.isEmpty) return '';
    return '$baseUrl/api/files/$collectionId/$id/$photo';
  }

  /// Gets the full URL for the resume file.
  String resumeFileUrl(String baseUrl) {
    if (resumeUrl.isEmpty) return '';
    return '$baseUrl/api/files/$collectionId/$id/$resumeUrl';
  }
}
