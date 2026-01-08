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
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientRecord';

  static String _$id(PatientRecord v) => v.id;
  static const Field<PatientRecord, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientRecord v) => v.collectionId;
  static const Field<PatientRecord, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientRecord v) => v.collectionName;
  static const Field<PatientRecord, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$patient(PatientRecord v) => v.patient;
  static const Field<PatientRecord, String> _f$patient = Field(
    'patient',
    _$patient,
  );
  static String? _$diagnosis(PatientRecord v) => v.diagnosis;
  static const Field<PatientRecord, String> _f$diagnosis = Field(
    'diagnosis',
    _$diagnosis,
    opt: true,
  );
  static DateTime _$visitDate(PatientRecord v) => v.visitDate;
  static const Field<PatientRecord, DateTime> _f$visitDate = Field(
    'visitDate',
    _$visitDate,
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
  static num? _$weightInKg(PatientRecord v) => v.weightInKg;
  static const Field<PatientRecord, num> _f$weightInKg = Field(
    'weightInKg',
    _$weightInKg,
    opt: true,
    hook: PbNumHook(),
  );
  static String? _$branch(PatientRecord v) => v.branch;
  static const Field<PatientRecord, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
    hook: PbEmptyHook(),
  );
  static String? _$tests(PatientRecord v) => v.tests;
  static const Field<PatientRecord, String> _f$tests = Field(
    'tests',
    _$tests,
    opt: true,
  );
  static String? _$temperature(PatientRecord v) => v.temperature;
  static const Field<PatientRecord, String> _f$temperature = Field(
    'temperature',
    _$temperature,
    opt: true,
  );

  @override
  final MappableFields<PatientRecord> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #patient: _f$patient,
    #diagnosis: _f$diagnosis,
    #visitDate: _f$visitDate,
    #treatment: _f$treatment,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #weightInKg: _f$weightInKg,
    #branch: _f$branch,
    #tests: _f$tests,
    #temperature: _f$temperature,
  };

  static PatientRecord _instantiate(DecodingData data) {
    return PatientRecord(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      patient: data.dec(_f$patient),
      diagnosis: data.dec(_f$diagnosis),
      visitDate: data.dec(_f$visitDate),
      treatment: data.dec(_f$treatment),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      weightInKg: data.dec(_f$weightInKg),
      branch: data.dec(_f$branch),
      tests: data.dec(_f$tests),
      temperature: data.dec(_f$temperature),
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
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    String? diagnosis,
    DateTime? visitDate,
    String? treatment,
    String? notes,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    num? weightInKg,
    String? branch,
    String? tests,
    String? temperature,
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
    String? collectionId,
    String? collectionName,
    String? patient,
    Object? diagnosis = $none,
    DateTime? visitDate,
    Object? treatment = $none,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? weightInKg = $none,
    Object? branch = $none,
    Object? tests = $none,
    Object? temperature = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (patient != null) #patient: patient,
      if (diagnosis != $none) #diagnosis: diagnosis,
      if (visitDate != null) #visitDate: visitDate,
      if (treatment != $none) #treatment: treatment,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (weightInKg != $none) #weightInKg: weightInKg,
      if (branch != $none) #branch: branch,
      if (tests != $none) #tests: tests,
      if (temperature != $none) #temperature: temperature,
    }),
  );
  @override
  PatientRecord $make(CopyWithData data) => PatientRecord(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    patient: data.get(#patient, or: $value.patient),
    diagnosis: data.get(#diagnosis, or: $value.diagnosis),
    visitDate: data.get(#visitDate, or: $value.visitDate),
    treatment: data.get(#treatment, or: $value.treatment),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    weightInKg: data.get(#weightInKg, or: $value.weightInKg),
    branch: data.get(#branch, or: $value.branch),
    tests: data.get(#tests, or: $value.tests),
    temperature: data.get(#temperature, or: $value.temperature),
  );

  @override
  PatientRecordCopyWith<$R2, PatientRecord, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

