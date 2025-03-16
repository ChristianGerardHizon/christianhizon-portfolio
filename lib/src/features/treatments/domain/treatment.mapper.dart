// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment.dart';

class TreatmentMapper extends ClassMapperBase<Treatment> {
  TreatmentMapper._();

  static TreatmentMapper? _instance;
  static TreatmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Treatment';

  static String _$id(Treatment v) => v.id;
  static const Field<Treatment, String> _f$id = Field('id', _$id);
  static String _$name(Treatment v) => v.name;
  static const Field<Treatment, String> _f$name = Field('name', _$name);
  static String? _$icon(Treatment v) => v.icon;
  static const Field<Treatment, String> _f$icon = Field('icon', _$icon);
  static DateTime? _$created(Treatment v) => v.created;
  static const Field<Treatment, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(Treatment v) => v.updated;
  static const Field<Treatment, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<Treatment> fields = const {
    #id: _f$id,
    #name: _f$name,
    #icon: _f$icon,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Treatment _instantiate(DecodingData data) {
    return Treatment(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        icon: data.dec(_f$icon),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Treatment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Treatment>(map);
  }

  static Treatment fromJson(String json) {
    return ensureInitialized().decodeJson<Treatment>(json);
  }
}

mixin TreatmentMappable {
  String toJson() {
    return TreatmentMapper.ensureInitialized()
        .encodeJson<Treatment>(this as Treatment);
  }

  Map<String, dynamic> toMap() {
    return TreatmentMapper.ensureInitialized()
        .encodeMap<Treatment>(this as Treatment);
  }

  TreatmentCopyWith<Treatment, Treatment, Treatment> get copyWith =>
      _TreatmentCopyWithImpl<Treatment, Treatment>(
          this as Treatment, $identity, $identity);
  @override
  String toString() {
    return TreatmentMapper.ensureInitialized()
        .stringifyValue(this as Treatment);
  }

  @override
  bool operator ==(Object other) {
    return TreatmentMapper.ensureInitialized()
        .equalsValue(this as Treatment, other);
  }

  @override
  int get hashCode {
    return TreatmentMapper.ensureInitialized().hashValue(this as Treatment);
  }
}

extension TreatmentValueCopy<$R, $Out> on ObjectCopyWith<$R, Treatment, $Out> {
  TreatmentCopyWith<$R, Treatment, $Out> get $asTreatment =>
      $base.as((v, t, t2) => _TreatmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TreatmentCopyWith<$R, $In extends Treatment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? icon,
      DateTime? created,
      DateTime? updated});
  TreatmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TreatmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Treatment, $Out>
    implements TreatmentCopyWith<$R, Treatment, $Out> {
  _TreatmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Treatment> $mapper =
      TreatmentMapper.ensureInitialized();
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
  Treatment $make(CopyWithData data) => Treatment(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      icon: data.get(#icon, or: $value.icon),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  TreatmentCopyWith<$R2, Treatment, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TreatmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
