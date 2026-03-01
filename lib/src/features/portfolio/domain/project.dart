import 'package:dart_mappable/dart_mappable.dart';

part 'project.mapper.dart';

/// Project status enum.
@MappableEnum()
enum ProjectStatus {
  active,
  archived,
  @MappableValue('in_progress')
  inProgress;
}

/// Portfolio project model.
@MappableClass()
class Project with ProjectMappable {
  final String id;
  final String title;
  final String description;
  final String longDescription;
  final String thumbnail;
  final List<String> gallery;
  final String projectUrl;
  final String sourceUrl;
  final List<String> techStack;
  final String category;
  final ProjectStatus status;
  final bool featured;
  final int sortOrder;
  final String collectionId;
  final String client;
  final String role;
  final String timeline;

  const Project({
    required this.id,
    required this.title,
    this.description = '',
    this.longDescription = '',
    this.thumbnail = '',
    this.gallery = const [],
    this.projectUrl = '',
    this.sourceUrl = '',
    this.techStack = const [],
    this.category = '',
    this.status = ProjectStatus.active,
    this.featured = false,
    this.sortOrder = 0,
    this.collectionId = '',
    this.client = '',
    this.role = '',
    this.timeline = '',
  });

  static const collectionName = 'projects';

  /// Gets the full URL for the thumbnail image.
  String thumbnailUrl(String baseUrl) {
    if (thumbnail.isEmpty) return '';
    return '$baseUrl/api/files/$collectionId/$id/$thumbnail';
  }

  /// Gets full URLs for gallery images.
  List<String> galleryUrls(String baseUrl) {
    return gallery
        .map((img) => '$baseUrl/api/files/$collectionId/$id/$img')
        .toList();
  }
}
