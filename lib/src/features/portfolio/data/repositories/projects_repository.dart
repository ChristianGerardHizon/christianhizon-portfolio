import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/project.dart';

part 'projects_repository.g.dart';

@Riverpod(keepAlive: true)
ProjectsRepository projectsRepository(Ref ref) {
  return ProjectsRepository(pb: ref.watch(pocketbaseProvider));
}

class ProjectsRepository {
  final PocketBase pb;

  ProjectsRepository({required this.pb});

  RecordService get _collection =>
      pb.collection(PocketBaseCollections.projects);

  Project _fromRecord(RecordModel record) {
    final data = record.toJson();

    // Parse techStack JSON
    List<String> techStack = [];
    if (data['techStack'] is List) {
      techStack = (data['techStack'] as List)
          .map((e) => e.toString())
          .toList();
    }

    // Parse gallery
    List<String> gallery = [];
    if (data['gallery'] is List) {
      gallery = (data['gallery'] as List)
          .map((e) => e.toString())
          .toList();
    }

    // Parse status
    ProjectStatus status = ProjectStatus.active;
    final statusStr = data['status']?.toString() ?? '';
    switch (statusStr) {
      case 'archived':
        status = ProjectStatus.archived;
        break;
      case 'in_progress':
        status = ProjectStatus.inProgress;
        break;
    }

    // Parse features JSON
    List<String> features = [];
    if (data['features'] is List) {
      features =
          (data['features'] as List).map((e) => e.toString()).toList();
    }

    // Parse responsibilities JSON
    List<String> responsibilities = [];
    if (data['responsibilities'] is List) {
      responsibilities =
          (data['responsibilities'] as List).map((e) => e.toString()).toList();
    }

    // Parse platforms JSON
    List<String> platforms = [];
    if (data['platforms'] is List) {
      platforms =
          (data['platforms'] as List).map((e) => e.toString()).toList();
    }

    return Project(
      id: record.id,
      title: data['title']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      longDescription: data['longDescription']?.toString() ?? '',
      thumbnail: data['thumbnail']?.toString() ?? '',
      gallery: gallery,
      projectUrl: data['projectUrl']?.toString() ?? '',
      sourceUrl: data['sourceUrl']?.toString() ?? '',
      techStack: techStack,
      category: data['category']?.toString() ?? '',
      status: status,
      featured: data['featured'] == true,
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
      collectionId: record.collectionId,
      client: data['client']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      timeline: data['timeline']?.toString() ?? '',
      features: features,
      responsibilities: responsibilities,
      platforms: platforms,
    );
  }

  /// Get all projects, sorted by sortOrder.
  FutureEither<List<Project>> getProjects() async {
    return TaskEither.tryCatch(
      () async {
        final result = await _collection.getFullList(sort: 'sortOrder');
        return result.map(_fromRecord).toList();
      },
      Failure.handle,
    ).run();
  }

  /// Get a single project by ID.
  FutureEither<Project> getProject(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id);
        return _fromRecord(record);
      },
      Failure.handle,
    ).run();
  }

  /// Get featured projects only.
  FutureEither<List<Project>> getFeaturedProjects() async {
    return TaskEither.tryCatch(
      () async {
        final result = await _collection.getFullList(
          sort: 'sortOrder',
          filter: 'featured = true',
        );
        return result.map(_fromRecord).toList();
      },
      Failure.handle,
    ).run();
  }

  /// Create a new project.
  FutureEither<Project> createProject(
    Map<String, dynamic> data, {
    List<http.MultipartFile> files = const [],
  }) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.create(body: data, files: files);
        return _fromRecord(record);
      },
      Failure.handle,
    ).run();
  }

  /// Update an existing project.
  FutureEither<Project> updateProject(
    String id,
    Map<String, dynamic> data, {
    List<http.MultipartFile> files = const [],
  }) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.update(id, body: data, files: files);
        return _fromRecord(record);
      },
      Failure.handle,
    ).run();
  }

  /// Delete a project.
  FutureEither<void> deleteProject(String id) async {
    return TaskEither.tryCatch(
      () async {
        await _collection.delete(id);
      },
      Failure.handle,
    ).run();
  }
}
