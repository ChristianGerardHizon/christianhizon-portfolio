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
      TreatmentRecordExpandMapper.ensureInitialized();
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
  static DateTime? _$followUpDate(TreatmentRecord v) => v.followUpDate;
  static const Field<TreatmentRecord, DateTime> _f$followUpDate =
      Field('followUpDate', _$followUpDate, opt: true);
  static DateTime? _$date(TreatmentRecord v) => v.date;
  static const Field<TreatmentRecord, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static String? _$notes(TreatmentRecord v) => v.notes;
  static const Field<TreatmentRecord, String> _f$notes =
      Field('notes', _$notes, opt: true);
  static TreatmentRecordExpand? _$expand(TreatmentRecord v) => v.expand;
  static const Field<TreatmentRecord, TreatmentRecordExpand> _f$expand =
      Field('expand', _$expand, opt: true);
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
    #followUpDate: _f$followUpDate,
    #date: _f$date,
    #notes: _f$notes,
    #expand: _f$expand,
    #created: _f$created,
    #updated: _f$updated,
  };

  static TreatmentRecord _instantiate(DecodingData data) {
    return TreatmentRecord(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        patient: data.dec(_f$patient),
        followUpDate: data.dec(_f$followUpDate),
        date: data.dec(_f$date),
        notes: data.dec(_f$notes),
        expand: data.dec(_f$expand),
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
      get copyWith =>
          _TreatmentRecordCopyWithImpl<TreatmentRecord, TreatmentRecord>(
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
      $base.as((v, t, t2) => _TreatmentRecordCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TreatmentRecordCopyWith<$R, $In extends TreatmentRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TreatmentRecordExpandCopyWith<$R, TreatmentRecordExpand,
      TreatmentRecordExpand>? get expand;
  $R call(
      {String? id,
      String? type,
      String? patient,
      DateTime? followUpDate,
      DateTime? date,
      String? notes,
      TreatmentRecordExpand? expand,
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
  TreatmentRecordExpandCopyWith<$R, TreatmentRecordExpand,
          TreatmentRecordExpand>?
      get expand => $value.expand?.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? type,
          String? patient,
          Object? followUpDate = $none,
          Object? date = $none,
          Object? notes = $none,
          Object? expand = $none,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (patient != null) #patient: patient,
        if (followUpDate != $none) #followUpDate: followUpDate,
        if (date != $none) #date: date,
        if (notes != $none) #notes: notes,
        if (expand != $none) #expand: expand,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  TreatmentRecord $make(CopyWithData data) => TreatmentRecord(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      patient: data.get(#patient, or: $value.patient),
      followUpDate: data.get(#followUpDate, or: $value.followUpDate),
      date: data.get(#date, or: $value.date),
      notes: data.get(#notes, or: $value.notes),
      expand: data.get(#expand, or: $value.expand),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  TreatmentRecordCopyWith<$R2, TreatmentRecord, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TreatmentRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TreatmentRecordExpandMapper
    extends ClassMapperBase<TreatmentRecordExpand> {
  TreatmentRecordExpandMapper._();

  static TreatmentRecordExpandMapper? _instance;
  static TreatmentRecordExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentRecordExpandMapper._());
      TreatmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentRecordExpand';

  static Treatment? _$type(TreatmentRecordExpand v) => v.type;
  static const Field<TreatmentRecordExpand, Treatment> _f$type =
      Field('type', _$type, opt: true);

  @override
  final MappableFields<TreatmentRecordExpand> fields = const {
    #type: _f$type,
  };

  static TreatmentRecordExpand _instantiate(DecodingData data) {
    return TreatmentRecordExpand(type: data.dec(_f$type));
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentRecordExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentRecordExpand>(map);
  }

  static TreatmentRecordExpand fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentRecordExpand>(json);
  }
}

mixin TreatmentRecordExpandMappable {
  String toJson() {
    return TreatmentRecordExpandMapper.ensureInitialized()
        .encodeJson<TreatmentRecordExpand>(this as TreatmentRecordExpand);
  }

  Map<String, dynamic> toMap() {
    return TreatmentRecordExpandMapper.ensureInitialized()
        .encodeMap<TreatmentRecordExpand>(this as TreatmentRecordExpand);
  }

  TreatmentRecordExpandCopyWith<TreatmentRecordExpand, TreatmentRecordExpand,
      TreatmentRecordExpand> get copyWith => _TreatmentRecordExpandCopyWithImpl<
          TreatmentRecordExpand, TreatmentRecordExpand>(
      this as TreatmentRecordExpand, $identity, $identity);
  @override
  String toString() {
    return TreatmentRecordExpandMapper.ensureInitialized()
        .stringifyValue(this as TreatmentRecordExpand);
  }

  @override
  bool operator ==(Object other) {
    return TreatmentRecordExpandMapper.ensureInitialized()
        .equalsValue(this as TreatmentRecordExpand, other);
  }

  @override
  int get hashCode {
    return TreatmentRecordExpandMapper.ensureInitialized()
        .hashValue(this as TreatmentRecordExpand);
  }
}

extension TreatmentRecordExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentRecordExpand, $Out> {
  TreatmentRecordExpandCopyWith<$R, TreatmentRecordExpand, $Out>
      get $asTreatmentRecordExpand => $base.as(
          (v, t, t2) => _TreatmentRecordExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TreatmentRecordExpandCopyWith<
    $R,
    $In extends TreatmentRecordExpand,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  TreatmentCopyWith<$R, Treatment, Treatment>? get type;
  $R call({Treatment? type});
  TreatmentRecordExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TreatmentRecordExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentRecordExpand, $Out>
    implements TreatmentRecordExpandCopyWith<$R, TreatmentRecordExpand, $Out> {
  _TreatmentRecordExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentRecordExpand> $mapper =
      TreatmentRecordExpandMapper.ensureInitialized();
  @override
  TreatmentCopyWith<$R, Treatment, Treatment>? get type =>
      $value.type?.copyWith.$chain((v) => call(type: v));
  @override
  $R call({Object? type = $none}) =>
      $apply(FieldCopyWithData({if (type != $none) #type: type}));
  @override
  TreatmentRecordExpand $make(CopyWithData data) =>
      TreatmentRecordExpand(type: data.get(#type, or: $value.type));

  @override
  TreatmentRecordExpandCopyWith<$R2, TreatmentRecordExpand, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TreatmentRecordExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
