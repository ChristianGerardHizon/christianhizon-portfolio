// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'history_type.dart';

class HistoryTypeMapper extends ClassMapperBase<HistoryType> {
  HistoryTypeMapper._();

  static HistoryTypeMapper? _instance;
  static HistoryTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HistoryTypeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HistoryType';

  static String _$id(HistoryType v) => v.id;
  static const Field<HistoryType, String> _f$id = Field('id', _$id);
  static String _$name(HistoryType v) => v.name;
  static const Field<HistoryType, String> _f$name = Field('name', _$name);
  static String? _$icon(HistoryType v) => v.icon;
  static const Field<HistoryType, String> _f$icon = Field('icon', _$icon);
  static DateTime? _$created(HistoryType v) => v.created;
  static const Field<HistoryType, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(HistoryType v) => v.updated;
  static const Field<HistoryType, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<HistoryType> fields = const {
    #id: _f$id,
    #name: _f$name,
    #icon: _f$icon,
    #created: _f$created,
    #updated: _f$updated,
  };

  static HistoryType _instantiate(DecodingData data) {
    return HistoryType(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        icon: data.dec(_f$icon),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static HistoryType fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HistoryType>(map);
  }

  static HistoryType fromJson(String json) {
    return ensureInitialized().decodeJson<HistoryType>(json);
  }
}

mixin HistoryTypeMappable {
  String toJson() {
    return HistoryTypeMapper.ensureInitialized()
        .encodeJson<HistoryType>(this as HistoryType);
  }

  Map<String, dynamic> toMap() {
    return HistoryTypeMapper.ensureInitialized()
        .encodeMap<HistoryType>(this as HistoryType);
  }

  HistoryTypeCopyWith<HistoryType, HistoryType, HistoryType> get copyWith =>
      _HistoryTypeCopyWithImpl(this as HistoryType, $identity, $identity);
  @override
  String toString() {
    return HistoryTypeMapper.ensureInitialized()
        .stringifyValue(this as HistoryType);
  }

  @override
  bool operator ==(Object other) {
    return HistoryTypeMapper.ensureInitialized()
        .equalsValue(this as HistoryType, other);
  }

  @override
  int get hashCode {
    return HistoryTypeMapper.ensureInitialized().hashValue(this as HistoryType);
  }
}

extension HistoryTypeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HistoryType, $Out> {
  HistoryTypeCopyWith<$R, HistoryType, $Out> get $asHistoryType =>
      $base.as((v, t, t2) => _HistoryTypeCopyWithImpl(v, t, t2));
}

abstract class HistoryTypeCopyWith<$R, $In extends HistoryType, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? icon,
      DateTime? created,
      DateTime? updated});
  HistoryTypeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HistoryTypeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HistoryType, $Out>
    implements HistoryTypeCopyWith<$R, HistoryType, $Out> {
  _HistoryTypeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HistoryType> $mapper =
      HistoryTypeMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          Object? icon = $none,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (icon != $none) #icon: icon,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  HistoryType $make(CopyWithData data) => HistoryType(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      icon: data.get(#icon, or: $value.icon),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  HistoryTypeCopyWith<$R2, HistoryType, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HistoryTypeCopyWithImpl($value, $cast, t);
}
