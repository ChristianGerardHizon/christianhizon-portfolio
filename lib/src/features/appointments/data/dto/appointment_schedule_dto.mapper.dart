// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_schedule_dto.dart';

class AppointmentScheduleDtoMapper
    extends ClassMapperBase<AppointmentScheduleDto> {
  AppointmentScheduleDtoMapper._();

  static AppointmentScheduleDtoMapper? _instance;
  static AppointmentScheduleDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentScheduleDtoMapper._());
      PatientRecordMapper.ensureInitialized();
      PatientTreatmentRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentScheduleDto';

  static String _$id(AppointmentScheduleDto v) => v.id;
  static const Field<AppointmentScheduleDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(AppointmentScheduleDto v) => v.collectionId;
  static const Field<AppointmentScheduleDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(AppointmentScheduleDto v) => v.collectionName;
  static const Field<AppointmentScheduleDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String? _$date(AppointmentScheduleDto v) => v.date;
  static const Field<AppointmentScheduleDto, String> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static bool _$hasTime(AppointmentScheduleDto v) => v.hasTime;
  static const Field<AppointmentScheduleDto, bool> _f$hasTime = Field(
    'hasTime',
    _$hasTime,
    opt: true,
    def: true,
  );
  static String? _$notes(AppointmentScheduleDto v) => v.notes;
  static const Field<AppointmentScheduleDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static String? _$purpose(AppointmentScheduleDto v) => v.purpose;
  static const Field<AppointmentScheduleDto, String> _f$purpose = Field(
    'purpose',
    _$purpose,
    opt: true,
  );
  static String? _$status(AppointmentScheduleDto v) => v.status;
  static const Field<AppointmentScheduleDto, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$patient(AppointmentScheduleDto v) => v.patient;
  static const Field<AppointmentScheduleDto, String> _f$patient = Field(
    'patient',
    _$patient,
    opt: true,
  );
  static List<String> _$patientRecords(AppointmentScheduleDto v) =>
      v.patientRecords;
  static const Field<AppointmentScheduleDto, List<String>> _f$patientRecords =
      Field('patientRecords', _$patientRecords, opt: true, def: const []);
  static List<String> _$treatmentRecords(AppointmentScheduleDto v) =>
      v.treatmentRecords;
  static const Field<AppointmentScheduleDto, List<String>> _f$treatmentRecords =
      Field('treatmentRecords', _$treatmentRecords, opt: true, def: const []);
  static String? _$branch(AppointmentScheduleDto v) => v.branch;
  static const Field<AppointmentScheduleDto, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static String? _$patientName(AppointmentScheduleDto v) => v.patientName;
  static const Field<AppointmentScheduleDto, String> _f$patientName = Field(
    'patientName',
    _$patientName,
    opt: true,
  );
  static String? _$ownerName(AppointmentScheduleDto v) => v.ownerName;
  static const Field<AppointmentScheduleDto, String> _f$ownerName = Field(
    'ownerName',
    _$ownerName,
    opt: true,
  );
  static String? _$ownerContact(AppointmentScheduleDto v) => v.ownerContact;
  static const Field<AppointmentScheduleDto, String> _f$ownerContact = Field(
    'ownerContact',
    _$ownerContact,
    opt: true,
  );
  static bool _$isDeleted(AppointmentScheduleDto v) => v.isDeleted;
  static const Field<AppointmentScheduleDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(AppointmentScheduleDto v) => v.created;
  static const Field<AppointmentScheduleDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(AppointmentScheduleDto v) => v.updated;
  static const Field<AppointmentScheduleDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static String? _$expandedPatientName(AppointmentScheduleDto v) =>
      v.expandedPatientName;
  static const Field<AppointmentScheduleDto, String> _f$expandedPatientName =
      Field('expandedPatientName', _$expandedPatientName, opt: true);
  static String? _$expandedPatientOwner(AppointmentScheduleDto v) =>
      v.expandedPatientOwner;
  static const Field<AppointmentScheduleDto, String> _f$expandedPatientOwner =
      Field('expandedPatientOwner', _$expandedPatientOwner, opt: true);
  static String? _$expandedPatientContact(AppointmentScheduleDto v) =>
      v.expandedPatientContact;
  static const Field<AppointmentScheduleDto, String> _f$expandedPatientContact =
      Field('expandedPatientContact', _$expandedPatientContact, opt: true);
  static String? _$expandedPatientSpecies(AppointmentScheduleDto v) =>
      v.expandedPatientSpecies;
  static const Field<AppointmentScheduleDto, String> _f$expandedPatientSpecies =
      Field('expandedPatientSpecies', _$expandedPatientSpecies, opt: true);
  static String? _$expandedPatientBreed(AppointmentScheduleDto v) =>
      v.expandedPatientBreed;
  static const Field<AppointmentScheduleDto, String> _f$expandedPatientBreed =
      Field('expandedPatientBreed', _$expandedPatientBreed, opt: true);
  static List<PatientRecord> _$expandedPatientRecords(
    AppointmentScheduleDto v,
  ) => v.expandedPatientRecords;
  static const Field<AppointmentScheduleDto, List<PatientRecord>>
  _f$expandedPatientRecords = Field(
    'expandedPatientRecords',
    _$expandedPatientRecords,
    opt: true,
    def: const [],
  );
  static List<PatientTreatmentRecord> _$expandedTreatmentRecords(
    AppointmentScheduleDto v,
  ) => v.expandedTreatmentRecords;
  static const Field<AppointmentScheduleDto, List<PatientTreatmentRecord>>
  _f$expandedTreatmentRecords = Field(
    'expandedTreatmentRecords',
    _$expandedTreatmentRecords,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<AppointmentScheduleDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #date: _f$date,
    #hasTime: _f$hasTime,
    #notes: _f$notes,
    #purpose: _f$purpose,
    #status: _f$status,
    #patient: _f$patient,
    #patientRecords: _f$patientRecords,
    #treatmentRecords: _f$treatmentRecords,
    #branch: _f$branch,
    #patientName: _f$patientName,
    #ownerName: _f$ownerName,
    #ownerContact: _f$ownerContact,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expandedPatientName: _f$expandedPatientName,
    #expandedPatientOwner: _f$expandedPatientOwner,
    #expandedPatientContact: _f$expandedPatientContact,
    #expandedPatientSpecies: _f$expandedPatientSpecies,
    #expandedPatientBreed: _f$expandedPatientBreed,
    #expandedPatientRecords: _f$expandedPatientRecords,
    #expandedTreatmentRecords: _f$expandedTreatmentRecords,
  };

  static AppointmentScheduleDto _instantiate(DecodingData data) {
    return AppointmentScheduleDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      date: data.dec(_f$date),
      hasTime: data.dec(_f$hasTime),
      notes: data.dec(_f$notes),
      purpose: data.dec(_f$purpose),
      status: data.dec(_f$status),
      patient: data.dec(_f$patient),
      patientRecords: data.dec(_f$patientRecords),
      treatmentRecords: data.dec(_f$treatmentRecords),
      branch: data.dec(_f$branch),
      patientName: data.dec(_f$patientName),
      ownerName: data.dec(_f$ownerName),
      ownerContact: data.dec(_f$ownerContact),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      expandedPatientName: data.dec(_f$expandedPatientName),
      expandedPatientOwner: data.dec(_f$expandedPatientOwner),
      expandedPatientContact: data.dec(_f$expandedPatientContact),
      expandedPatientSpecies: data.dec(_f$expandedPatientSpecies),
      expandedPatientBreed: data.dec(_f$expandedPatientBreed),
      expandedPatientRecords: data.dec(_f$expandedPatientRecords),
      expandedTreatmentRecords: data.dec(_f$expandedTreatmentRecords),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentScheduleDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentScheduleDto>(map);
  }

  static AppointmentScheduleDto fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentScheduleDto>(json);
  }
}

mixin AppointmentScheduleDtoMappable {
  String toJson() {
    return AppointmentScheduleDtoMapper.ensureInitialized()
        .encodeJson<AppointmentScheduleDto>(this as AppointmentScheduleDto);
  }

  Map<String, dynamic> toMap() {
    return AppointmentScheduleDtoMapper.ensureInitialized()
        .encodeMap<AppointmentScheduleDto>(this as AppointmentScheduleDto);
  }

  AppointmentScheduleDtoCopyWith<
    AppointmentScheduleDto,
    AppointmentScheduleDto,
    AppointmentScheduleDto
  >
  get copyWith =>
      _AppointmentScheduleDtoCopyWithImpl<
        AppointmentScheduleDto,
        AppointmentScheduleDto
      >(this as AppointmentScheduleDto, $identity, $identity);
  @override
  String toString() {
    return AppointmentScheduleDtoMapper.ensureInitialized().stringifyValue(
      this as AppointmentScheduleDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentScheduleDtoMapper.ensureInitialized().equalsValue(
      this as AppointmentScheduleDto,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentScheduleDtoMapper.ensureInitialized().hashValue(
      this as AppointmentScheduleDto,
    );
  }
}

extension AppointmentScheduleDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentScheduleDto, $Out> {
  AppointmentScheduleDtoCopyWith<$R, AppointmentScheduleDto, $Out>
  get $asAppointmentScheduleDto => $base.as(
    (v, t, t2) => _AppointmentScheduleDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentScheduleDtoCopyWith<
  $R,
  $In extends AppointmentScheduleDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get patientRecords;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get treatmentRecords;
  ListCopyWith<
    $R,
    PatientRecord,
    PatientRecordCopyWith<$R, PatientRecord, PatientRecord>
  >
  get expandedPatientRecords;
  ListCopyWith<
    $R,
    PatientTreatmentRecord,
    PatientTreatmentRecordCopyWith<
      $R,
      PatientTreatmentRecord,
      PatientTreatmentRecord
    >
  >
  get expandedTreatmentRecords;
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? date,
    bool? hasTime,
    String? notes,
    String? purpose,
    String? status,
    String? patient,
    List<String>? patientRecords,
    List<String>? treatmentRecords,
    String? branch,
    String? patientName,
    String? ownerName,
    String? ownerContact,
    bool? isDeleted,
    String? created,
    String? updated,
    String? expandedPatientName,
    String? expandedPatientOwner,
    String? expandedPatientContact,
    String? expandedPatientSpecies,
    String? expandedPatientBreed,
    List<PatientRecord>? expandedPatientRecords,
    List<PatientTreatmentRecord>? expandedTreatmentRecords,
  });
  AppointmentScheduleDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentScheduleDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentScheduleDto, $Out>
    implements
        AppointmentScheduleDtoCopyWith<$R, AppointmentScheduleDto, $Out> {
  _AppointmentScheduleDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentScheduleDto> $mapper =
      AppointmentScheduleDtoMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get patientRecords => ListCopyWith(
    $value.patientRecords,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(patientRecords: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get treatmentRecords => ListCopyWith(
    $value.treatmentRecords,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(treatmentRecords: v),
  );
  @override
  ListCopyWith<
    $R,
    PatientRecord,
    PatientRecordCopyWith<$R, PatientRecord, PatientRecord>
  >
  get expandedPatientRecords => ListCopyWith(
    $value.expandedPatientRecords,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(expandedPatientRecords: v),
  );
  @override
  ListCopyWith<
    $R,
    PatientTreatmentRecord,
    PatientTreatmentRecordCopyWith<
      $R,
      PatientTreatmentRecord,
      PatientTreatmentRecord
    >
  >
  get expandedTreatmentRecords => ListCopyWith(
    $value.expandedTreatmentRecords,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(expandedTreatmentRecords: v),
  );
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    Object? date = $none,
    bool? hasTime,
    Object? notes = $none,
    Object? purpose = $none,
    Object? status = $none,
    Object? patient = $none,
    List<String>? patientRecords,
    List<String>? treatmentRecords,
    Object? branch = $none,
    Object? patientName = $none,
    Object? ownerName = $none,
    Object? ownerContact = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? expandedPatientName = $none,
    Object? expandedPatientOwner = $none,
    Object? expandedPatientContact = $none,
    Object? expandedPatientSpecies = $none,
    Object? expandedPatientBreed = $none,
    List<PatientRecord>? expandedPatientRecords,
    List<PatientTreatmentRecord>? expandedTreatmentRecords,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (date != $none) #date: date,
      if (hasTime != null) #hasTime: hasTime,
      if (notes != $none) #notes: notes,
      if (purpose != $none) #purpose: purpose,
      if (status != $none) #status: status,
      if (patient != $none) #patient: patient,
      if (patientRecords != null) #patientRecords: patientRecords,
      if (treatmentRecords != null) #treatmentRecords: treatmentRecords,
      if (branch != $none) #branch: branch,
      if (patientName != $none) #patientName: patientName,
      if (ownerName != $none) #ownerName: ownerName,
      if (ownerContact != $none) #ownerContact: ownerContact,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (expandedPatientName != $none)
        #expandedPatientName: expandedPatientName,
      if (expandedPatientOwner != $none)
        #expandedPatientOwner: expandedPatientOwner,
      if (expandedPatientContact != $none)
        #expandedPatientContact: expandedPatientContact,
      if (expandedPatientSpecies != $none)
        #expandedPatientSpecies: expandedPatientSpecies,
      if (expandedPatientBreed != $none)
        #expandedPatientBreed: expandedPatientBreed,
      if (expandedPatientRecords != null)
        #expandedPatientRecords: expandedPatientRecords,
      if (expandedTreatmentRecords != null)
        #expandedTreatmentRecords: expandedTreatmentRecords,
    }),
  );
  @override
  AppointmentScheduleDto $make(CopyWithData data) => AppointmentScheduleDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    date: data.get(#date, or: $value.date),
    hasTime: data.get(#hasTime, or: $value.hasTime),
    notes: data.get(#notes, or: $value.notes),
    purpose: data.get(#purpose, or: $value.purpose),
    status: data.get(#status, or: $value.status),
    patient: data.get(#patient, or: $value.patient),
    patientRecords: data.get(#patientRecords, or: $value.patientRecords),
    treatmentRecords: data.get(#treatmentRecords, or: $value.treatmentRecords),
    branch: data.get(#branch, or: $value.branch),
    patientName: data.get(#patientName, or: $value.patientName),
    ownerName: data.get(#ownerName, or: $value.ownerName),
    ownerContact: data.get(#ownerContact, or: $value.ownerContact),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    expandedPatientName: data.get(
      #expandedPatientName,
      or: $value.expandedPatientName,
    ),
    expandedPatientOwner: data.get(
      #expandedPatientOwner,
      or: $value.expandedPatientOwner,
    ),
    expandedPatientContact: data.get(
      #expandedPatientContact,
      or: $value.expandedPatientContact,
    ),
    expandedPatientSpecies: data.get(
      #expandedPatientSpecies,
      or: $value.expandedPatientSpecies,
    ),
    expandedPatientBreed: data.get(
      #expandedPatientBreed,
      or: $value.expandedPatientBreed,
    ),
    expandedPatientRecords: data.get(
      #expandedPatientRecords,
      or: $value.expandedPatientRecords,
    ),
    expandedTreatmentRecords: data.get(
      #expandedTreatmentRecords,
      or: $value.expandedTreatmentRecords,
    ),
  );

  @override
  AppointmentScheduleDtoCopyWith<$R2, AppointmentScheduleDto, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentScheduleDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

