// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'project.dart';

class ProjectStatusMapper extends EnumMapper<ProjectStatus> {
  ProjectStatusMapper._();

  static ProjectStatusMapper? _instance;
  static ProjectStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProjectStatusMapper._());
    }
    return _instance!;
  }

  static ProjectStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProjectStatus decode(dynamic value) {
    switch (value) {
      case r'active':
        return ProjectStatus.active;
      case r'archived':
        return ProjectStatus.archived;
      case 'in_progress':
        return ProjectStatus.inProgress;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProjectStatus self) {
    switch (self) {
      case ProjectStatus.active:
        return r'active';
      case ProjectStatus.archived:
        return r'archived';
      case ProjectStatus.inProgress:
        return 'in_progress';
    }
  }
}

extension ProjectStatusMapperExtension on ProjectStatus {
  dynamic toValue() {
    ProjectStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProjectStatus>(this);
  }
}

class ProjectMapper extends ClassMapperBase<Project> {
  ProjectMapper._();

  static ProjectMapper? _instance;
  static ProjectMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProjectMapper._());
      ProjectStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Project';

  static String _$id(Project v) => v.id;
  static const Field<Project, String> _f$id = Field('id', _$id);
  static String _$title(Project v) => v.title;
  static const Field<Project, String> _f$title = Field('title', _$title);
  static String _$description(Project v) => v.description;
  static const Field<Project, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$longDescription(Project v) => v.longDescription;
  static const Field<Project, String> _f$longDescription = Field(
    'longDescription',
    _$longDescription,
    opt: true,
    def: '',
  );
  static String _$thumbnail(Project v) => v.thumbnail;
  static const Field<Project, String> _f$thumbnail = Field(
    'thumbnail',
    _$thumbnail,
    opt: true,
    def: '',
  );
  static List<String> _$gallery(Project v) => v.gallery;
  static const Field<Project, List<String>> _f$gallery = Field(
    'gallery',
    _$gallery,
    opt: true,
    def: const [],
  );
  static String _$projectUrl(Project v) => v.projectUrl;
  static const Field<Project, String> _f$projectUrl = Field(
    'projectUrl',
    _$projectUrl,
    opt: true,
    def: '',
  );
  static String _$sourceUrl(Project v) => v.sourceUrl;
  static const Field<Project, String> _f$sourceUrl = Field(
    'sourceUrl',
    _$sourceUrl,
    opt: true,
    def: '',
  );
  static List<String> _$techStack(Project v) => v.techStack;
  static const Field<Project, List<String>> _f$techStack = Field(
    'techStack',
    _$techStack,
    opt: true,
    def: const [],
  );
  static String _$category(Project v) => v.category;
  static const Field<Project, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
    def: '',
  );
  static ProjectStatus _$status(Project v) => v.status;
  static const Field<Project, ProjectStatus> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: ProjectStatus.active,
  );
  static bool _$featured(Project v) => v.featured;
  static const Field<Project, bool> _f$featured = Field(
    'featured',
    _$featured,
    opt: true,
    def: false,
  );
  static int _$sortOrder(Project v) => v.sortOrder;
  static const Field<Project, int> _f$sortOrder = Field(
    'sortOrder',
    _$sortOrder,
    opt: true,
    def: 0,
  );
  static String _$collectionId(Project v) => v.collectionId;
  static const Field<Project, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
    opt: true,
    def: '',
  );
  static String _$client(Project v) => v.client;
  static const Field<Project, String> _f$client = Field(
    'client',
    _$client,
    opt: true,
    def: '',
  );
  static String _$role(Project v) => v.role;
  static const Field<Project, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
    def: '',
  );
  static String _$timeline(Project v) => v.timeline;
  static const Field<Project, String> _f$timeline = Field(
    'timeline',
    _$timeline,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Project> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #longDescription: _f$longDescription,
    #thumbnail: _f$thumbnail,
    #gallery: _f$gallery,
    #projectUrl: _f$projectUrl,
    #sourceUrl: _f$sourceUrl,
    #techStack: _f$techStack,
    #category: _f$category,
    #status: _f$status,
    #featured: _f$featured,
    #sortOrder: _f$sortOrder,
    #collectionId: _f$collectionId,
    #client: _f$client,
    #role: _f$role,
    #timeline: _f$timeline,
  };

  static Project _instantiate(DecodingData data) {
    return Project(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      longDescription: data.dec(_f$longDescription),
      thumbnail: data.dec(_f$thumbnail),
      gallery: data.dec(_f$gallery),
      projectUrl: data.dec(_f$projectUrl),
      sourceUrl: data.dec(_f$sourceUrl),
      techStack: data.dec(_f$techStack),
      category: data.dec(_f$category),
      status: data.dec(_f$status),
      featured: data.dec(_f$featured),
      sortOrder: data.dec(_f$sortOrder),
      collectionId: data.dec(_f$collectionId),
      client: data.dec(_f$client),
      role: data.dec(_f$role),
      timeline: data.dec(_f$timeline),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Project fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Project>(map);
  }

  static Project fromJson(String json) {
    return ensureInitialized().decodeJson<Project>(json);
  }
}

mixin ProjectMappable {
  String toJson() {
    return ProjectMapper.ensureInitialized().encodeJson<Project>(
      this as Project,
    );
  }

  Map<String, dynamic> toMap() {
    return ProjectMapper.ensureInitialized().encodeMap<Project>(
      this as Project,
    );
  }

  ProjectCopyWith<Project, Project, Project> get copyWith =>
      _ProjectCopyWithImpl<Project, Project>(
        this as Project,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProjectMapper.ensureInitialized().stringifyValue(this as Project);
  }

  @override
  bool operator ==(Object other) {
    return ProjectMapper.ensureInitialized().equalsValue(
      this as Project,
      other,
    );
  }

  @override
  int get hashCode {
    return ProjectMapper.ensureInitialized().hashValue(this as Project);
  }
}

extension ProjectValueCopy<$R, $Out> on ObjectCopyWith<$R, Project, $Out> {
  ProjectCopyWith<$R, Project, $Out> get $asProject =>
      $base.as((v, t, t2) => _ProjectCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProjectCopyWith<$R, $In extends Project, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get gallery;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get techStack;
  $R call({
    String? id,
    String? title,
    String? description,
    String? longDescription,
    String? thumbnail,
    List<String>? gallery,
    String? projectUrl,
    String? sourceUrl,
    List<String>? techStack,
    String? category,
    ProjectStatus? status,
    bool? featured,
    int? sortOrder,
    String? collectionId,
    String? client,
    String? role,
    String? timeline,
  });
  ProjectCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProjectCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Project, $Out>
    implements ProjectCopyWith<$R, Project, $Out> {
  _ProjectCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Project> $mapper =
      ProjectMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get gallery =>
      ListCopyWith(
        $value.gallery,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(gallery: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get techStack =>
      ListCopyWith(
        $value.techStack,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(techStack: v),
      );
  @override
  $R call({
    String? id,
    String? title,
    String? description,
    String? longDescription,
    String? thumbnail,
    List<String>? gallery,
    String? projectUrl,
    String? sourceUrl,
    List<String>? techStack,
    String? category,
    ProjectStatus? status,
    bool? featured,
    int? sortOrder,
    String? collectionId,
    String? client,
    String? role,
    String? timeline,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (longDescription != null) #longDescription: longDescription,
      if (thumbnail != null) #thumbnail: thumbnail,
      if (gallery != null) #gallery: gallery,
      if (projectUrl != null) #projectUrl: projectUrl,
      if (sourceUrl != null) #sourceUrl: sourceUrl,
      if (techStack != null) #techStack: techStack,
      if (category != null) #category: category,
      if (status != null) #status: status,
      if (featured != null) #featured: featured,
      if (sortOrder != null) #sortOrder: sortOrder,
      if (collectionId != null) #collectionId: collectionId,
      if (client != null) #client: client,
      if (role != null) #role: role,
      if (timeline != null) #timeline: timeline,
    }),
  );
  @override
  Project $make(CopyWithData data) => Project(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    longDescription: data.get(#longDescription, or: $value.longDescription),
    thumbnail: data.get(#thumbnail, or: $value.thumbnail),
    gallery: data.get(#gallery, or: $value.gallery),
    projectUrl: data.get(#projectUrl, or: $value.projectUrl),
    sourceUrl: data.get(#sourceUrl, or: $value.sourceUrl),
    techStack: data.get(#techStack, or: $value.techStack),
    category: data.get(#category, or: $value.category),
    status: data.get(#status, or: $value.status),
    featured: data.get(#featured, or: $value.featured),
    sortOrder: data.get(#sortOrder, or: $value.sortOrder),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    client: data.get(#client, or: $value.client),
    role: data.get(#role, or: $value.role),
    timeline: data.get(#timeline, or: $value.timeline),
  );

  @override
  ProjectCopyWith<$R2, Project, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProjectCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

