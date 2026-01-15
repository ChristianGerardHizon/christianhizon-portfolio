// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_record_dto.dart';

class PatientRecordDtoMapper extends ClassMapperBase<PatientRecordDto> {
  PatientRecordDtoMapper._();

  static PatientRecordDtoMapper? _instance;
  static PatientRecordDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientRecordDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientRecordDto';

  static String _$id(PatientRecordDto v) => v.id;
  static const Field<PatientRecordDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientRecordDto v) => v.collectionId;
  static const Field<PatientRecordDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientRecordDto v) => v.collectionName;
  static const Field<PatientRecordDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$patient(PatientRecordDto v) => v.patient;
  static const Field<PatientRecordDto, String> _f$patient = Field(
    'patient',
    _$patient,
  );
  static String? _$visitDate(PatientRecordDto v) => v.visitDate;
  static const Field<PatientRecordDto, String> _f$visitDate = Field(
    'visitDate',
    _$visitDate,
    opt: true,
  );
  static String? _$diagnosis(PatientRecordDto v) => v.diagnosis;
  static const Field<PatientRecordDto, String> _f$diagnosis = Field(
    'diagnosis',
    _$diagnosis,
    opt: true,
  );
  static String? _$treatment(PatientRecordDto v) => v.treatment;
  static const Field<PatientRecordDto, String> _f$treatment = Field(
    'treatment',
    _$treatment,
    opt: true,
  );
  static String? _$notes(PatientRecordDto v) => v.notes;
  static const Field<PatientRecordDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static String? _$branch(PatientRecordDto v) => v.branch;
  static const Field<PatientRecordDto, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static String? _$appointment(PatientRecordDto v) => v.appointment;
  static const Field<PatientRecordDto, String> _f$appointment = Field(
    'appointment',
    _$appointment,
    opt: true,
  );
  static num? _$weightInKg(PatientRecordDto v) => v.weightInKg;
  static const Field<PatientRecordDto, num> _f$weightInKg = Field(
    'weightInKg',
    _$weightInKg,
    opt: true,
  );
  static String? _$tests(PatientRecordDto v) => v.tests;
  static const Field<PatientRecordDto, String> _f$tests = Field(
    'tests',
    _$tests,
    opt: true,
  );
  static String? _$temperature(PatientRecordDto v) => v.temperature;
  static const Field<PatientRecordDto, String> _f$temperature = Field(
    'temperature',
    _$temperature,
    opt: true,
  );
  static bool _$isDeleted(PatientRecordDto v) => v.isDeleted;
  static const Field<PatientRecordDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientRecordDto v) => v.created;
  static const Field<PatientRecordDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientRecordDto v) => v.updated;
  static const Field<PatientRecordDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientRecordDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #patient: _f$patient,
    #visitDate: _f$visitDate,
    #diagnosis: _f$diagnosis,
    #treatment: _f$treatment,
    #notes: _f$notes,
    #branch: _f$branch,
    #appointment: _f$appointment,
    #weightInKg: _f$weightInKg,
    #tests: _f$tests,
    #temperature: _f$temperature,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientRecordDto _instantiate(DecodingData data) {
    return PatientRecordDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      patient: data.dec(_f$patient),
      visitDate: data.dec(_f$visitDate),
      diagnosis: data.dec(_f$diagnosis),
      treatment: data.dec(_f$treatment),
      notes: data.dec(_f$notes),
      branch: data.dec(_f$branch),
      appointment: data.dec(_f$appointment),
      weightInKg: data.dec(_f$weightInKg),
      tests: data.dec(_f$tests),
      temperature: data.dec(_f$temperature),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientRecordDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientRecordDto>(map);
  }

  static PatientRecordDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientRecordDto>(json);
  }
}

mixin PatientRecordDtoMappable {
  String toJson() {
    return PatientRecordDtoMapper.ensureInitialized()
        .encodeJson<PatientRecordDto>(this as PatientRecordDto);
  }

  Map<String, dynamic> toMap() {
    return PatientRecordDtoMapper.ensureInitialized()
        .encodeMap<PatientRecordDto>(this as PatientRecordDto);
  }

  PatientRecordDtoCopyWith<PatientRecordDto, PatientRecordDto, PatientRecordDto>
  get copyWith =>
      _PatientRecordDtoCopyWithImpl<PatientRecordDto, PatientRecordDto>(
        this as PatientRecordDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientRecordDtoMapper.ensureInitialized().stringifyValue(
      this as PatientRecordDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientRecordDtoMapper.ensureInitialized().equalsValue(
      this as PatientRecordDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientRecordDtoMapper.ensureInitialized().hashValue(
      this as PatientRecordDto,
    );
  }
}

extension PatientRecordDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientRecordDto, $Out> {
  PatientRecordDtoCopyWith<$R, PatientRecordDto, $Out>
  get $asPatientRecordDto =>
      $base.as((v, t, t2) => _PatientRecordDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientRecordDtoCopyWith<$R, $In extends PatientRecordDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    String? visitDate,
    String? diagnosis,
    String? treatment,
    String? notes,
    String? branch,
    String? appointment,
    num? weightInKg,
    String? tests,
    String? temperature,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PatientRecordDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientRecordDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientRecordDto, $Out>
    implements PatientRecordDtoCopyWith<$R, PatientRecordDto, $Out> {
  _PatientRecordDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientRecordDto> $mapper =
      PatientRecordDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    Object? visitDate = $none,
    Object? diagnosis = $none,
    Object? treatment = $none,
    Object? notes = $none,
    Object? branch = $none,
    Object? appointment = $none,
    Object? weightInKg = $none,
    Object? tests = $none,
    Object? temperature = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (patient != null) #patient: patient,
      if (visitDate != $none) #visitDate: visitDate,
      if (diagnosis != $none) #diagnosis: diagnosis,
      if (treatment != $none) #treatment: treatment,
      if (notes != $none) #notes: notes,
      if (branch != $none) #branch: branch,
      if (appointment != $none) #appointment: appointment,
      if (weightInKg != $none) #weightInKg: weightInKg,
      if (tests != $none) #tests: tests,
      if (temperature != $none) #temperature: temperature,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientRecordDto $make(CopyWithData data) => PatientRecordDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    patient: data.get(#patient, or: $value.patient),
    visitDate: data.get(#visitDate, or: $value.visitDate),
    diagnosis: data.get(#diagnosis, or: $value.diagnosis),
    treatment: data.get(#treatment, or: $value.treatment),
    notes: data.get(#notes, or: $value.notes),
    branch: data.get(#branch, or: $value.branch),
    appointment: data.get(#appointment, or: $value.appointment),
    weightInKg: data.get(#weightInKg, or: $value.weightInKg),
    tests: data.get(#tests, or: $value.tests),
    temperature: data.get(#temperature, or: $value.temperature),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientRecordDtoCopyWith<$R2, PatientRecordDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientRecordDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

