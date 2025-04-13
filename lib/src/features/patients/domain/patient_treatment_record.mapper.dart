// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_treatment_record.dart';

class PatientTreatmentRecordMapper
    extends ClassMapperBase<PatientTreatmentRecord> {
  PatientTreatmentRecordMapper._();

  static PatientTreatmentRecordMapper? _instance;
  static PatientTreatmentRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientTreatmentRecordMapper._());
      PbRecordMapper.ensureInitialized();
      PatientTreatmentRecordExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentRecord';

  static String _$id(PatientTreatmentRecord v) => v.id;
  static const Field<PatientTreatmentRecord, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientTreatmentRecord v) => v.collectionId;
  static const Field<PatientTreatmentRecord, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(PatientTreatmentRecord v) => v.collectionName;
  static const Field<PatientTreatmentRecord, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$type(PatientTreatmentRecord v) => v.type;
  static const Field<PatientTreatmentRecord, String> _f$type =
      Field('type', _$type);
  static String _$patient(PatientTreatmentRecord v) => v.patient;
  static const Field<PatientTreatmentRecord, String> _f$patient =
      Field('patient', _$patient);
  static DateTime? _$followUpDate(PatientTreatmentRecord v) => v.followUpDate;
  static const Field<PatientTreatmentRecord, DateTime> _f$followUpDate =
      Field('followUpDate', _$followUpDate, opt: true);
  static DateTime? _$date(PatientTreatmentRecord v) => v.date;
  static const Field<PatientTreatmentRecord, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static String? _$notes(PatientTreatmentRecord v) => v.notes;
  static const Field<PatientTreatmentRecord, String> _f$notes =
      Field('notes', _$notes, opt: true);
  static PatientTreatmentRecordExpand? _$expand(PatientTreatmentRecord v) =>
      v.expand;
  static const Field<PatientTreatmentRecord, PatientTreatmentRecordExpand>
      _f$expand = Field('expand', _$expand, opt: true);
  static bool _$isDeleted(PatientTreatmentRecord v) => v.isDeleted;
  static const Field<PatientTreatmentRecord, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(PatientTreatmentRecord v) => v.created;
  static const Field<PatientTreatmentRecord, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(PatientTreatmentRecord v) => v.updated;
  static const Field<PatientTreatmentRecord, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<PatientTreatmentRecord> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #type: _f$type,
    #patient: _f$patient,
    #followUpDate: _f$followUpDate,
    #date: _f$date,
    #notes: _f$notes,
    #expand: _f$expand,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientTreatmentRecord _instantiate(DecodingData data) {
    return PatientTreatmentRecord(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        type: data.dec(_f$type),
        patient: data.dec(_f$patient),
        followUpDate: data.dec(_f$followUpDate),
        date: data.dec(_f$date),
        notes: data.dec(_f$notes),
        expand: data.dec(_f$expand),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatmentRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatmentRecord>(map);
  }

  static PatientTreatmentRecord fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatmentRecord>(json);
  }
}

mixin PatientTreatmentRecordMappable {
  String toJson() {
    return PatientTreatmentRecordMapper.ensureInitialized()
        .encodeJson<PatientTreatmentRecord>(this as PatientTreatmentRecord);
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentRecordMapper.ensureInitialized()
        .encodeMap<PatientTreatmentRecord>(this as PatientTreatmentRecord);
  }

  PatientTreatmentRecordCopyWith<PatientTreatmentRecord, PatientTreatmentRecord,
          PatientTreatmentRecord>
      get copyWith => _PatientTreatmentRecordCopyWithImpl<
              PatientTreatmentRecord, PatientTreatmentRecord>(
          this as PatientTreatmentRecord, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentRecordMapper.ensureInitialized()
        .stringifyValue(this as PatientTreatmentRecord);
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentRecordMapper.ensureInitialized()
        .equalsValue(this as PatientTreatmentRecord, other);
  }

  @override
  int get hashCode {
    return PatientTreatmentRecordMapper.ensureInitialized()
        .hashValue(this as PatientTreatmentRecord);
  }
}

extension PatientTreatmentRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentRecord, $Out> {
  PatientTreatmentRecordCopyWith<$R, PatientTreatmentRecord, $Out>
      get $asPatientTreatmentRecord => $base.as((v, t, t2) =>
          _PatientTreatmentRecordCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientTreatmentRecordCopyWith<
    $R,
    $In extends PatientTreatmentRecord,
    $Out> implements PbRecordCopyWith<$R, $In, $Out> {
  PatientTreatmentRecordExpandCopyWith<$R, PatientTreatmentRecordExpand,
      PatientTreatmentRecordExpand>? get expand;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? type,
      String? patient,
      DateTime? followUpDate,
      DateTime? date,
      String? notes,
      PatientTreatmentRecordExpand? expand,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  PatientTreatmentRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientTreatmentRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatmentRecord, $Out>
    implements
        PatientTreatmentRecordCopyWith<$R, PatientTreatmentRecord, $Out> {
  _PatientTreatmentRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientTreatmentRecord> $mapper =
      PatientTreatmentRecordMapper.ensureInitialized();
  @override
  PatientTreatmentRecordExpandCopyWith<$R, PatientTreatmentRecordExpand,
          PatientTreatmentRecordExpand>?
      get expand => $value.expand?.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? type,
          String? patient,
          Object? followUpDate = $none,
          Object? date = $none,
          Object? notes = $none,
          Object? expand = $none,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (type != null) #type: type,
        if (patient != null) #patient: patient,
        if (followUpDate != $none) #followUpDate: followUpDate,
        if (date != $none) #date: date,
        if (notes != $none) #notes: notes,
        if (expand != $none) #expand: expand,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  PatientTreatmentRecord $make(CopyWithData data) => PatientTreatmentRecord(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      type: data.get(#type, or: $value.type),
      patient: data.get(#patient, or: $value.patient),
      followUpDate: data.get(#followUpDate, or: $value.followUpDate),
      date: data.get(#date, or: $value.date),
      notes: data.get(#notes, or: $value.notes),
      expand: data.get(#expand, or: $value.expand),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PatientTreatmentRecordCopyWith<$R2, PatientTreatmentRecord, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatientTreatmentRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PatientTreatmentRecordExpandMapper
    extends ClassMapperBase<PatientTreatmentRecordExpand> {
  PatientTreatmentRecordExpandMapper._();

  static PatientTreatmentRecordExpandMapper? _instance;
  static PatientTreatmentRecordExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PatientTreatmentRecordExpandMapper._());
      PatientTreatmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentRecordExpand';

  static PatientTreatment? _$type(PatientTreatmentRecordExpand v) => v.type;
  static const Field<PatientTreatmentRecordExpand, PatientTreatment> _f$type =
      Field('type', _$type, opt: true);

  @override
  final MappableFields<PatientTreatmentRecordExpand> fields = const {
    #type: _f$type,
  };

  static PatientTreatmentRecordExpand _instantiate(DecodingData data) {
    return PatientTreatmentRecordExpand(type: data.dec(_f$type));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatmentRecordExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatmentRecordExpand>(map);
  }

  static PatientTreatmentRecordExpand fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatmentRecordExpand>(json);
  }
}

mixin PatientTreatmentRecordExpandMappable {
  String toJson() {
    return PatientTreatmentRecordExpandMapper.ensureInitialized()
        .encodeJson<PatientTreatmentRecordExpand>(
            this as PatientTreatmentRecordExpand);
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentRecordExpandMapper.ensureInitialized()
        .encodeMap<PatientTreatmentRecordExpand>(
            this as PatientTreatmentRecordExpand);
  }

  PatientTreatmentRecordExpandCopyWith<PatientTreatmentRecordExpand,
          PatientTreatmentRecordExpand, PatientTreatmentRecordExpand>
      get copyWith => _PatientTreatmentRecordExpandCopyWithImpl<
              PatientTreatmentRecordExpand, PatientTreatmentRecordExpand>(
          this as PatientTreatmentRecordExpand, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentRecordExpandMapper.ensureInitialized()
        .stringifyValue(this as PatientTreatmentRecordExpand);
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentRecordExpandMapper.ensureInitialized()
        .equalsValue(this as PatientTreatmentRecordExpand, other);
  }

  @override
  int get hashCode {
    return PatientTreatmentRecordExpandMapper.ensureInitialized()
        .hashValue(this as PatientTreatmentRecordExpand);
  }
}

extension PatientTreatmentRecordExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentRecordExpand, $Out> {
  PatientTreatmentRecordExpandCopyWith<$R, PatientTreatmentRecordExpand, $Out>
      get $asPatientTreatmentRecordExpand => $base.as((v, t, t2) =>
          _PatientTreatmentRecordExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientTreatmentRecordExpandCopyWith<
    $R,
    $In extends PatientTreatmentRecordExpand,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>? get type;
  $R call({PatientTreatment? type});
  PatientTreatmentRecordExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientTreatmentRecordExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatmentRecordExpand, $Out>
    implements
        PatientTreatmentRecordExpandCopyWith<$R, PatientTreatmentRecordExpand,
            $Out> {
  _PatientTreatmentRecordExpandCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientTreatmentRecordExpand> $mapper =
      PatientTreatmentRecordExpandMapper.ensureInitialized();
  @override
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>? get type =>
      $value.type?.copyWith.$chain((v) => call(type: v));
  @override
  $R call({Object? type = $none}) =>
      $apply(FieldCopyWithData({if (type != $none) #type: type}));
  @override
  PatientTreatmentRecordExpand $make(CopyWithData data) =>
      PatientTreatmentRecordExpand(type: data.get(#type, or: $value.type));

  @override
  PatientTreatmentRecordExpandCopyWith<$R2, PatientTreatmentRecordExpand, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatientTreatmentRecordExpandCopyWithImpl<$R2, $Out2>(
              $value, $cast, t);
}
