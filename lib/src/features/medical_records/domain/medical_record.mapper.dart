// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medical_record.dart';

class MedicalRecordMapper extends ClassMapperBase<MedicalRecord> {
  MedicalRecordMapper._();

  static MedicalRecordMapper? _instance;
  static MedicalRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicalRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalRecord';

  static String _$id(MedicalRecord v) => v.id;
  static const Field<MedicalRecord, String> _f$id = Field('id', _$id);
  static String _$name(MedicalRecord v) => v.name;
  static const Field<MedicalRecord, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static DateTime? _$created(MedicalRecord v) => v.created;
  static const Field<MedicalRecord, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(MedicalRecord v) => v.updated;
  static const Field<MedicalRecord, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<MedicalRecord> fields = const {
    #id: _f$id,
    #name: _f$name,
    #created: _f$created,
    #updated: _f$updated,
  };

  static MedicalRecord _instantiate(DecodingData data) {
    return MedicalRecord(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalRecord>(map);
  }

  static MedicalRecord fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalRecord>(json);
  }
}

mixin MedicalRecordMappable {
  String toJson() {
    return MedicalRecordMapper.ensureInitialized()
        .encodeJson<MedicalRecord>(this as MedicalRecord);
  }

  Map<String, dynamic> toMap() {
    return MedicalRecordMapper.ensureInitialized()
        .encodeMap<MedicalRecord>(this as MedicalRecord);
  }

  MedicalRecordCopyWith<MedicalRecord, MedicalRecord, MedicalRecord>
      get copyWith => _MedicalRecordCopyWithImpl(
          this as MedicalRecord, $identity, $identity);
  @override
  String toString() {
    return MedicalRecordMapper.ensureInitialized()
        .stringifyValue(this as MedicalRecord);
  }

  @override
  bool operator ==(Object other) {
    return MedicalRecordMapper.ensureInitialized()
        .equalsValue(this as MedicalRecord, other);
  }

  @override
  int get hashCode {
    return MedicalRecordMapper.ensureInitialized()
        .hashValue(this as MedicalRecord);
  }
}

extension MedicalRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalRecord, $Out> {
  MedicalRecordCopyWith<$R, MedicalRecord, $Out> get $asMedicalRecord =>
      $base.as((v, t, t2) => _MedicalRecordCopyWithImpl(v, t, t2));
}

abstract class MedicalRecordCopyWith<$R, $In extends MedicalRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, DateTime? created, DateTime? updated});
  MedicalRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MedicalRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalRecord, $Out>
    implements MedicalRecordCopyWith<$R, MedicalRecord, $Out> {
  _MedicalRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalRecord> $mapper =
      MedicalRecordMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  MedicalRecord $make(CopyWithData data) => MedicalRecord(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  MedicalRecordCopyWith<$R2, MedicalRecord, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MedicalRecordCopyWithImpl($value, $cast, t);
}
