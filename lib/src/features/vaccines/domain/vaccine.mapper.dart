// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vaccine.dart';

class VaccineMapper extends ClassMapperBase<Vaccine> {
  VaccineMapper._();

  static VaccineMapper? _instance;
  static VaccineMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VaccineMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Vaccine';

  static String _$id(Vaccine v) => v.id;
  static const Field<Vaccine, String> _f$id = Field('id', _$id);
  static String _$name(Vaccine v) => v.name;
  static const Field<Vaccine, String> _f$name = Field('name', _$name);
  static String? _$icon(Vaccine v) => v.icon;
  static const Field<Vaccine, String> _f$icon = Field('icon', _$icon);
  static DateTime? _$created(Vaccine v) => v.created;
  static const Field<Vaccine, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(Vaccine v) => v.updated;
  static const Field<Vaccine, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<Vaccine> fields = const {
    #id: _f$id,
    #name: _f$name,
    #icon: _f$icon,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Vaccine _instantiate(DecodingData data) {
    return Vaccine(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        icon: data.dec(_f$icon),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Vaccine fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Vaccine>(map);
  }

  static Vaccine fromJson(String json) {
    return ensureInitialized().decodeJson<Vaccine>(json);
  }
}

mixin VaccineMappable {
  String toJson() {
    return VaccineMapper.ensureInitialized()
        .encodeJson<Vaccine>(this as Vaccine);
  }

  Map<String, dynamic> toMap() {
    return VaccineMapper.ensureInitialized()
        .encodeMap<Vaccine>(this as Vaccine);
  }

  VaccineCopyWith<Vaccine, Vaccine, Vaccine> get copyWith =>
      _VaccineCopyWithImpl(this as Vaccine, $identity, $identity);
  @override
  String toString() {
    return VaccineMapper.ensureInitialized().stringifyValue(this as Vaccine);
  }

  @override
  bool operator ==(Object other) {
    return VaccineMapper.ensureInitialized()
        .equalsValue(this as Vaccine, other);
  }

  @override
  int get hashCode {
    return VaccineMapper.ensureInitialized().hashValue(this as Vaccine);
  }
}

extension VaccineValueCopy<$R, $Out> on ObjectCopyWith<$R, Vaccine, $Out> {
  VaccineCopyWith<$R, Vaccine, $Out> get $asVaccine =>
      $base.as((v, t, t2) => _VaccineCopyWithImpl(v, t, t2));
}

abstract class VaccineCopyWith<$R, $In extends Vaccine, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? icon,
      DateTime? created,
      DateTime? updated});
  VaccineCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VaccineCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Vaccine, $Out>
    implements VaccineCopyWith<$R, Vaccine, $Out> {
  _VaccineCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Vaccine> $mapper =
      VaccineMapper.ensureInitialized();
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
  Vaccine $make(CopyWithData data) => Vaccine(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      icon: data.get(#icon, or: $value.icon),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  VaccineCopyWith<$R2, Vaccine, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VaccineCopyWithImpl($value, $cast, t);
}
