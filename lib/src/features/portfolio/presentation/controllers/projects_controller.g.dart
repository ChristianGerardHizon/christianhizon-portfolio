// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing portfolio projects list.

@ProviderFor(ProjectsController)
final projectsControllerProvider = ProjectsControllerProvider._();

/// Controller for managing portfolio projects list.
final class ProjectsControllerProvider
    extends $AsyncNotifierProvider<ProjectsController, List<Project>> {
  /// Controller for managing portfolio projects list.
  ProjectsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'projectsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$projectsControllerHash();

  @$internal
  @override
  ProjectsController create() => ProjectsController();
}

String _$projectsControllerHash() =>
    r'baea04591315fd88e962ee07a92db73580f37bea';

/// Controller for managing portfolio projects list.

abstract class _$ProjectsController extends $AsyncNotifier<List<Project>> {
  FutureOr<List<Project>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Project>>, List<Project>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Project>>, List<Project>>,
        AsyncValue<List<Project>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for featured projects only.

@ProviderFor(featuredProjects)
final featuredProjectsProvider = FeaturedProjectsProvider._();

/// Provider for featured projects only.

final class FeaturedProjectsProvider extends $FunctionalProvider<
        AsyncValue<List<Project>>, List<Project>, FutureOr<List<Project>>>
    with $FutureModifier<List<Project>>, $FutureProvider<List<Project>> {
  /// Provider for featured projects only.
  FeaturedProjectsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'featuredProjectsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$featuredProjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<Project>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Project>> create(Ref ref) {
    return featuredProjects(ref);
  }
}

String _$featuredProjectsHash() => r'93505ae484ebc6037a5bca8cbe1832f93d09dbd4';

/// Provider for a single project by ID.

@ProviderFor(projectById)
final projectByIdProvider = ProjectByIdFamily._();

/// Provider for a single project by ID.

final class ProjectByIdProvider extends $FunctionalProvider<
        AsyncValue<Project?>, Project?, FutureOr<Project?>>
    with $FutureModifier<Project?>, $FutureProvider<Project?> {
  /// Provider for a single project by ID.
  ProjectByIdProvider._(
      {required ProjectByIdFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'projectByIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$projectByIdHash();

  @override
  String toString() {
    return r'projectByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Project?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Project?> create(Ref ref) {
    final argument = this.argument as String;
    return projectById(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectByIdHash() => r'03dfa009be68fd1a37416663f5ce3e168372d625';

/// Provider for a single project by ID.

final class ProjectByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Project?>, String> {
  ProjectByIdFamily._()
      : super(
          retry: null,
          name: r'projectByIdProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single project by ID.

  ProjectByIdProvider call(
    String id,
  ) =>
      ProjectByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'projectByIdProvider';
}

/// Provider for "Other Projects" — all projects except the current one, up to 3.

@ProviderFor(otherProjects)
final otherProjectsProvider = OtherProjectsFamily._();

/// Provider for "Other Projects" — all projects except the current one, up to 3.

final class OtherProjectsProvider extends $FunctionalProvider<
        AsyncValue<List<Project>>, List<Project>, FutureOr<List<Project>>>
    with $FutureModifier<List<Project>>, $FutureProvider<List<Project>> {
  /// Provider for "Other Projects" — all projects except the current one, up to 3.
  OtherProjectsProvider._(
      {required OtherProjectsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'otherProjectsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$otherProjectsHash();

  @override
  String toString() {
    return r'otherProjectsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Project>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Project>> create(Ref ref) {
    final argument = this.argument as String;
    return otherProjects(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OtherProjectsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$otherProjectsHash() => r'0437ae6377870f4c0e9d2868de8ca1aef1e1a458';

/// Provider for "Other Projects" — all projects except the current one, up to 3.

final class OtherProjectsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Project>>, String> {
  OtherProjectsFamily._()
      : super(
          retry: null,
          name: r'otherProjectsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for "Other Projects" — all projects except the current one, up to 3.

  OtherProjectsProvider call(
    String currentId,
  ) =>
      OtherProjectsProvider._(argument: currentId, from: this);

  @override
  String toString() => r'otherProjectsProvider';
}
