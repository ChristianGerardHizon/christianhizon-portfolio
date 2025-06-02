// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'system_version.dart';

class SystemVersionMapper extends ClassMapperBase<SystemVersion> {
  SystemVersionMapper._();

  static SystemVersionMapper? _instance;
  static SystemVersionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SystemVersionMapper._());
      PbRecordMapper.ensureInitialized();
      SystemArtifactMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SystemVersion';

  static String _$id(SystemVersion v) => v.id;
  static const Field<SystemVersion, String> _f$id = Field('id', _$id);
  static String _$collectionId(SystemVersion v) => v.collectionId;
  static const Field<SystemVersion, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(SystemVersion v) => v.collectionName;
  static const Field<SystemVersion, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(SystemVersion v) => v.isDeleted;
  static const Field<SystemVersion, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(SystemVersion v) => v.created;
  static const Field<SystemVersion, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(SystemVersion v) => v.updated;
  static const Field<SystemVersion, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static num _$buildNumber(SystemVersion v) => v.buildNumber;
  static const Field<SystemVersion, num> _f$buildNumber =
      Field('buildNumber', _$buildNumber);
  static List<SystemArtifact> _$artifacts(SystemVersion v) => v.artifacts;
  static const Field<SystemVersion, List<SystemArtifact>> _f$artifacts =
      Field('artifacts', _$artifacts, opt: true, def: const []);

  @override
  final MappableFields<SystemVersion> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #buildNumber: _f$buildNumber,
    #artifacts: _f$artifacts,
  };

  static SystemVersion _instantiate(DecodingData data) {
    return SystemVersion(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        buildNumber: data.dec(_f$buildNumber),
        artifacts: data.dec(_f$artifacts));
  }

  @override
  final Function instantiate = _instantiate;

  static SystemVersion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SystemVersion>(map);
  }

  static SystemVersion fromJson(String json) {
    return ensureInitialized().decodeJson<SystemVersion>(json);
  }
}

mixin SystemVersionMappable {
  String toJson() {
    return SystemVersionMapper.ensureInitialized()
        .encodeJson<SystemVersion>(this as SystemVersion);
  }

  Map<String, dynamic> toMap() {
    return SystemVersionMapper.ensureInitialized()
        .encodeMap<SystemVersion>(this as SystemVersion);
  }

  SystemVersionCopyWith<SystemVersion, SystemVersion, SystemVersion>
      get copyWith => _SystemVersionCopyWithImpl<SystemVersion, SystemVersion>(
          this as SystemVersion, $identity, $identity);
  @override
  String toString() {
    return SystemVersionMapper.ensureInitialized()
        .stringifyValue(this as SystemVersion);
  }

  @override
  bool operator ==(Object other) {
    return SystemVersionMapper.ensureInitialized()
        .equalsValue(this as SystemVersion, other);
  }

  @override
  int get hashCode {
    return SystemVersionMapper.ensureInitialized()
        .hashValue(this as SystemVersion);
  }
}

extension SystemVersionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SystemVersion, $Out> {
  SystemVersionCopyWith<$R, SystemVersion, $Out> get $asSystemVersion =>
      $base.as((v, t, t2) => _SystemVersionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SystemVersionCopyWith<$R, $In extends SystemVersion, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SystemArtifact,
      SystemArtifactCopyWith<$R, SystemArtifact, SystemArtifact>> get artifacts;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated,
      num? buildNumber,
      List<SystemArtifact>? artifacts});
  SystemVersionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SystemVersionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SystemVersion, $Out>
    implements SystemVersionCopyWith<$R, SystemVersion, $Out> {
  _SystemVersionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SystemVersion> $mapper =
      SystemVersionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SystemArtifact,
          SystemArtifactCopyWith<$R, SystemArtifact, SystemArtifact>>
      get artifacts => ListCopyWith($value.artifacts,
          (v, t) => v.copyWith.$chain(t), (v) => call(artifacts: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none,
          num? buildNumber,
          List<SystemArtifact>? artifacts}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (buildNumber != null) #buildNumber: buildNumber,
        if (artifacts != null) #artifacts: artifacts
      }));
  @override
  SystemVersion $make(CopyWithData data) => SystemVersion(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      buildNumber: data.get(#buildNumber, or: $value.buildNumber),
      artifacts: data.get(#artifacts, or: $value.artifacts));

  @override
  SystemVersionCopyWith<$R2, SystemVersion, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SystemVersionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
