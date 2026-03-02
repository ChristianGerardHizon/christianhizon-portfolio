import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/projects_repository.dart';
import '../../domain/project.dart';

part 'projects_controller.g.dart';

/// Controller for managing portfolio projects list.
@riverpod
class ProjectsController extends _$ProjectsController {
  @override
  Future<List<Project>> build() async {
    final repo = ref.watch(projectsRepositoryProvider);
    final result = await repo.getProjects();
    return result.fold(
      (failure) => [],
      (projects) => projects,
    );
  }

  /// Create a new project.
  Future<bool> create(
    Map<String, dynamic> data, {
    List<http.MultipartFile> files = const [],
  }) async {
    final repo = ref.read(projectsRepositoryProvider);
    final result = await repo.createProject(data, files: files);
    return result.fold(
      (failure) => false,
      (project) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  /// Update an existing project.
  Future<bool> updateProject(
    String id,
    Map<String, dynamic> data, {
    List<http.MultipartFile> files = const [],
  }) async {
    final repo = ref.read(projectsRepositoryProvider);
    final result = await repo.updateProject(id, data, files: files);
    return result.fold(
      (failure) => false,
      (project) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  /// Delete a project.
  Future<bool> delete(String id) async {
    final repo = ref.read(projectsRepositoryProvider);
    final result = await repo.deleteProject(id);
    return result.fold(
      (failure) => false,
      (_) {
        ref.invalidateSelf();
        return true;
      },
    );
  }
}

/// Provider for featured projects only.
@riverpod
Future<List<Project>> featuredProjects(Ref ref) async {
  final repo = ref.watch(projectsRepositoryProvider);
  final result = await repo.getFeaturedProjects();
  return result.fold(
    (failure) => [],
    (projects) => projects,
  );
}

/// Provider for a single project by ID.
@riverpod
Future<Project?> projectById(Ref ref, String id) async {
  final repo = ref.watch(projectsRepositoryProvider);
  final result = await repo.getProject(id);
  return result.fold(
    (_) => null,
    (project) => project,
  );
}
