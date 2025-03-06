// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vaccine_record.dart';

class VaccineRecordMapper extends ClassMapperBase<VaccineRecord> {
  VaccineRecordMapper._();

  static VaccineRecordMapper? _instance;
  static VaccineRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VaccineRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VaccineRecord';

  static String _$id(VaccineRecord v) => v.id;
  static const Field<VaccineRecord, String> _f$id = Field('id', _$id);
  static String _$type(VaccineRecord v) => v.type;
  static const Field<VaccineRecord, String> _f$type = Field('type', _$type);
  static String _$patient(VaccineRecord v) => v.patient;
  static const Field<VaccineRecord, String> _f$patient =
      Field('patient', _$patient);
  static DateTime? _$created(VaccineRecord v) => v.created;
  static const Field<VaccineRecord, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(VaccineRecord v) => v.updated;
  static const Field<VaccineRecord, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<VaccineRecord> fields = const {
    #id: _f$id,
    #type: _f$type,
    #patient: _f$patient,
    #created: _f$created,
    #updated: _f$updated,
  };

  static VaccineRecord _instantiate(DecodingData data) {
    return VaccineRecord(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        patient: data.dec(_f$patient),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static VaccineRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VaccineRecord>(map);
  }

  static VaccineRecord fromJson(String json) {
    return ensureInitialized().decodeJson<VaccineRecord>(json);
  }
}

mixin VaccineRecordMappable {
  String toJson() {
    return VaccineRecordMapper.ensureInitialized()
        .encodeJson<VaccineRecord>(this as VaccineRecord);
  }

  Map<String, dynamic> toMap() {
    return VaccineRecordMapper.ensureInitialized()
        .encodeMap<VaccineRecord>(this as VaccineRecord);
  }

  VaccineRecordCopyWith<VaccineRecord, VaccineRecord, VaccineRecord>
      get copyWith => _VaccineRecordCopyWithImpl(
          this as VaccineRecord, $identity, $identity);
  @override
  String toString() {
    return VaccineRecordMapper.ensureInitialized()
        .stringifyValue(this as VaccineRecord);
  }

  @override
  bool operator ==(Object other) {
    return VaccineRecordMapper.ensureInitialized()
        .equalsValue(this as VaccineRecord, other);
  }

  @override
  int get hashCode {
    return VaccineRecordMapper.ensureInitialized()
        .hashValue(this as VaccineRecord);
  }
}

extension VaccineRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VaccineRecord, $Out> {
  VaccineRecordCopyWith<$R, VaccineRecord, $Out> get $asVaccineRecord =>
      $base.as((v, t, t2) => _VaccineRecordCopyWithImpl(v, t, t2));
}

abstract class VaccineRecordCopyWith<$R, $In extends VaccineRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? type,
      String? patient,
      DateTime? created,
      DateTime? updated});
  VaccineRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VaccineRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VaccineRecord, $Out>
    implements VaccineRecordCopyWith<$R, VaccineRecord, $Out> {
  _VaccineRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VaccineRecord> $mapper =
      VaccineRecordMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? type,
          String? patient,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (patient != null) #patient: patient,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  VaccineRecord $make(CopyWithData data) => VaccineRecord(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      patient: data.get(#patient, or: $value.patient),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  VaccineRecordCopyWith<$R2, VaccineRecord, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VaccineRecordCopyWithImpl($value, $cast, t);
}
