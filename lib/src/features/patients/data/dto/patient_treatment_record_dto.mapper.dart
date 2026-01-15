// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_treatment_record_dto.dart';

class PatientTreatmentRecordDtoMapper
    extends ClassMapperBase<PatientTreatmentRecordDto> {
  PatientTreatmentRecordDtoMapper._();

  static PatientTreatmentRecordDtoMapper? _instance;
  static PatientTreatmentRecordDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = PatientTreatmentRecordDtoMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentRecordDto';

  static String _$id(PatientTreatmentRecordDto v) => v.id;
  static const Field<PatientTreatmentRecordDto, String> _f$id = Field(
    'id',
    _$id,
  );
  static String _$collectionId(PatientTreatmentRecordDto v) => v.collectionId;
  static const Field<PatientTreatmentRecordDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientTreatmentRecordDto v) =>
      v.collectionName;
  static const Field<PatientTreatmentRecordDto, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$treatment(PatientTreatmentRecordDto v) => v.treatment;
  static const Field<PatientTreatmentRecordDto, String> _f$treatment = Field(
    'treatment',
    _$treatment,
  );
  static String _$patient(PatientTreatmentRecordDto v) => v.patient;
  static const Field<PatientTreatmentRecordDto, String> _f$patient = Field(
    'patient',
    _$patient,
  );
  static String? _$date(PatientTreatmentRecordDto v) => v.date;
  static const Field<PatientTreatmentRecordDto, String> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static String? _$notes(PatientTreatmentRecordDto v) => v.notes;
  static const Field<PatientTreatmentRecordDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(PatientTreatmentRecordDto v) => v.isDeleted;
  static const Field<PatientTreatmentRecordDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientTreatmentRecordDto v) => v.created;
  static const Field<PatientTreatmentRecordDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientTreatmentRecordDto v) => v.updated;
  static const Field<PatientTreatmentRecordDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static String? _$expandedTreatmentId(PatientTreatmentRecordDto v) =>
      v.expandedTreatmentId;
  static const Field<PatientTreatmentRecordDto, String> _f$expandedTreatmentId =
      Field('expandedTreatmentId', _$expandedTreatmentId, opt: true);
  static String? _$expandedTreatmentName(PatientTreatmentRecordDto v) =>
      v.expandedTreatmentName;
  static const Field<PatientTreatmentRecordDto, String>
  _f$expandedTreatmentName = Field(
    'expandedTreatmentName',
    _$expandedTreatmentName,
    opt: true,
  );
  static String? _$expandedTreatmentIcon(PatientTreatmentRecordDto v) =>
      v.expandedTreatmentIcon;
  static const Field<PatientTreatmentRecordDto, String>
  _f$expandedTreatmentIcon = Field(
    'expandedTreatmentIcon',
    _$expandedTreatmentIcon,
    opt: true,
  );

  @override
  final MappableFields<PatientTreatmentRecordDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #treatment: _f$treatment,
    #patient: _f$patient,
    #date: _f$date,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expandedTreatmentId: _f$expandedTreatmentId,
    #expandedTreatmentName: _f$expandedTreatmentName,
    #expandedTreatmentIcon: _f$expandedTreatmentIcon,
  };

  static PatientTreatmentRecordDto _instantiate(DecodingData data) {
    return PatientTreatmentRecordDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      treatment: data.dec(_f$treatment),
      patient: data.dec(_f$patient),
      date: data.dec(_f$date),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      expandedTreatmentId: data.dec(_f$expandedTreatmentId),
      expandedTreatmentName: data.dec(_f$expandedTreatmentName),
      expandedTreatmentIcon: data.dec(_f$expandedTreatmentIcon),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatmentRecordDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatmentRecordDto>(map);
  }

  static PatientTreatmentRecordDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatmentRecordDto>(json);
  }
}

mixin PatientTreatmentRecordDtoMappable {
  String toJson() {
    return PatientTreatmentRecordDtoMapper.ensureInitialized()
        .encodeJson<PatientTreatmentRecordDto>(
          this as PatientTreatmentRecordDto,
        );
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentRecordDtoMapper.ensureInitialized()
        .encodeMap<PatientTreatmentRecordDto>(
          this as PatientTreatmentRecordDto,
        );
  }

  PatientTreatmentRecordDtoCopyWith<
    PatientTreatmentRecordDto,
    PatientTreatmentRecordDto,
    PatientTreatmentRecordDto
  >
  get copyWith =>
      _PatientTreatmentRecordDtoCopyWithImpl<
        PatientTreatmentRecordDto,
        PatientTreatmentRecordDto
      >(this as PatientTreatmentRecordDto, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentRecordDtoMapper.ensureInitialized().stringifyValue(
      this as PatientTreatmentRecordDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentRecordDtoMapper.ensureInitialized().equalsValue(
      this as PatientTreatmentRecordDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientTreatmentRecordDtoMapper.ensureInitialized().hashValue(
      this as PatientTreatmentRecordDto,
    );
  }
}

extension PatientTreatmentRecordDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentRecordDto, $Out> {
  PatientTreatmentRecordDtoCopyWith<$R, PatientTreatmentRecordDto, $Out>
  get $asPatientTreatmentRecordDto => $base.as(
    (v, t, t2) => _PatientTreatmentRecordDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PatientTreatmentRecordDtoCopyWith<
  $R,
  $In extends PatientTreatmentRecordDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? treatment,
    String? patient,
    String? date,
    String? notes,
    bool? isDeleted,
    String? created,
    String? updated,
    String? expandedTreatmentId,
    String? expandedTreatmentName,
    String? expandedTreatmentIcon,
  });
  PatientTreatmentRecordDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientTreatmentRecordDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatmentRecordDto, $Out>
    implements
        PatientTreatmentRecordDtoCopyWith<$R, PatientTreatmentRecordDto, $Out> {
  _PatientTreatmentRecordDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientTreatmentRecordDto> $mapper =
      PatientTreatmentRecordDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? treatment,
    String? patient,
    Object? date = $none,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? expandedTreatmentId = $none,
    Object? expandedTreatmentName = $none,
    Object? expandedTreatmentIcon = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (treatment != null) #treatment: treatment,
      if (patient != null) #patient: patient,
      if (date != $none) #date: date,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (expandedTreatmentId != $none)
        #expandedTreatmentId: expandedTreatmentId,
      if (expandedTreatmentName != $none)
        #expandedTreatmentName: expandedTreatmentName,
      if (expandedTreatmentIcon != $none)
        #expandedTreatmentIcon: expandedTreatmentIcon,
    }),
  );
  @override
  PatientTreatmentRecordDto $make(CopyWithData data) =>
      PatientTreatmentRecordDto(
        id: data.get(#id, or: $value.id),
        collectionId: data.get(#collectionId, or: $value.collectionId),
        collectionName: data.get(#collectionName, or: $value.collectionName),
        treatment: data.get(#treatment, or: $value.treatment),
        patient: data.get(#patient, or: $value.patient),
        date: data.get(#date, or: $value.date),
        notes: data.get(#notes, or: $value.notes),
        isDeleted: data.get(#isDeleted, or: $value.isDeleted),
        created: data.get(#created, or: $value.created),
        updated: data.get(#updated, or: $value.updated),
        expandedTreatmentId: data.get(
          #expandedTreatmentId,
          or: $value.expandedTreatmentId,
        ),
        expandedTreatmentName: data.get(
          #expandedTreatmentName,
          or: $value.expandedTreatmentName,
        ),
        expandedTreatmentIcon: data.get(
          #expandedTreatmentIcon,
          or: $value.expandedTreatmentIcon,
        ),
      );

  @override
  PatientTreatmentRecordDtoCopyWith<$R2, PatientTreatmentRecordDto, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientTreatmentRecordDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

