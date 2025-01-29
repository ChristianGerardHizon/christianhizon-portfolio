// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'staff.dart';

class StaffMapper extends ClassMapperBase<Staff> {
  StaffMapper._();

  static StaffMapper? _instance;
  static StaffMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StaffMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Staff';

  static String _$id(Staff v) => v.id;
  static const Field<Staff, String> _f$id = Field('id', _$id);
  static String _$name(Staff v) => v.name;
  static const Field<Staff, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$email(Staff v) => v.email;
  static const Field<Staff, String> _f$email =
      Field('email', _$email, opt: true, def: '');
  static DateTime? _$created(Staff v) => v.created;
  static const Field<Staff, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Staff v) => v.updated;
  static const Field<Staff, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<Staff> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Staff _instantiate(DecodingData data) {
    return Staff(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        email: data.dec(_f$email),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Staff fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Staff>(map);
  }

  static Staff fromJson(String json) {
    return ensureInitialized().decodeJson<Staff>(json);
  }
}

mixin StaffMappable {
  String toJson() {
    return StaffMapper.ensureInitialized().encodeJson<Staff>(this as Staff);
  }

  Map<String, dynamic> toMap() {
    return StaffMapper.ensureInitialized().encodeMap<Staff>(this as Staff);
  }

  StaffCopyWith<Staff, Staff, Staff> get copyWith =>
      _StaffCopyWithImpl(this as Staff, $identity, $identity);
  @override
  String toString() {
    return StaffMapper.ensureInitialized().stringifyValue(this as Staff);
  }

  @override
  bool operator ==(Object other) {
    return StaffMapper.ensureInitialized().equalsValue(this as Staff, other);
  }

  @override
  int get hashCode {
    return StaffMapper.ensureInitialized().hashValue(this as Staff);
  }
}

extension StaffValueCopy<$R, $Out> on ObjectCopyWith<$R, Staff, $Out> {
  StaffCopyWith<$R, Staff, $Out> get $asStaff =>
      $base.as((v, t, t2) => _StaffCopyWithImpl(v, t, t2));
}

abstract class StaffCopyWith<$R, $In extends Staff, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? email,
      DateTime? created,
      DateTime? updated});
  StaffCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StaffCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Staff, $Out>
    implements StaffCopyWith<$R, Staff, $Out> {
  _StaffCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Staff> $mapper = StaffMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          String? email,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (email != null) #email: email,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  Staff $make(CopyWithData data) => Staff(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  StaffCopyWith<$R2, Staff, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _StaffCopyWithImpl($value, $cast, t);
}
