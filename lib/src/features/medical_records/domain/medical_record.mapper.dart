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
  static String _$patient(MedicalRecord v) => v.patient;
  static const Field<MedicalRecord, String> _f$patient =
      Field('patient', _$patient);
  static DateTime? _$created(MedicalRecord v) => v.created;
  static const Field<MedicalRecord, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(MedicalRecord v) => v.updated;
  static const Field<MedicalRecord, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static bool _$isDeleted(MedicalRecord v) => v.isDeleted;
  static const Field<MedicalRecord, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static String? _$diagnosis(MedicalRecord v) => v.diagnosis;
  static const Field<MedicalRecord, String> _f$diagnosis =
      Field('diagnosis', _$diagnosis, opt: true);
  static DateTime _$visitDate(MedicalRecord v) => v.visitDate;
  static const Field<MedicalRecord, DateTime> _f$visitDate =
      Field('visitDate', _$visitDate);
  static String? _$treatment(MedicalRecord v) => v.treatment;
  static const Field<MedicalRecord, String> _f$treatment =
      Field('treatment', _$treatment, opt: true);
  static DateTime? _$followUpDate(MedicalRecord v) => v.followUpDate;
  static const Field<MedicalRecord, DateTime> _f$followUpDate =
      Field('followUpDate', _$followUpDate, opt: true);
  static String? _$note(MedicalRecord v) => v.note;
  static const Field<MedicalRecord, String> _f$note =
      Field('note', _$note, opt: true);

  @override
  final MappableFields<MedicalRecord> fields = const {
    #id: _f$id,
    #patient: _f$patient,
    #created: _f$created,
    #updated: _f$updated,
    #isDeleted: _f$isDeleted,
    #diagnosis: _f$diagnosis,
    #visitDate: _f$visitDate,
    #treatment: _f$treatment,
    #followUpDate: _f$followUpDate,
    #note: _f$note,
  };

  static MedicalRecord _instantiate(DecodingData data) {
    return MedicalRecord(
        id: data.dec(_f$id),
        patient: data.dec(_f$patient),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        isDeleted: data.dec(_f$isDeleted),
        diagnosis: data.dec(_f$diagnosis),
        visitDate: data.dec(_f$visitDate),
        treatment: data.dec(_f$treatment),
        followUpDate: data.dec(_f$followUpDate),
        note: data.dec(_f$note));
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
  $R call(
      {String? id,
      String? patient,
      DateTime? created,
      DateTime? updated,
      bool? isDeleted,
      String? diagnosis,
      DateTime? visitDate,
      String? treatment,
      DateTime? followUpDate,
      String? note});
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
          String? patient,
          Object? created = $none,
          Object? updated = $none,
          bool? isDeleted,
          Object? diagnosis = $none,
          DateTime? visitDate,
          Object? treatment = $none,
          Object? followUpDate = $none,
          Object? note = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (patient != null) #patient: patient,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (diagnosis != $none) #diagnosis: diagnosis,
        if (visitDate != null) #visitDate: visitDate,
        if (treatment != $none) #treatment: treatment,
        if (followUpDate != $none) #followUpDate: followUpDate,
        if (note != $none) #note: note
      }));
  @override
  MedicalRecord $make(CopyWithData data) => MedicalRecord(
      id: data.get(#id, or: $value.id),
      patient: data.get(#patient, or: $value.patient),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      diagnosis: data.get(#diagnosis, or: $value.diagnosis),
      visitDate: data.get(#visitDate, or: $value.visitDate),
      treatment: data.get(#treatment, or: $value.treatment),
      followUpDate: data.get(#followUpDate, or: $value.followUpDate),
      note: data.get(#note, or: $value.note));

  @override
  MedicalRecordCopyWith<$R2, MedicalRecord, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MedicalRecordCopyWithImpl($value, $cast, t);
}
