// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_record.dart';

class PatientRecordMapper extends ClassMapperBase<PatientRecord> {
  PatientRecordMapper._();

  static PatientRecordMapper? _instance;
  static PatientRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientRecord';

  static String _$id(PatientRecord v) => v.id;
  static const Field<PatientRecord, String> _f$id = Field('id', _$id);
  static String _$patientId(PatientRecord v) => v.patientId;
  static const Field<PatientRecord, String> _f$patientId = Field(
    'patientId',
    _$patientId,
  );
  static DateTime _$date(PatientRecord v) => v.date;
  static const Field<PatientRecord, DateTime> _f$date = Field('date', _$date);
  static String _$diagnosis(PatientRecord v) => v.diagnosis;
  static const Field<PatientRecord, String> _f$diagnosis = Field(
    'diagnosis',
    _$diagnosis,
  );
  static String _$weight(PatientRecord v) => v.weight;
  static const Field<PatientRecord, String> _f$weight = Field(
    'weight',
    _$weight,
  );
  static String _$temperature(PatientRecord v) => v.temperature;
  static const Field<PatientRecord, String> _f$temperature = Field(
    'temperature',
    _$temperature,
  );
  static String? _$treatment(PatientRecord v) => v.treatment;
  static const Field<PatientRecord, String> _f$treatment = Field(
    'treatment',
    _$treatment,
    opt: true,
  );
  static String? _$notes(PatientRecord v) => v.notes;
  static const Field<PatientRecord, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static String? _$tests(PatientRecord v) => v.tests;
  static const Field<PatientRecord, String> _f$tests = Field(
    'tests',
    _$tests,
    opt: true,
  );
  static String? _$branch(PatientRecord v) => v.branch;
  static const Field<PatientRecord, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static bool _$isDeleted(PatientRecord v) => v.isDeleted;
  static const Field<PatientRecord, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(PatientRecord v) => v.created;
  static const Field<PatientRecord, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(PatientRecord v) => v.updated;
  static const Field<PatientRecord, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientRecord> fields = const {
    #id: _f$id,
    #patientId: _f$patientId,
    #date: _f$date,
    #diagnosis: _f$diagnosis,
    #weight: _f$weight,
    #temperature: _f$temperature,
    #treatment: _f$treatment,
    #notes: _f$notes,
    #tests: _f$tests,
    #branch: _f$branch,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientRecord _instantiate(DecodingData data) {
    return PatientRecord(
      id: data.dec(_f$id),
      patientId: data.dec(_f$patientId),
      date: data.dec(_f$date),
      diagnosis: data.dec(_f$diagnosis),
      weight: data.dec(_f$weight),
      temperature: data.dec(_f$temperature),
      treatment: data.dec(_f$treatment),
      notes: data.dec(_f$notes),
      tests: data.dec(_f$tests),
      branch: data.dec(_f$branch),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientRecord>(map);
  }

  static PatientRecord fromJson(String json) {
    return ensureInitialized().decodeJson<PatientRecord>(json);
  }
}

mixin PatientRecordMappable {
  String toJson() {
    return PatientRecordMapper.ensureInitialized().encodeJson<PatientRecord>(
      this as PatientRecord,
    );
  }

  Map<String, dynamic> toMap() {
    return PatientRecordMapper.ensureInitialized().encodeMap<PatientRecord>(
      this as PatientRecord,
    );
  }

  PatientRecordCopyWith<PatientRecord, PatientRecord, PatientRecord>
  get copyWith => _PatientRecordCopyWithImpl<PatientRecord, PatientRecord>(
    this as PatientRecord,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PatientRecordMapper.ensureInitialized().stringifyValue(
      this as PatientRecord,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientRecordMapper.ensureInitialized().equalsValue(
      this as PatientRecord,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientRecordMapper.ensureInitialized().hashValue(
      this as PatientRecord,
    );
  }
}

extension PatientRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientRecord, $Out> {
  PatientRecordCopyWith<$R, PatientRecord, $Out> get $asPatientRecord =>
      $base.as((v, t, t2) => _PatientRecordCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientRecordCopyWith<$R, $In extends PatientRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? patientId,
    DateTime? date,
    String? diagnosis,
    String? weight,
    String? temperature,
    String? treatment,
    String? notes,
    String? tests,
    String? branch,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  PatientRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientRecord, $Out>
    implements PatientRecordCopyWith<$R, PatientRecord, $Out> {
  _PatientRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientRecord> $mapper =
      PatientRecordMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? patientId,
    DateTime? date,
    String? diagnosis,
    String? weight,
    String? temperature,
    Object? treatment = $none,
    Object? notes = $none,
    Object? tests = $none,
    Object? branch = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (patientId != null) #patientId: patientId,
      if (date != null) #date: date,
      if (diagnosis != null) #diagnosis: diagnosis,
      if (weight != null) #weight: weight,
      if (temperature != null) #temperature: temperature,
      if (treatment != $none) #treatment: treatment,
      if (notes != $none) #notes: notes,
      if (tests != $none) #tests: tests,
      if (branch != $none) #branch: branch,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientRecord $make(CopyWithData data) => PatientRecord(
    id: data.get(#id, or: $value.id),
    patientId: data.get(#patientId, or: $value.patientId),
    date: data.get(#date, or: $value.date),
    diagnosis: data.get(#diagnosis, or: $value.diagnosis),
    weight: data.get(#weight, or: $value.weight),
    temperature: data.get(#temperature, or: $value.temperature),
    treatment: data.get(#treatment, or: $value.treatment),
    notes: data.get(#notes, or: $value.notes),
    tests: data.get(#tests, or: $value.tests),
    branch: data.get(#branch, or: $value.branch),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientRecordCopyWith<$R2, PatientRecord, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

