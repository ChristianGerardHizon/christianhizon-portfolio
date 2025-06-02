// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'system_artifact.dart';

class SystemArtifactMapper extends ClassMapperBase<SystemArtifact> {
  SystemArtifactMapper._();

  static SystemArtifactMapper? _instance;
  static SystemArtifactMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SystemArtifactMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SystemArtifact';

  static String _$name(SystemArtifact v) => v.name;
  static const Field<SystemArtifact, String> _f$name = Field('name', _$name);
  static String _$url(SystemArtifact v) => v.url;
  static const Field<SystemArtifact, String> _f$url = Field('url', _$url);

  @override
  final MappableFields<SystemArtifact> fields = const {
    #name: _f$name,
    #url: _f$url,
  };

  static SystemArtifact _instantiate(DecodingData data) {
    return SystemArtifact(name: data.dec(_f$name), url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static SystemArtifact fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SystemArtifact>(map);
  }

  static SystemArtifact fromJson(String json) {
    return ensureInitialized().decodeJson<SystemArtifact>(json);
  }
}

mixin SystemArtifactMappable {
  String toJson() {
    return SystemArtifactMapper.ensureInitialized()
        .encodeJson<SystemArtifact>(this as SystemArtifact);
  }

  Map<String, dynamic> toMap() {
    return SystemArtifactMapper.ensureInitialized()
        .encodeMap<SystemArtifact>(this as SystemArtifact);
  }

  SystemArtifactCopyWith<SystemArtifact, SystemArtifact, SystemArtifact>
      get copyWith =>
          _SystemArtifactCopyWithImpl<SystemArtifact, SystemArtifact>(
              this as SystemArtifact, $identity, $identity);
  @override
  String toString() {
    return SystemArtifactMapper.ensureInitialized()
        .stringifyValue(this as SystemArtifact);
  }

  @override
  bool operator ==(Object other) {
    return SystemArtifactMapper.ensureInitialized()
        .equalsValue(this as SystemArtifact, other);
  }

  @override
  int get hashCode {
    return SystemArtifactMapper.ensureInitialized()
        .hashValue(this as SystemArtifact);
  }
}

extension SystemArtifactValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SystemArtifact, $Out> {
  SystemArtifactCopyWith<$R, SystemArtifact, $Out> get $asSystemArtifact =>
      $base.as((v, t, t2) => _SystemArtifactCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SystemArtifactCopyWith<$R, $In extends SystemArtifact, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? url});
  SystemArtifactCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SystemArtifactCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SystemArtifact, $Out>
    implements SystemArtifactCopyWith<$R, SystemArtifact, $Out> {
  _SystemArtifactCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SystemArtifact> $mapper =
      SystemArtifactMapper.ensureInitialized();
  @override
  $R call({String? name, String? url}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (url != null) #url: url}));
  @override
  SystemArtifact $make(CopyWithData data) => SystemArtifact(
      name: data.get(#name, or: $value.name),
      url: data.get(#url, or: $value.url));

  @override
  SystemArtifactCopyWith<$R2, SystemArtifact, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SystemArtifactCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
