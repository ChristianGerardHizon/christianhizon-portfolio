// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_record.dart';

class TreatmentRecordMapper extends ClassMapperBase<TreatmentRecord> {
  TreatmentRecordMapper._();

  static TreatmentRecordMapper? _instance;
  static TreatmentRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentRecord';

  static String _$id(TreatmentRecord v) => v.id;
  static const Field<TreatmentRecord, String> _f$id = Field('id', _$id);
  static String _$type(TreatmentRecord v) => v.type;
  static const Field<TreatmentRecord, String> _f$type = Field('type', _$type);
  static String _$patient(TreatmentRecord v) => v.patient;
  static const Field<TreatmentRecord, String> _f$patient =
      Field('patient', _$patient);
  static DateTime? _$created(TreatmentRecord v) => v.created;
  static const Field<TreatmentRecord, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(TreatmentRecord v) => v.updated;
  static const Field<TreatmentRecord, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<TreatmentRecord> fields = const {
    #id: _f$id,
    #type: _f$type,
    #patient: _f$patient,
    #created: _f$created,
    #updated: _f$updated,
  };

  static TreatmentRecord _instantiate(DecodingData data) {
    return TreatmentRecord(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        patient: data.dec(_f$patient),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentRecord>(map);
  }

  static TreatmentRecord fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentRecord>(json);
  }
}

mixin TreatmentRecordMappable {
  String toJson() {
    return TreatmentRecordMapper.ensureInitialized()
        .encodeJson<TreatmentRecord>(this as TreatmentRecord);
  }

  Map<String, dynamic> toMap() {
    return TreatmentRecordMapper.ensureInitialized()
        .encodeMap<TreatmentRecord>(this as TreatmentRecord);
  }

  TreatmentRecordCopyWith<TreatmentRecord, TreatmentRecord, TreatmentRecord>
      get copyWith => _TreatmentRecordCopyWithImpl(
          this as TreatmentRecord, $identity, $identity);
  @override
  String toString() {
    return TreatmentRecordMapper.ensureInitialized()
        .stringifyValue(this as TreatmentRecord);
  }

  @override
  bool operator ==(Object other) {
    return TreatmentRecordMapper.ensureInitialized()
        .equalsValue(this as TreatmentRecord, other);
  }

  @override
  int get hashCode {
    return TreatmentRecordMapper.ensureInitialized()
        .hashValue(this as TreatmentRecord);
  }
}

extension TreatmentRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentRecord, $Out> {
  TreatmentRecordCopyWith<$R, TreatmentRecord, $Out> get $asTreatmentRecord =>
      $base.as((v, t, t2) => _TreatmentRecordCopyWithImpl(v, t, t2));
}

abstract class TreatmentRecordCopyWith<$R, $In extends TreatmentRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? type,
      String? patient,
      DateTime? created,
      DateTime? updated});
  TreatmentRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TreatmentRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentRecord, $Out>
    implements TreatmentRecordCopyWith<$R, TreatmentRecord, $Out> {
  _TreatmentRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentRecord> $mapper =
      TreatmentRecordMapper.ensureInitialized();
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
  TreatmentRecord $make(CopyWithData data) => TreatmentRecord(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      patient: data.get(#patient, or: $value.patient),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  TreatmentRecordCopyWith<$R2, TreatmentRecord, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TreatmentRecordCopyWithImpl($value, $cast, t);
}
