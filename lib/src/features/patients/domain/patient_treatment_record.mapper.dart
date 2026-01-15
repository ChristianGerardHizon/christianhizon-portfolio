// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
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
      PatientTreatmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentRecord';

  static String _$id(PatientTreatmentRecord v) => v.id;
  static const Field<PatientTreatmentRecord, String> _f$id = Field('id', _$id);
  static String _$treatmentId(PatientTreatmentRecord v) => v.treatmentId;
  static const Field<PatientTreatmentRecord, String> _f$treatmentId = Field(
    'treatmentId',
    _$treatmentId,
  );
  static String _$patientId(PatientTreatmentRecord v) => v.patientId;
  static const Field<PatientTreatmentRecord, String> _f$patientId = Field(
    'patientId',
    _$patientId,
  );
  static PatientTreatment? _$treatment(PatientTreatmentRecord v) => v.treatment;
  static const Field<PatientTreatmentRecord, PatientTreatment> _f$treatment =
      Field('treatment', _$treatment, opt: true);
  static DateTime? _$date(PatientTreatmentRecord v) => v.date;
  static const Field<PatientTreatmentRecord, DateTime> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static String? _$notes(PatientTreatmentRecord v) => v.notes;
  static const Field<PatientTreatmentRecord, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(PatientTreatmentRecord v) => v.isDeleted;
  static const Field<PatientTreatmentRecord, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(PatientTreatmentRecord v) => v.created;
  static const Field<PatientTreatmentRecord, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(PatientTreatmentRecord v) => v.updated;
  static const Field<PatientTreatmentRecord, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientTreatmentRecord> fields = const {
    #id: _f$id,
    #treatmentId: _f$treatmentId,
    #patientId: _f$patientId,
    #treatment: _f$treatment,
    #date: _f$date,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientTreatmentRecord _instantiate(DecodingData data) {
    return PatientTreatmentRecord(
      id: data.dec(_f$id),
      treatmentId: data.dec(_f$treatmentId),
      patientId: data.dec(_f$patientId),
      treatment: data.dec(_f$treatment),
      date: data.dec(_f$date),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
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

  PatientTreatmentRecordCopyWith<
    PatientTreatmentRecord,
    PatientTreatmentRecord,
    PatientTreatmentRecord
  >
  get copyWith =>
      _PatientTreatmentRecordCopyWithImpl<
        PatientTreatmentRecord,
        PatientTreatmentRecord
      >(this as PatientTreatmentRecord, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentRecordMapper.ensureInitialized().stringifyValue(
      this as PatientTreatmentRecord,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentRecordMapper.ensureInitialized().equalsValue(
      this as PatientTreatmentRecord,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientTreatmentRecordMapper.ensureInitialized().hashValue(
      this as PatientTreatmentRecord,
    );
  }
}

extension PatientTreatmentRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentRecord, $Out> {
  PatientTreatmentRecordCopyWith<$R, PatientTreatmentRecord, $Out>
  get $asPatientTreatmentRecord => $base.as(
    (v, t, t2) => _PatientTreatmentRecordCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PatientTreatmentRecordCopyWith<
  $R,
  $In extends PatientTreatmentRecord,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>?
  get treatment;
  $R call({
    String? id,
    String? treatmentId,
    String? patientId,
    PatientTreatment? treatment,
    DateTime? date,
    String? notes,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  PatientTreatmentRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
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
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>?
  get treatment => $value.treatment?.copyWith.$chain((v) => call(treatment: v));
  @override
  $R call({
    String? id,
    String? treatmentId,
    String? patientId,
    Object? treatment = $none,
    Object? date = $none,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (treatmentId != null) #treatmentId: treatmentId,
      if (patientId != null) #patientId: patientId,
      if (treatment != $none) #treatment: treatment,
      if (date != $none) #date: date,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientTreatmentRecord $make(CopyWithData data) => PatientTreatmentRecord(
    id: data.get(#id, or: $value.id),
    treatmentId: data.get(#treatmentId, or: $value.treatmentId),
    patientId: data.get(#patientId, or: $value.patientId),
    treatment: data.get(#treatment, or: $value.treatment),
    date: data.get(#date, or: $value.date),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientTreatmentRecordCopyWith<$R2, PatientTreatmentRecord, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientTreatmentRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

